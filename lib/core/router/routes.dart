/// Uygulama rotaları (go_router yolları).
abstract final class Routes {
  static const projects = '/projects';
  static const newProject = '/projects/new';
  static const people = '/people';
  static const settings = '/settings';

  static String project(String id) => '/projects/$id';
  static String editProject(String id) => '/projects/$id/edit';
  static String board(String id) => '/projects/$id/board';
  static String card(String projectId, String cardId) =>
      '/projects/$projectId/board/cards/$cardId';

  static const tasks = '/tasks';

  /// Board bağlamı olmadan kart detayı (görevler ve takvimden açılır).
  static String taskCard(String cardId) => '/cards/$cardId';
}
