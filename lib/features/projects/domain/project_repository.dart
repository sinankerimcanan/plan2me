import '../../../core/domain/enums.dart';
import 'project.dart';

abstract interface class ProjectRepository {
  /// Pozisyona göre sıralı, silinmemiş projeler ("Gelen kutusu" hariç).
  Stream<List<ProjectOverview>> watchOverviews();
  Stream<ProjectOverview?> watchOverview(String id);
  Future<ProjectOverview?> getOverview(String id);

  /// Projeyi ve [defaultColumns] adlı başlangıç sütunlarını tek işlemde oluşturur.
  /// Son sütun "tamamlandı" sütunu olarak işaretlenir.
  Future<String> create(
    ProjectDraft draft, {
    required List<String> defaultColumns,
  });
  Future<void> update(String id, ProjectDraft draft);
  Future<void> updateStatus(String id, ProjectStatus status);

  /// [beforeId] null ise sona taşır.
  Future<void> move(String id, {String? beforeId});

  /// Varsa "Gelen kutusu" projesinin id'si.
  Stream<String?> watchInboxId();

  /// "Gelen kutusu" projesinin id'si; yoksa [title] ve [columns] ile oluşturur.
  Future<String> ensureInbox({
    required String title,
    required List<String> columns,
  });

  /// Proje ve tüm board içeriğini (soft) siler.
  Future<void> delete(String id);
}
