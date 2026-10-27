import 'package:freezed_annotation/freezed_annotation.dart';

part 'trash_item.freezed.dart';

enum TrashKind { project, card, person }

@freezed
abstract class TrashItem with _$TrashItem {
  const factory TrashItem({
    required TrashKind kind,
    required String id,
    required String title,
    String? subtitle,
    required DateTime deletedAt,
  }) = _TrashItem;
}

abstract interface class TrashRepository {
  /// Silinmiş projeler, kartlar (projesi duruyorsa) ve kişiler; en yeni önce.
  Stream<List<TrashItem>> watchTrash();

  Future<void> restoreProject(String id);
  Future<void> restoreCard(String id);
  Future<void> restorePerson(String id);

  /// Kalıcı silme (geri alınamaz).
  Future<void> purge(TrashItem item);
  Future<void> emptyTrash();

  /// [age]'den eski çöpü kalıcı siler; silinen kök kayıt sayısını döner.
  Future<int> purgeOlderThan(Duration age);
}

extension TrashRestore on TrashRepository {
  Future<void> restore(TrashItem item) => switch (item.kind) {
    TrashKind.project => restoreProject(item.id),
    TrashKind.card => restoreCard(item.id),
    TrashKind.person => restorePerson(item.id),
  };
}
