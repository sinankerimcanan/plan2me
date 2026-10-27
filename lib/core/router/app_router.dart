import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/board/presentation/board_screen.dart';
import '../../features/board/presentation/card_detail_sheet.dart';
import '../../features/calendar/presentation/calendar_screen.dart';
import '../../features/people/presentation/people_screen.dart';
import '../../features/projects/presentation/project_detail_screen.dart';
import '../../features/projects/presentation/project_form_screen.dart';
import '../../features/projects/presentation/projects_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/tasks/presentation/tasks_screen.dart';
import '../../features/trash/presentation/trash_screen.dart';
import 'app_shell.dart';
import 'routes.dart';
import 'transitions.dart';

part 'app_router.g.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Başlangıç rotası. Normalde projeler listesi; geliştirmede main() override edebilir.
@Riverpod(keepAlive: true)
String initialLocation(Ref ref) => Routes.projects;

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: ref.read(initialLocationProvider),
    routes: [
      // Board bağlamı olmadan kart detayı (görevler / takvim / bildirimlerden).
      GoRoute(
        path: '/cards/:cardId',
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) => BottomSheetPage(
          key: state.pageKey,
          child: CardDetailSheet(cardId: state.pathParameters['cardId']!),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.projects,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ProjectsScreen(),
                ),
                routes: [
                  // Detay sayfaları alt menünün üstünde, kök navigator'da açılır.
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: _rootKey,
                    pageBuilder: (context, state) =>
                        glassPage(state, const ProjectFormScreen()),
                  ),
                  GoRoute(
                    path: ':projectId',
                    parentNavigatorKey: _rootKey,
                    pageBuilder: (context, state) => glassPage(
                      state,
                      ProjectDetailScreen(
                        projectId: state.pathParameters['projectId']!,
                      ),
                    ),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        parentNavigatorKey: _rootKey,
                        pageBuilder: (context, state) => glassPage(
                          state,
                          ProjectFormScreen(
                            projectId: state.pathParameters['projectId'],
                          ),
                        ),
                      ),
                      GoRoute(
                        path: 'board',
                        parentNavigatorKey: _rootKey,
                        pageBuilder: (context, state) => sharedAxisPage(
                          state,
                          BoardScreen(
                            projectId: state.pathParameters['projectId']!,
                          ),
                        ),
                        routes: [
                          GoRoute(
                            path: 'cards/:cardId',
                            parentNavigatorKey: _rootKey,
                            pageBuilder: (context, state) => BottomSheetPage(
                              key: state.pageKey,
                              child: CardDetailSheet(
                                cardId: state.pathParameters['cardId']!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.tasks,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: TasksScreen(
                    openQuickAdd: state.uri.queryParameters['add'] == '1',
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.calendar,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const CalendarScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.people,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PeopleScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const SettingsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'trash',
                    parentNavigatorKey: _rootKey,
                    pageBuilder: (context, state) =>
                        glassPage(state, const TrashScreen()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
