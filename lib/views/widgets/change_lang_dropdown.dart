import 'package:flutter/material.dart';
import 'package:talawa/main.dart';

void defaultSwitchLocale(Locale _locale) {}

class ChangeLangDropdown extends StatefulWidget {
  ChangeLangDropdown({this.isTest = false, this.switchLocale = defaultSwitchLocale});

  final bool isTest;
  final void Function(Locale _locale) switchLocale;

  @override
  _ChangeLangDropdownState createState() => _ChangeLangDropdownState();
}

class _ChangeLangDropdownState extends State<ChangeLangDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      key: Key('change_lang_dropdown'),
      icon: Icon(Icons.language),
      underline: null,
      items: [
        DropdownMenuItem(
          child: Text('English'),
          value: const Locale('en', 'US'),
        ),
        DropdownMenuItem(
          child: Text('Persian'),
          value: const Locale('fa', 'IR'),
        ),
        DropdownMenuItem(
          child: Text('Arabic'),
          value: const Locale('ar', 'SA'),
        ),
        DropdownMenuItem(
          child: Text('Hindi'),
          value: const Locale('hi', 'IN'),
        ),
      ],
      onChanged: (locale) {
        if (widget.isTest) {
          widget.switchLocale(locale);
        } else {
          MyApp.setLocale(context, locale);
        }
      },
    );
  }
}
