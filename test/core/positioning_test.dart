import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/utils/positioning.dart';

void main() {
  const a = (id: 'a', position: 1024.0);
  const b = (id: 'b', position: 2048.0);
  const c = (id: 'c', position: 3072.0);

  group('positionBefore', () {
    test('boş listede ilk adım', () {
      expect(positionBefore([], null), kPositionStep);
    });
    test('null → sona ekler', () {
      expect(positionBefore([a, b], null), 2048 + kPositionStep);
    });
    test('ilk öğenin önüne', () {
      expect(positionBefore([a, b], 'a'), 1024 - kPositionStep);
    });
    test('iki öğe arasına ortalama', () {
      expect(positionBefore([a, b, c], 'b'), 1536);
    });
    test('bilinmeyen id → sona', () {
      expect(positionBefore([a], 'zzz'), 1024 + kPositionStep);
    });
  });

  test('needsRenormalize çok yakın komşuları yakalar', () {
    expect(needsRenormalize([1, 2, 3]), isFalse);
    expect(needsRenormalize([1, 1 + 1e-9, 3]), isTrue);
    expect(renormalized(3), [1024, 2048, 3072]);
  });

  test('tekrarlı araya ekleme sonunda normalize gerekir', () {
    var lo = 1024.0;
    const hi = 2048.0;
    var steps = 0;
    while (!needsRenormalize([lo, hi])) {
      lo = (lo + hi) / 2;
      steps++;
    }
    expect(steps, greaterThan(20));
  });

  group('beforeIdForReorder', () {
    final ids = ['a', 'b', 'c', 'd'];
    test('aşağı taşıma', () => expect(beforeIdForReorder(ids, 0, 2), 'c'));
    test('en sona', () => expect(beforeIdForReorder(ids, 1, 4), isNull));
    test('yukarı taşıma', () => expect(beforeIdForReorder(ids, 3, 1), 'b'));
    test('başa', () => expect(beforeIdForReorder(ids, 2, 0), 'a'));
  });
}
