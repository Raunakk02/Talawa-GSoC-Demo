import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale, {this.isTest = false});

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  bool isTest;

  Map<String, String> _localizedValues;

  Future loadTest(Locale locale) async {
    return AppLocalization(locale);
  }

  Future load() async {
    String jsonStringValues = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    if (isTest) {
      return key;
    }

    if (key == null) {
      return '...';
    }
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = AppLocalizationDelegate();
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate({
    this.isTest = false,
  });

  final bool isTest;

  @override
  bool isSupported(Locale locale) => ['en', 'fa', 'ar', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale, isTest: isTest);
    if (isTest) {
      await localization.loadTest(locale);
    } else {
      await localization.load();
    }
    return localization;
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
