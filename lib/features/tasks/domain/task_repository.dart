import 'task_item.dart';

abstract interface class TaskRepository {
  /// Açık projelerdeki görevler. Tamamlananlar son [completedDays] gün ile sınırlı.
  Stream<List<TaskItem>> watchTasks({int completedDays = 7});

  /// Görev ekler ve kart id'sini döner. Proje yoksa "Gelen kutusu" oluşturulur.
  Future<String> addTask(
    QuickTaskInput input, {
    required String inboxTitle,
    required List<String> defaultColumns,
  });
}
