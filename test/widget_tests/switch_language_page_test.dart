import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talawa/localization/app_localization.dart';
import 'package:talawa/localization/supported_locales.dart';
import 'package:talawa/views/widgets/switch_language_button.dart';

Locale globalTestLocale = const Locale('en', 'US');

Widget switchLanguageButton() =>  MaterialApp(
        locale: globalTestLocale,
        supportedLocales: SupportedLocales.locales,
        localizationsDelegates: [
          AppLocalizationDelegate(isTest: true),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: SwitchLanguageButton(
            isTest: true,
            setTestLocale: switchTestLocale,
          ),
        ),
      );

void switchTestLocale(Locale _locale) {
  globalTestLocale = _locale;
}

void main() {
  group('switch language button tests', () {
    testWidgets('switch language button appears on screen', (tester) async {
      await tester.pumpWidget(switchLanguageButton());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton),findsOneWidget);
    });

    testWidgets('tapping switch language button opens switch language page', (tester) async {
      await tester.pumpWidget(switchLanguageButton());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton),findsOneWidget);

      //get button
      var switchLangButton = find.byType(IconButton);
      await tester.tap(switchLangButton);
      await tester.pumpAndSettle();

      //expect [switch language page] to appear
      expect(find.byKey(Key('Switch_Language_Page')),findsOneWidget);
    });

    testWidgets('switch language page shows language radio tiles', (tester) async {
      await tester.pumpWidget(switchLanguageButton());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton),findsOneWidget);

      //get button
      var switchLangButton = find.byType(IconButton);
      await tester.tap(switchLangButton);
      await tester.pumpAndSettle();

      //expect [switch language page] to appear
      expect(find.byKey(Key('Switch_Language_Page')),findsOneWidget);
      
      //get first two languages
      var firstLanguage = SupportedLocales.localesNameMap.values.toList()[0];
      var secondLanguage = SupportedLocales.localesNameMap.values.toList()[1];

      //expect Radio Tiles to show up
      expect(find.text(firstLanguage),findsOneWidget);
      expect(find.text(secondLanguage),findsOneWidget);

    });

    testWidgets('tapping radio tile switches app locale', (tester) async {
      await tester.pumpWidget(switchLanguageButton());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton),findsOneWidget);

      //get button
      var switchLangButton = find.byType(IconButton);
      await tester.tap(switchLangButton);
      await tester.pumpAndSettle();

      //expect [switch language page] to appear
      expect(find.byKey(Key('Switch_Language_Page')),findsOneWidget);
      
      //get first two languages
      var firstLanguage = SupportedLocales.localesNameMap.values.toList()[0];
      var secondLanguage = SupportedLocales.localesNameMap.values.toList()[1];

      //expect Radio Tiles to show up
      expect(find.text(firstLanguage),findsOneWidget);
      expect(find.text(secondLanguage),findsOneWidget);

      //expect inital locale to be null
      var initialLocale = tester.binding.computePlatformResolvedLocale(SupportedLocales.locales);

      expect(initialLocale,null);

      //get second language radio tile
      var secondRadioTile = find.byWidgetPredicate((w) => w is RadioListTile).at(1);
      expect(secondRadioTile,findsOneWidget);

      await tester.tap(secondRadioTile);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      //expect globalTestLocale to change
      expect(globalTestLocale,SupportedLocales.locales[1]);
      //expect [switch language page] to disappear
      expect(find.byKey(Key('Switch_Language_Page')),findsNothing);
    });
  });
}
