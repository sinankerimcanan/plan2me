// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardRepository)
final boardRepositoryProvider = BoardRepositoryProvider._();

final class BoardRepositoryProvider
    extends
        $FunctionalProvider<BoardRepository, BoardRepository, BoardRepository>
    with $Provider<BoardRepository> {
  BoardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardRepositoryHash();

  @$internal
  @override
  $ProviderElement<BoardRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardRepository create(Ref ref) {
    return boardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardRepository>(value),
    );
  }
}

String _$boardRepositoryHash() => r'd348d709c71aa06cad4f4c22668af40256ff6168';

@ProviderFor(upcomingCards)
final upcomingCardsProvider = UpcomingCardsProvider._();

final class UpcomingCardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingCard>>,
          List<UpcomingCard>,
          Stream<List<UpcomingCard>>
        >
    with
        $FutureModifier<List<UpcomingCard>>,
        $StreamProvider<List<UpcomingCard>> {
  UpcomingCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingCardsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingCardsHash();

  @$internal
  @override
  $StreamProviderElement<List<UpcomingCard>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<UpcomingCard>> create(Ref ref) {
    return upcomingCards(ref);
  }
}

String _$upcomingCardsHash() => r'9d7cab7be6a2dc33289fbda266e68a67a5142915';
