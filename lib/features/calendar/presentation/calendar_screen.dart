import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/glass.dart';
import '../../../core/theme/semantic_colors.dart';
import '../../../core/widgets/chips.dart';
import '../../../core/widgets/common.dart';
import '../../projects/domain/project.dart';
import '../../tasks/presentation/quick_add_sheet.dart';
import '../../tasks/presentation/tasks_screen.dart';
import 'calendar_view_model.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final ui = ref.watch(calendarControllerProvider);
    final ctrl = ref.read(calendarControllerProvider.notifier);
    final agenda = ref.watch(calendarViewModelProvider);

    return LiquidScaffold(
      title: Text(l.calendarTitle),
      actions: [
        TextButton(onPressed: ctrl.goToday, child: Text(l.calendarToday)),
        PopupMenuButton<CalendarSpan>(
          icon: const Icon(Icons.view_week_rounded),
          initialValue: ui.span,
          onSelected: ctrl.setSpan,
          itemBuilder: (_) => [
            CheckedPopupMenuItem(
              value: CalendarSpan.month,
              checked: ui.span == CalendarSpan.month,
              child: Text(l.calendarFormatMonth),
            ),
            CheckedPopupMenuItem(
              value: CalendarSpan.twoWeeks,
              checked: ui.span == CalendarSpan.twoWeeks,
              child: Text(l.calendarFormatTwoWeeks),
            ),
            CheckedPopupMenuItem(
              value: CalendarSpan.week,
              checked: ui.span == CalendarSpan.week,
              child: Text(l.calendarFormatWeek),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
      body: Builder(
        builder: (context) => AsyncView(
          value: agenda,
          data: (events) {
            final day = events[ui.selectedDay] ?? const DayAgenda();
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: liquidBodyPadding(context).copyWith(bottom: 0),
                  sliver: SliverToBoxAdapter(child: _MonthCard(events: events)),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      DateFormat.MMMMEEEEd(
                        Localizations.localeOf(context).toLanguageTag(),
                      ).format(
                        DateTime(
                          ui.selectedDay.year,
                          ui.selectedDay.month,
                          ui.selectedDay.day,
                        ),
                      ),
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                if (day.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GlassSurface(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(l.calendarEmptyDay)),
                            TextButton(
                              onPressed: () => showQuickAddSheet(
                                context,
                                date: ui.selectedDay,
                              ),
                              child: Text(l.commonAdd),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (day.projects.isNotEmpty) ...[
                  _subheader(
                    context,
                    l.calendarProjectsDue,
                    Icons.flag_rounded,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.separated(
                      itemCount: day.projects.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _ProjectDueTile(day.projects[i]),
                    ),
                  ),
                ],
                if (day.tasks.isNotEmpty) ...[
                  _subheader(context, l.calendarTasks, Icons.task_alt_rounded),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.separated(
                      itemCount: day.tasks.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => TaskRow(
                        key: ValueKey(day.tasks[i].card.id),
                        task: day.tasks[i],
                        showDue: false,
                      ).animate().fadeIn(duration: 200.ms, delay: (25 * i).ms),
                    ),
                  ),
                ],
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.paddingOf(context).bottom + 24,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _subheader(BuildContext context, String text, IconData icon) =>
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );
}

class _MonthCard extends ConsumerWidget {
  const _MonthCard({required this.events});

  final Map<DateTime, DayAgenda> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(calendarControllerProvider);
    final ctrl = ref.read(calendarControllerProvider.notifier);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final s = context.semantic;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return GlassSurface(
      blur: true,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
      child: TableCalendar<Object>(
        locale: locale,
        firstDay: DateTime.utc(2000),
        lastDay: DateTime.utc(2100),
        focusedDay: ui.focusedDay,
        selectedDayPredicate: (d) => isSameDay(d, ui.selectedDay),
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: switch (ui.span) {
          CalendarSpan.month => CalendarFormat.month,
          CalendarSpan.twoWeeks => CalendarFormat.twoWeeks,
          CalendarSpan.week => CalendarFormat.week,
        },
        availableGestures: AvailableGestures.horizontalSwipe,
        rowHeight: 46,
        daysOfWeekHeight: 22,
        eventLoader: (d) {
          final a = events[calendarDay(d)];
          return a == null ? const [] : [...a.projects, ...a.tasks];
        },
        onDaySelected: ctrl.select,
        onPageChanged: ctrl.focus,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w800,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left_rounded,
            color: scheme.onSurface,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right_rounded,
            color: scheme.onSurface,
          ),
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM(locale).format(date),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: theme.textTheme.labelSmall!.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
          weekendStyle: theme.textTheme.labelSmall!.copyWith(
            color: scheme.tertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          markersMaxCount: 3,
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: scheme.primary, width: 1.6),
          ),
          todayTextStyle: TextStyle(
            color: scheme.primary,
            fontWeight: FontWeight.w800,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.primary,
          ),
          selectedTextStyle: TextStyle(
            color: scheme.onPrimary,
            fontWeight: FontWeight.w800,
          ),
          weekendTextStyle: TextStyle(color: scheme.tertiary),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, items) {
            if (items.isEmpty) return null;
            final agenda = events[calendarDay(day)];
            if (agenda == null) return null;
            final dots = <Color>[
              for (final p in agenda.projects) s.priority(p.project.priority),
              for (final t in agenda.tasks)
                t.isCompleted ? scheme.outline : s.priority(t.card.priority),
            ];
            return Positioned(
              bottom: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final c in dots.take(3))
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (dots.length > 3)
                    Text(
                      '+',
                      style: TextStyle(
                        fontSize: 9,
                        color: scheme.onSurfaceVariant,
                        height: 0.8,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProjectDueTile extends StatelessWidget {
  const _ProjectDueTile(this.overview);

  final ProjectOverview overview;

  @override
  Widget build(BuildContext context) {
    final p = overview.project;
    final theme = Theme.of(context);
    return GlassSurface(
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: () => context.push(Routes.project(p.id)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.semantic
                .priority(p.priority)
                .withValues(alpha: 0.16),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.flag_rounded,
            color: context.semantic.priority(p.priority),
          ),
        ),
        title: Text(
          p.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              StatusPill(p.status, dense: true),
              const SizedBox(width: 6),
              if (overview.totalCards > 0)
                Text(
                  context.l10n.cardsProgress(
                    overview.doneCards,
                    overview.totalCards,
                  ),
                  style: theme.textTheme.labelSmall,
                ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
