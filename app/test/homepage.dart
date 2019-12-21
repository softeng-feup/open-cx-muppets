import 'package:app/Pages/ConnectPage.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('MicroMeets tests', () {
    test('HomePage connect button behaviour', (WidgetTester tester) async {
      final navigator = NavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: HomePage(),
        navigatorObservers: [navigator],
      ));

      final buttonFinder = find.text('Connect');

      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(ConnectionsPage), findsOneWidget);
    });
  });
}
