import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings.freezed.dart';
part 'reminder_settings.g.dart';

@freezed
abstract class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    @Default(false) bool enabled,
    @Default(9) int hour,
    @Default(0) int minute,
    @Default(true) bool dayBefore,
    @Default(true) bool dailyDigest,
  }) = _ReminderSettings;

  factory ReminderSettings.fromJson(Map<String, dynamic> json) =>
      _$ReminderSettingsFromJson(json);
}
