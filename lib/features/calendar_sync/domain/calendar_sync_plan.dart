import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../projects/domain/project.dart';
import '../../tasks/domain/task_item.dart';

part 'calendar_sync_plan.freezed.dart';

/// Telefon takviminde bulunması gereken tüm gün etkinliği.
@freezed
abstract class CalendarEventSpec with _$CalendarEventSpec {
  const CalendarEventSpec._();

  const factory CalendarEventSpec({
    /// `card:<id>` ya da `project:<id>`.
    required String key,
    required String title,

    /// Sadece-gün (UTC gece yarısı) tarih.
    required DateTime date,
    String? description,
    String? location,

    /// Etkinliğe dokununca plan2me'de kaydı açan bağlantı.
    required String url,
  }) = _CalendarEventSpec;

  /// İçerik özeti; değişirse etkinlik yeniden yazılır.
  String get signature =>
      jsonEncode([title, date.toIso8601String(), description, location, url]);
}

/// Açık görevlerin ve açık proje teslimlerinin takvim karşılıkları.
List<CalendarEventSpec> plannedCalendarEvents({
  required List<TaskItem> tasks,
  required List<ProjectOverview> projects,
  required AppLocalizations l10n,
}) => [
  for (final t in tasks)
    if (!t.isCompleted && t.card.dueDate != null)
      CalendarEventSpec(
        key: 'card:${t.card.id}',
        title: t.card.title,
        date: t.card.dueDate!,
        description: [
          if (t.card.description?.trim().isNotEmpty ?? false)
            t.card.description!.trim(),
          l10n.calendarSyncTaskFooter(
            t.isInbox ? l10n.inboxTitle : t.projectTitle,
          ),
        ].join('\n\n'),
        location: t.card.location?.name,
        url: 'plan2me://app/cards/${t.card.id}',
      ),
  for (final o in projects)
    if (o.project.dueDate != null &&
        !o.project.status.isClosed &&
        !o.project.isInbox)
      CalendarEventSpec(
        key: 'project:${o.project.id}',
        title: l10n.deviceCalendarProjectDue(o.project.title),
        date: o.project.dueDate!,
        description: o.project.description,
        location: o.project.location?.name,
        url: 'plan2me://app/projects/${o.project.id}',
      ),
];

/// Daha önce yazılmış bir etkinlik.
typedef LinkedEvent = ({String eventId, String signature});

/// Mevcut eşleşmelerden hedef duruma geçmek için yapılacaklar.
class CalendarDiff {
  const CalendarDiff({
    required this.create,
    required this.replace,
    required this.remove,
  });

  /// Hiç yazılmamış etkinlikler.
  final List<CalendarEventSpec> create;

  /// İçeriği değişmiş etkinlikler: eskisi silinip yenisi yazılır.
  final List<(CalendarEventSpec spec, String oldEventId)> replace;

  /// Artık olmaması gereken etkinlikler (tamamlanan, silinen, tarihi kalkan): anahtar → etkinlik.
  final Map<String, String> remove;

  bool get isEmpty => create.isEmpty && replace.isEmpty && remove.isEmpty;
}

CalendarDiff diffCalendar(
  List<CalendarEventSpec> desired,
  Map<String, LinkedEvent> links,
) {
  final wanted = {for (final s in desired) s.key: s};
  final create = <CalendarEventSpec>[];
  final replace = <(CalendarEventSpec, String)>[];
  for (final spec in desired) {
    final link = links[spec.key];
    if (link == null) {
      create.add(spec);
    } else if (link.signature != spec.signature) {
      replace.add((spec, link.eventId));
    }
  }
  return CalendarDiff(
    create: create,
    replace: replace,
    remove: {
      for (final e in links.entries)
        if (!wanted.containsKey(e.key)) e.key: e.value.eventId,
    },
  );
}
