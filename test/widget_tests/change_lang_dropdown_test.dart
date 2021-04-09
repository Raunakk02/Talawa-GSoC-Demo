import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talawa/views/widgets/change_lang_dropdown.dart';

Widget changeLangDropdown() => MaterialApp(
      home: Scaffold(
        body: ChangeLangDropdown(),
      ),
    );

void main() {
  group('Change language dropdown tests', () {
    testWidgets('Change lang dropdown appears on screen', (tester) async {
      await tester.pumpWidget(changeLangDropdown());
      await tester.pumpAndSettle();

      expect(find.byType(ChangeLangDropdown), findsOneWidget);
      expect(find.byKey(Key('change_lang_dropdown')), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
    });

    testWidgets('dropdown contains language names', (tester) async {
      await tester.pumpWidget(changeLangDropdown());
      await tester.pumpAndSettle();

      expect(find.text('English'), findsOneWidget);
      expect(find.text('Persian'), findsOneWidget);
      expect(find.text('Arabic'), findsOneWidget);
      expect(find.text('Hindi'), findsOneWidget);
    });
  });
}
