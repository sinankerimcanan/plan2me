// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
/// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.

@ProviderFor(BoardViewModel)
final boardViewModelProvider = BoardViewModelFamily._();

/// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
/// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.
final class BoardViewModelProvider
    extends $StreamNotifierProvider<BoardViewModel, BoardData> {
  /// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
  /// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.
  BoardViewModelProvider._({
    required BoardViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'boardViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$boardViewModelHash();

  @override
  String toString() {
    return r'boardViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BoardViewModel create() => BoardViewModel();

  @override
  bool operator ==(Object other) {
    return other is BoardViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$boardViewModelHash() => r'064ee9a78fb5e4be9d63d248b2ad14745489c449';

/// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
/// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.

final class BoardViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          BoardViewModel,
          AsyncValue<BoardData>,
          BoardData,
          Stream<BoardData>,
          String
        > {
  BoardViewModelFamily._()
    : super(
        retry: null,
        name: r'boardViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
  /// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.

  BoardViewModelProvider call(String projectId) =>
      BoardViewModelProvider._(argument: projectId, from: this);

  @override
  String toString() => r'boardViewModelProvider';
}

/// Kanban board ViewModel'i. Kart taşıma iyimser yapılır: UI anında güncellenir,
/// repository yazımı bitince Drift stream'i kalıcı sırayı yeniden yayınlar.

abstract class _$BoardViewModel extends $StreamNotifier<BoardData> {
  late final _$args = ref.$arg as String;
  String get projectId => _$args;

  Stream<BoardData> build(String projectId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BoardData>, BoardData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BoardData>, BoardData>,
              AsyncValue<BoardData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
