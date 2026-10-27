# frozen_string_literal: true
#
# iOS ana ekran widget hedefini (Plan2meWidget) Runner.xcodeproj'a ekler.
# Tekrar çalıştırılırsa hedef zaten varsa hiçbir şey yapmaz.
#
# Çalıştırma (CocoaPods ile gelen xcodeproj gem'i kullanılır):
#   GEM_HOME="$(brew --prefix cocoapods)/libexec" "$(brew --prefix ruby)/bin/ruby" tool/ios/add_widget_target.rb

require 'xcodeproj'

ROOT = File.expand_path('../../ios', __dir__)
NAME = 'Plan2meWidget'
BUNDLE_ID = 'krx.plan2me.app.Plan2meWidget'
DEPLOYMENT_TARGET = '17.0'

project = Xcodeproj::Project.open(File.join(ROOT, 'Runner.xcodeproj'))
if project.targets.any? { |t| t.name == NAME }
  puts "#{NAME} hedefi zaten var, değişiklik yapılmadı."
  exit 0
end

runner = project.targets.find { |t| t.name == 'Runner' }
team = runner.build_configurations.map { |c| c.build_settings['DEVELOPMENT_TEAM'] }.compact.first

# --- Dosya grubu
group = project.main_group.new_group(NAME, NAME)
swift_ref = group.new_reference('Plan2meWidget.swift')
group.new_reference('Info.plist')
group.new_reference('Plan2meWidget.entitlements')
xcconfig_ref = group.new_reference('Widget.xcconfig')

# --- Hedef
target = project.new_target(:app_extension, NAME, :ios, DEPLOYMENT_TARGET, nil, :swift)
target.add_build_configuration('Profile', :release) unless target.build_configurations.any? { |c| c.name == 'Profile' }
target.add_file_references([swift_ref])

target.build_configurations.each do |config|
  config.base_configuration_reference = xcconfig_ref
  s = config.build_settings
  s['PRODUCT_NAME'] = '$(TARGET_NAME)'
  s['PRODUCT_BUNDLE_IDENTIFIER'] = BUNDLE_ID
  s['INFOPLIST_FILE'] = "#{NAME}/Info.plist"
  s['GENERATE_INFOPLIST_FILE'] = 'NO'
  s['CODE_SIGN_ENTITLEMENTS'] = "#{NAME}/#{NAME}.entitlements"
  s['CODE_SIGN_STYLE'] = 'Automatic'
  s['DEVELOPMENT_TEAM'] = team if team
  s['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  s['SWIFT_VERSION'] = '5.0'
  s['TARGETED_DEVICE_FAMILY'] = '1,2'
  s['SKIP_INSTALL'] = 'YES'
  s['SWIFT_EMIT_LOC_STRINGS'] = 'YES'
  s['LD_RUNPATH_SEARCH_PATHS'] = ['$(inherited)', '@executable_path/Frameworks', '@executable_path/../../Frameworks']
  if config.name == 'Debug'
    s['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
    s['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
  end
end

# --- Runner: App Group yetkisi
runner_group = project.main_group.children.find { |g| g.display_name == 'Runner' }
runner_group.new_reference('Runner.entitlements') unless runner_group.files.any? { |f| f.path == 'Runner.entitlements' }
runner.build_configurations.each do |config|
  config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Runner.entitlements'
end

# --- Runner: widget'ı göm ve bağımlılık ekle
runner.add_dependency(target)
embed = runner.new_copy_files_build_phase('Embed Foundation Extensions')
embed.symbol_dst_subfolder_spec = :plug_ins
build_file = embed.add_file_reference(target.product_reference, true)
build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }

# Flutter'ın "Thin Binary" betiğinden ÖNCE olmalı; aksi halde Xcode
# "Cycle inside Runner" hatası verir.
runner.build_phases.delete(embed)
thin = runner.build_phases.index { |p| p.respond_to?(:name) && p.name == 'Thin Binary' }
runner.build_phases.insert(thin || runner.build_phases.length, embed)

project.save
puts "#{NAME} hedefi eklendi (#{BUNDLE_ID}, iOS #{DEPLOYMENT_TARGET}+, takım: #{team || 'yok'})."
