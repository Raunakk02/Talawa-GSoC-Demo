import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talawa/localization/app_localization.dart';
import 'package:talawa/localization/supported_locales.dart';
import 'package:talawa/views/widgets/change_lang_dropdown.dart';

Locale globalLocale = const Locale('en', 'US');

Widget changeLangDropdown(bool _isTest, Function _switchLocale) => MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        supportedLocales: SupportedLocales.locales,
        localizationsDelegates: [
          AppLocalizationDelegate(isTest: true),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: ChangeLangDropdown(
            isTest: _isTest,
            switchLocale: _switchLocale,
          ),
        ),
      ),
    );

void switchTestLocale(Locale _locale) {
  globalLocale = _locale;
}

void main() {
  group('Change language dropdown tests', () {
    testWidgets('Change lang dropdown appears on screen', (tester) async {
      await tester.pumpWidget(changeLangDropdown(true, switchTestLocale));
      await tester.pumpAndSettle();

      expect(find.byType(ChangeLangDropdown), findsOneWidget);
      expect(find.byKey(Key('change_lang_dropdown')), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
    });

    testWidgets('dropdown has language values', (tester) async {
      await tester.pumpWidget(changeLangDropdown(true, switchTestLocale));
      await tester.pumpAndSettle();

      expect(find.byType(ChangeLangDropdown), findsOneWidget);
      expect(find.byKey(Key('change_lang_dropdown')), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);

      expect(find.text('English'), findsOneWidget);
      expect(find.text('Persian'), findsOneWidget);
      expect(find.text('Arabic'), findsOneWidget);
      expect(find.text('Hindi'), findsOneWidget);
    });
  });
}
