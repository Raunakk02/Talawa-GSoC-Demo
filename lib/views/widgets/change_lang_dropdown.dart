import 'package:flutter/material.dart';
import 'package:talawa/main.dart';

class ChangeLangDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Icon(Icons.language),
      underline: null,
      items: [
        DropdownMenuItem(child: Text('English'),value: const Locale('en','US'),),
        DropdownMenuItem(child: Text('Persian'),value: const Locale('fa','IR'),),
        DropdownMenuItem(child: Text('Arabic'),value: const Locale('ar','SA'),),
        DropdownMenuItem(child: Text('Hindi'),value: const Locale('hi','IN'),),
      ],
      onChanged: (locale){
        MyApp.setLocale(context, locale);
      },
    );
  }
}