// plan2me ana ekran / kilit ekranı widget'ı.
//
// Veri kaynağı: Flutter tarafı (lib/features/home_widget) özet JSON'u App Group
// UserDefaults'una yazar ve bu widget'ın zaman çizelgesini yeniler.
// JSON şeması lib/features/home_widget/domain/widget_snapshot.dart ile aynıdır.

import SwiftUI
import WidgetKit

// MARK: - Sabitler

private let appGroupId = "group.krx.plan2me.app"
private let snapshotKey = "snapshot"
private let widgetKind = "Plan2meWidget"

// MARK: - Model

struct Snapshot: Codable {
    let v: Int
    let generatedAt: String
    let stats: Stats
    let activeDueDates: [String]
    let projects: [WProject]
    let cards: [WCard]

    struct Stats: Codable {
        let active: Int
        let inProgress: Int
        let openCards: Int
        let doneCards: Int
    }

    static func load() -> Snapshot? {
        guard let json = UserDefaults(suiteName: appGroupId)?.string(forKey: snapshotKey),
              let data = json.data(using: .utf8)
        else { return nil }
        return try? JSONDecoder().decode(Snapshot.self, from: data)
    }

    /// Bugüne göre gecikmiş açık proje sayısı (render anında hesaplanır).
    func overdueCount(now: Date) -> Int {
        activeDueDates.compactMap { Dates.days(until: $0, from: now) }.filter { $0 < 0 }.count
    }

    /// Önümüzdeki 7 gün içinde son tarihi olan açık proje sayısı.
    func dueThisWeekCount(now: Date) -> Int {
        activeDueDates.compactMap { Dates.days(until: $0, from: now) }.filter { (0...7).contains($0) }.count
    }
}

struct WProject: Codable, Identifiable {
    let id: String
    let title: String
    let status: String
    let statusLabel: String
    let priority: String
    let priorityLabel: String
    let priorityColor: String
    let due: String?
    let done: Int
    let total: Int

    var progress: Double { total == 0 ? 0 : Double(done) / Double(total) }
    var url: URL { DeepLink.project(id) }
}

struct WCard: Codable, Identifiable {
    let id: String
    let projectId: String
    let projectTitle: String
    let title: String
    let priority: String
    let priorityColor: String
    let due: String

    var url: URL { DeepLink.card(projectId: projectId, cardId: id) }
}

// MARK: - Yardımcılar

enum DeepLink {
    static let projects = URL(string: "plan2me://app/projects")!
    static let newProject = URL(string: "plan2me://app/projects/new")!
    static func project(_ id: String) -> URL { URL(string: "plan2me://app/projects/\(id)")! }
    static func card(projectId: String, cardId: String) -> URL {
        URL(string: "plan2me://app/projects/\(projectId)/board/cards/\(cardId)")!
    }
}

enum Dates {
    private static let parser: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = .current
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    /// Bugünden [s] tarihine kalan gün (negatif = gecikmiş).
    static func days(until s: String, from now: Date) -> Int? {
        guard let date = parser.date(from: s) else { return nil }
        let cal = Calendar.current
        return cal.dateComponents([.day], from: cal.startOfDay(for: now), to: cal.startOfDay(for: date)).day
    }

    static func relative(_ s: String?, now: Date) -> String? {
        guard let s, let n = days(until: s, from: now) else { return nil }
        switch n {
        case 0: return "Bugün"
        case 1: return "Yarın"
        case ..<0: return "\(-n) gün gecikti"
        default: return "\(n) gün kaldı"
        }
    }

    static func isOverdue(_ s: String?, now: Date) -> Bool {
        guard let s, let n = days(until: s, from: now) else { return false }
        return n < 0
    }
}

extension Color {
    init(hex: String) {
        let clean = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var value: UInt64 = 0
        Scanner(string: clean).scanHexInt64(&value)
        self.init(
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255
        )
    }
}

/// Uygulamanın "liquid" teması ile uyumlu renkler (lib/core/theme).
struct Palette {
    let backgroundTop: Color
    let backgroundBottom: Color
    let glow: Color
    let glass: Color
    let glassBorder: Color
    let text: Color
    let secondary: Color
    let accent: Color
    let danger: Color
    let warning: Color

    static func of(_ scheme: ColorScheme) -> Palette { scheme == .dark ? dark : light }

    static let light = Palette(
        backgroundTop: Color(hex: "#EEF8C6"),
        backgroundBottom: Color(hex: "#CBE58A"),
        glow: Color(hex: "#FFE266"),
        glass: Color.white.opacity(0.55),
        glassBorder: Color.white.opacity(0.8),
        text: Color(hex: "#1B1F14"),
        secondary: Color(hex: "#4A5240"),
        accent: Color(hex: "#4E7A0B"),
        danger: Color(hex: "#D64541"),
        warning: Color(hex: "#B08A12")
    )

    static let dark = Palette(
        backgroundTop: Color(hex: "#24321A"),
        backgroundBottom: Color(hex: "#0F140C"),
        glow: Color(hex: "#4F4410"),
        glass: Color.white.opacity(0.08),
        glassBorder: Color.white.opacity(0.14),
        text: Color(hex: "#E3E9D8"),
        secondary: Color(hex: "#BFC8AE"),
        accent: Color(hex: "#B8E356"),
        danger: Color(hex: "#FF6B66"),
        warning: Color(hex: "#E9C552")
    )
}

// MARK: - Zaman çizelgesi

struct Entry: TimelineEntry {
    let date: Date
    let snapshot: Snapshot?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry { Entry(date: .now, snapshot: .sample) }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry(date: .now, snapshot: context.isPreview ? (Snapshot.load() ?? .sample) : Snapshot.load()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let now = Date.now
        // Göreli tarihler ("2 gün kaldı") gece yarısı değişir; o an yenile.
        // Veri değişince Flutter tarafı ayrıca anında yeniler.
        let midnight = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: now))!
        completion(Timeline(entries: [Entry(date: now, snapshot: Snapshot.load())], policy: .after(midnight.addingTimeInterval(60))))
    }
}

// MARK: - Ortak görünümler

struct GlassTile<Content: View>: View {
    let palette: Palette
    var padding: CGFloat = 10
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(palette.glass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(palette.glassBorder, lineWidth: 1)
                    )
            )
    }
}

struct Brand: View {
    let palette: Palette

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "rectangle.split.3x1.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(palette.accent)
            Text("plan2me")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(palette.text)
        }
    }
}

struct StatChip: View {
    let icon: String
    let value: Int
    let label: String
    let color: Color
    let palette: Palette

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 10, weight: .bold))
            Text("\(value)").font(.system(size: 12, weight: .bold, design: .rounded))
            Text(label).font(.system(size: 10, weight: .medium)).lineLimit(1)
        }
        .foregroundStyle(color)
        .padding(.horizontal, 7)
        .padding(.vertical, 4)
        .background(Capsule().fill(color.opacity(0.14)))
    }
}

struct ProjectRow: View {
    let project: WProject
    let now: Date
    let palette: Palette
    var showProgress = true

    var body: some View {
        Link(destination: project.url) {
            ProjectRowContent(project: project, now: now, palette: palette, showProgress: showProgress)
        }
    }
}

struct ProjectRowContent: View {
    let project: WProject
    let now: Date
    let palette: Palette
    var showProgress = true

    var body: some View {
            HStack(alignment: .center, spacing: 8) {
                Capsule()
                    .fill(Color(hex: project.priorityColor))
                    .frame(width: 4)
                VStack(alignment: .leading, spacing: 2) {
                    Text(project.title)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(palette.text)
                        .lineLimit(1)
                    HStack(spacing: 4) {
                        Text(project.statusLabel)
                        if let due = Dates.relative(project.due, now: now) {
                            Text("·")
                            Text(due)
                                .foregroundStyle(Dates.isOverdue(project.due, now: now) ? palette.danger : palette.secondary)
                        }
                    }
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(palette.secondary)
                    .lineLimit(1)
                    if showProgress && project.total > 0 {
                        ProgressBar(value: project.progress, palette: palette)
                            .padding(.top, 2)
                    }
                }
                Spacer(minLength: 0)
                if project.total > 0 {
                    Text("\(project.done)/\(project.total)")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(palette.secondary)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// İnce kapsül ilerleme çubuğu (ProgressView yerine; her bağlamda aynı görünür).
struct ProgressBar: View {
    let value: Double
    let palette: Palette

    var body: some View {
        Capsule()
            .fill(palette.accent.opacity(0.18))
            .frame(height: 4)
            .overlay(alignment: .leading) {
                GeometryReader { geo in
                    Capsule()
                        .fill(palette.accent)
                        .frame(width: max(4, geo.size.width * min(max(value, 0), 1)))
                }
            }
    }
}

struct CardRow: View {
    let card: WCard
    let now: Date
    let palette: Palette

    var body: some View {
        Link(destination: card.url) {
            CardRowContent(card: card, now: now, palette: palette)
        }
    }
}

struct CardRowContent: View {
    let card: WCard
    let now: Date
    let palette: Palette

    var body: some View {
            HStack(spacing: 8) {
                Circle().fill(Color(hex: card.priorityColor)).frame(width: 7, height: 7)
                VStack(alignment: .leading, spacing: 1) {
                    Text(card.title)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(palette.text)
                        .lineLimit(1)
                    Text(card.projectTitle)
                        .font(.system(size: 10))
                        .foregroundStyle(palette.secondary)
                        .lineLimit(1)
                }
                Spacer(minLength: 4)
                if let due = Dates.relative(card.due, now: now) {
                    Text(due)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Dates.isOverdue(card.due, now: now) ? palette.danger : palette.secondary)
                        .lineLimit(1)
                }
            }
    }
}

struct EmptyStateView: View {
    let palette: Palette
    var compact = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Brand(palette: palette)
            Spacer(minLength: 0)
            Image(systemName: "plus.circle.fill")
                .font(.system(size: compact ? 26 : 30))
                .foregroundStyle(palette.accent)
            Text("Henüz proje yok")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(palette.text)
            Text("Dokun, ilk projeni oluştur.")
                .font(.system(size: 11))
                .foregroundStyle(palette.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .widgetURL(DeepLink.newProject)
    }
}

// MARK: - Boyutlara göre görünümler

struct SmallView: View {
    let s: Snapshot
    let now: Date
    let palette: Palette

    var body: some View {
        let overdue = s.overdueCount(now: now)
        VStack(alignment: .leading, spacing: 4) {
            Brand(palette: palette)
            Spacer(minLength: 0)
            Text("\(s.stats.active)")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundStyle(palette.text)
                .contentTransition(.numericText())
            Text("aktif proje")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(palette.secondary)
            Spacer(minLength: 0)
            if overdue > 0 {
                StatChip(icon: "exclamationmark.triangle.fill", value: overdue, label: "gecikmiş", color: palette.danger, palette: palette)
            } else {
                StatChip(icon: "calendar", value: s.dueThisWeekCount(now: now), label: "bu hafta", color: palette.accent, palette: palette)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .widgetURL(s.projects.first?.url ?? DeepLink.projects)
    }
}

struct StatsColumn: View {
    let s: Snapshot
    let now: Date
    let palette: Palette

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Brand(palette: palette)
            Spacer(minLength: 0)
            Text("\(s.stats.active)")
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(palette.text)
            Text("aktif proje")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(palette.secondary)
            Spacer(minLength: 0)
            StatChip(icon: "exclamationmark.triangle.fill", value: s.overdueCount(now: now), label: "gecikmiş", color: palette.danger, palette: palette)
            StatChip(icon: "calendar", value: s.dueThisWeekCount(now: now), label: "bu hafta", color: palette.accent, palette: palette)
        }
    }
}

struct MediumView: View {
    let s: Snapshot
    let now: Date
    let palette: Palette

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            StatsColumn(s: s, now: now, palette: palette)
                .frame(width: 104, alignment: .leading)
            GlassTile(palette: palette, padding: 10) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(s.projects.prefix(3)) { p in
                        ProjectRow(project: p, now: now, palette: palette, showProgress: false)
                    }
                    if s.projects.isEmpty {
                        Text("Açık proje yok").font(.system(size: 12)).foregroundStyle(palette.secondary)
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .widgetURL(DeepLink.projects)
    }
}

struct LargeView: View {
    let s: Snapshot
    let now: Date
    let palette: Palette

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Brand(palette: palette)
                Spacer()
                Text("\(s.stats.active) aktif")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(palette.secondary)
            }
            HStack(spacing: 8) {
                StatChip(icon: "exclamationmark.triangle.fill", value: s.overdueCount(now: now), label: "gecikmiş", color: palette.danger, palette: palette)
                StatChip(icon: "calendar", value: s.dueThisWeekCount(now: now), label: "bu hafta", color: palette.accent, palette: palette)
                StatChip(icon: "bolt.fill", value: s.stats.inProgress, label: "devam", color: palette.warning, palette: palette)
            }
            GlassTile(palette: palette) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Öncelikli projeler")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(palette.secondary)
                    ForEach(s.projects.prefix(s.cards.isEmpty ? 4 : 2)) { p in
                        ProjectRow(project: p, now: now, palette: palette)
                    }
                }
            }
            GlassTile(palette: palette) {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Yaklaşan kartlar")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(palette.secondary)
                    if s.cards.isEmpty {
                        Text("Son tarihi yaklaşan kart yok 🎉")
                            .font(.system(size: 12))
                            .foregroundStyle(palette.secondary)
                    }
                    ForEach(s.cards.prefix(3)) { c in
                        CardRow(card: c, now: now, palette: palette)
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .widgetURL(DeepLink.projects)
    }
}

// MARK: - Kilit ekranı

struct CircularView: View {
    let s: Snapshot?
    let now: Date

    var body: some View {
        let overdue = s?.overdueCount(now: now) ?? 0
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 0) {
                Image(systemName: overdue > 0 ? "exclamationmark.triangle.fill" : "rectangle.split.3x1.fill")
                    .font(.system(size: 11, weight: .bold))
                Text("\(overdue > 0 ? overdue : (s?.stats.active ?? 0))")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
        .widgetURL(DeepLink.projects)
    }
}

struct RectangularView: View {
    let s: Snapshot?
    let now: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("plan2me · \(s?.stats.active ?? 0) aktif")
                .font(.system(size: 12, weight: .bold))
            if let p = s?.projects.first {
                Text(p.title).font(.system(size: 13, weight: .semibold)).lineLimit(1)
                Text([p.statusLabel, Dates.relative(p.due, now: now)].compactMap { $0 }.joined(separator: " · "))
                    .font(.system(size: 11))
                    .lineLimit(1)
            } else {
                Text("Henüz proje yok").font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .widgetURL(s?.projects.first?.url ?? DeepLink.projects)
    }
}

// MARK: - Widget

struct Plan2meWidgetView: View {
    @Environment(\.widgetFamily) private var family
    @Environment(\.colorScheme) private var colorScheme
    let entry: Entry

    var body: some View {
        let palette = Palette.of(colorScheme)
        Group {
            switch family {
            case .accessoryCircular:
                CircularView(s: entry.snapshot, now: entry.date)
            case .accessoryRectangular:
                RectangularView(s: entry.snapshot, now: entry.date)
            case .accessoryInline:
                Text("\(entry.snapshot?.stats.active ?? 0) aktif · \(entry.snapshot?.overdueCount(now: entry.date) ?? 0) gecikmiş")
            default:
                if let s = entry.snapshot, s.stats.active > 0 {
                    switch family {
                    case .systemSmall: SmallView(s: s, now: entry.date, palette: palette)
                    case .systemLarge, .systemExtraLarge: LargeView(s: s, now: entry.date, palette: palette)
                    default: MediumView(s: s, now: entry.date, palette: palette)
                    }
                } else {
                    EmptyStateView(palette: palette, compact: family == .systemSmall)
                }
            }
        }
        .containerBackground(for: .widget) {
            if family.isAccessory {
                Color.clear
            } else {
                LiquidBackground(palette: palette)
            }
        }
    }
}

struct LiquidBackground: View {
    let palette: Palette

    var body: some View {
        // Parıltı overlay'de: zeminin boyutunu büyütmez, sadece üstüne çizilir.
        LinearGradient(colors: [palette.backgroundTop, palette.backgroundBottom], startPoint: .topLeading, endPoint: .bottomTrailing)
            .overlay(alignment: .topTrailing) {
                Circle()
                    .fill(palette.glow.opacity(0.55))
                    .frame(width: 200, height: 200)
                    .blur(radius: 60)
                    .offset(x: 70, y: -80)
            }
            .clipped()
    }
}

extension WidgetFamily {
    var isAccessory: Bool {
        self == .accessoryCircular || self == .accessoryRectangular || self == .accessoryInline
    }
}

struct Plan2meWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: widgetKind, provider: Provider()) { entry in
            Plan2meWidgetView(entry: entry)
        }
        .configurationDisplayName("plan2me")
        .description("Öncelikli projelerin, gecikmeler ve yaklaşan kartlar.")
        .supportedFamilies([
            .systemSmall, .systemMedium, .systemLarge,
            .accessoryCircular, .accessoryRectangular, .accessoryInline,
        ])
    }
}

@main
struct Plan2meWidgetBundle: WidgetBundle {
    var body: some Widget {
        Plan2meWidget()
    }
}

// MARK: - Önizleme verisi

extension Snapshot {
    static let sample: Snapshot = {
        let cal = Calendar.current
        func day(_ offset: Int) -> String {
            let d = cal.date(byAdding: .day, value: offset, to: .now)!
            let c = cal.dateComponents([.year, .month, .day], from: d)
            return String(format: "%04d-%02d-%02d", c.year!, c.month!, c.day!)
        }
        return Snapshot(
            v: 1,
            generatedAt: "",
            stats: Stats(active: 4, inProgress: 1, openCards: 5, doneCards: 2),
            activeDueDates: [day(-2), day(12), day(30)],
            projects: [
                WProject(id: "1", title: "Mobil uygulama v2", status: "planned", statusLabel: "Planlandı", priority: "critical", priorityLabel: "Kritik", priorityColor: "#D64541", due: day(-2), done: 0, total: 0),
                WProject(id: "2", title: "Kurumsal web sitesi yenileme", status: "inProgress", statusLabel: "Devam ediyor", priority: "high", priorityLabel: "Yüksek", priorityColor: "#E67E22", due: day(12), done: 2, total: 7),
                WProject(id: "3", title: "Bayi portalı raporları", status: "backlog", statusLabel: "Havuz", priority: "medium", priorityLabel: "Orta", priorityColor: "#C9A227", due: day(30), done: 0, total: 0),
            ],
            cards: [
                WCard(id: "c1", projectId: "2", projectTitle: "Kurumsal web sitesi", title: "Ana sayfa hero bölümü", priority: "high", priorityColor: "#E67E22", due: day(1)),
                WCard(id: "c2", projectId: "2", projectTitle: "Kurumsal web sitesi", title: "SEO meta etiketleri", priority: "medium", priorityColor: "#C9A227", due: day(4)),
            ]
        )
    }()
}

#Preview(as: .systemMedium) {
    Plan2meWidget()
} timeline: {
    Entry(date: .now, snapshot: .sample)
}
