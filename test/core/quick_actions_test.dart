import 'package:flutter_test/flutter_test.dart';
import 'package:plan2me/core/services/quick_actions_service.dart';

void main() {
  test('kısayollar doğru rotalara gider', () {
    expect(AppShortcuts.routeFor('new_task'), '/tasks?add=1');
    expect(AppShortcuts.routeFor('tasks'), '/tasks');
    expect(AppShortcuts.routeFor('calendar'), '/calendar');
    expect(AppShortcuts.routeFor('new_project'), '/projects/new');
    expect(AppShortcuts.routeFor('bilinmeyen'), isNull);
  });
}
