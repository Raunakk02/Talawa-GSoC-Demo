import 'package:flutter/material.dart';

class SupportedLocales{

  static const List<Locale> locales = [
    const Locale('en','US'),
    const Locale('fa','IR'),
    const Locale('ar','SA'),
    const Locale('hi','IN'),
  ];

  static Map<Locale, String> localesNameMap = {
    locales[0] : 'English' ,
    locales[1] : 'Persian' ,
    locales[2] : 'Arabic' ,
    locales[3] : 'Hindi' ,
  };
}