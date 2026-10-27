// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CardDetailViewModel)
final cardDetailViewModelProvider = CardDetailViewModelFamily._();

final class CardDetailViewModelProvider
    extends $StreamNotifierProvider<CardDetailViewModel, CardDetail?> {
  CardDetailViewModelProvider._({
    required CardDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cardDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cardDetailViewModelHash();

  @override
  String toString() {
    return r'cardDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CardDetailViewModel create() => CardDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is CardDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cardDetailViewModelHash() =>
    r'ebb6b01f40cadcdc4fac0f10271d4eb277ed62ee';

final class CardDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CardDetailViewModel,
          AsyncValue<CardDetail?>,
          CardDetail?,
          Stream<CardDetail?>,
          String
        > {
  CardDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'cardDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CardDetailViewModelProvider call(String cardId) =>
      CardDetailViewModelProvider._(argument: cardId, from: this);

  @override
  String toString() => r'cardDetailViewModelProvider';
}

abstract class _$CardDetailViewModel extends $StreamNotifier<CardDetail?> {
  late final _$args = ref.$arg as String;
  String get cardId => _$args;

  Stream<CardDetail?> build(String cardId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CardDetail?>, CardDetail?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CardDetail?>, CardDetail?>,
              AsyncValue<CardDetail?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
