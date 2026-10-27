import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/utils/clock.dart';
import '../../people/data/people_providers.dart';
import '../../people/domain/person.dart';
import '../data/projects_providers.dart';
import '../domain/project.dart';

part 'project_form_view_model.g.dart';

/// Yeni/düzenle proje formu. [projectId] null ise yeni proje.
@riverpod
class ProjectFormViewModel extends _$ProjectFormViewModel {
  @override
  Future<ProjectDraft> build(String? projectId) async {
    if (projectId != null) {
      final o = await ref
          .read(projectRepositoryProvider)
          .getOverview(projectId);
      if (o != null) return ProjectDraft.fromOverview(o);
    }
    // Yeni projede "ben" işaretli kişi varsayılan sorumlu olur.
    // Not: autoDispose bir provider'ı `read(...future)` ile okumak, dinleyici
    // olmadığı için onu yükleme sırasında kapatır. Tek seferlik okuma repodan.
    final people = await ref.read(personRepositoryProvider).watchAll().first;
    final me = people.where((p) => p.isMe).firstOrNull;
    return ProjectDraft(responsiblePersonId: me?.id);
  }

  bool get isNew => projectId == null;

  void _patch(ProjectDraft Function(ProjectDraft d) f) {
    final d = state.value;
    if (d != null) state = AsyncData(f(d));
  }

  void setTitle(String v) => _patch((d) => d.copyWith(title: v));
  void setDescription(String v) => _patch((d) => d.copyWith(description: v));
  void setDetails(String v) => _patch((d) => d.copyWith(details: v));
  void setPriority(Priority v) => _patch((d) => d.copyWith(priority: v));
  void setStatus(ProjectStatus v) => _patch((d) => d.copyWith(status: v));
  void setResponsible(String? id) =>
      _patch((d) => d.copyWith(responsiblePersonId: id));

  void setStartDate(DateTime? v) => _patch((d) {
    final start = v == null ? null : dateOnly(v);
    // Başlangıç son tarihten sonra olamaz.
    final due =
        (start != null && d.dueDate != null && d.dueDate!.isBefore(start))
        ? start
        : d.dueDate;
    return d.copyWith(startDate: start, dueDate: due);
  });

  void setDueDate(DateTime? v) =>
      _patch((d) => d.copyWith(dueDate: v == null ? null : dateOnly(v)));

  void toggleRequester(String personId) => _patch((d) {
    final ids = [...d.requesterIds];
    ids.contains(personId) ? ids.remove(personId) : ids.add(personId);
    return d.copyWith(requesterIds: ids);
  });

  /// Formdan yeni kişi oluşturup talep edenlere ekler.
  Future<Person> createRequester(PersonInput input) async {
    final person = await ref.read(personRepositoryProvider).create(input);
    if (!ref.mounted) return person;
    toggleRequester(person.id);
    return person;
  }

  bool get canSave => (state.value?.title.trim().isNotEmpty ?? false);

  /// Kaydeder ve proje id'sini döner. [defaultColumns] yeni proje için (l10n'dan).
  Future<String?> save({required List<String> defaultColumns}) async {
    final draft = state.value;
    if (draft == null || draft.title.trim().isEmpty) return null;
    final repo = ref.read(projectRepositoryProvider);
    if (projectId == null) {
      return repo.create(draft, defaultColumns: defaultColumns);
    }
    await repo.update(projectId!, draft);
    return projectId;
  }
}
