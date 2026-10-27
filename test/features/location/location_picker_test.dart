import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/domain/place.dart';
import 'package:plan2me/features/location/data/location_service.dart';
import 'package:plan2me/features/location/presentation/location_picker_sheet.dart';

import '../../helpers_widget.dart';

class FakeLocationService implements LocationService {
  Place? current;
  LocationFailure? failure;
  List<Place> results = const [];

  @override
  Future<Place> currentPlace() async {
    if (failure != null) throw LocationException(failure!);
    return current!;
  }

  @override
  Future<List<Place>> search(String query) async => results;
}

void main() {
  late FakeLocationService fake;
  LocationPick? picked;

  Future<void> open(WidgetTester tester, {Place? initial}) async {
    fake = FakeLocationService();
    picked = null;
    final container = ProviderContainer(
      overrides: [locationServiceProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      testApp(
        container,
        Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async => picked = await showLocationPicker(
                  context,
                  initial: initial,
                ),
                child: const Text('aç'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('aç'));
    await tester.pumpAndSettle();
  }

  testWidgets('arama sonucundan seçilir', (tester) async {
    await open(tester);
    fake.results = const [
      Place(name: 'Moda, Kadıköy, İstanbul', latitude: 40.98, longitude: 29.02),
    ];
    await tester.enterText(find.byType(TextField), 'Moda');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Moda, Kadıköy, İstanbul'));
    await tester.pumpAndSettle();
    expect((picked! as LocationPicked).place.latitude, 40.98);
  });

  testWidgets('sonuç yoksa yazılan metin olduğu gibi kaydedilir', (
    tester,
  ) async {
    await open(tester);
    await tester.enterText(find.byType(TextField), 'Annemin evi');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(find.textContaining('Sonuç bulunamadı'), findsOneWidget);
    await tester.tap(find.text('"Annemin evi" olarak kaydet'));
    await tester.pumpAndSettle();
    expect((picked! as LocationPicked).place, const Place(name: 'Annemin evi'));
  });

  testWidgets('mevcut konum; izin reddinde anlaşılır mesaj', (tester) async {
    await open(tester);
    fake.failure = LocationFailure.denied;
    await tester.tap(find.text('Mevcut konumumu kullan'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Konum izni verilmedi'), findsOneWidget);

    fake
      ..failure = null
      ..current = const Place(name: 'Ofis', latitude: 1, longitude: 2);
    await tester.tap(find.text('Mevcut konumumu kullan'));
    await tester.pumpAndSettle();
    expect((picked! as LocationPicked).place.name, 'Ofis');
  });

  testWidgets('mevcut konum varken kaldırılabilir', (tester) async {
    await open(tester, initial: const Place(name: 'Eski'));
    await tester.tap(find.text('Konumu kaldır'));
    await tester.pumpAndSettle();
    expect(picked, isA<LocationCleared>());
  });
}
