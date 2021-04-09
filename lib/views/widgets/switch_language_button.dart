import 'package:flutter/material.dart';
import 'package:talawa/views/pages/localization/switch_language_page.dart';

void setTest(Locale _loc){}

class SwitchLanguageButton extends StatelessWidget {
  SwitchLanguageButton({this.isTest=false,this.setTestLocale = setTest});
  final bool isTest;
  final void Function(Locale) setTestLocale;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SwitchLanguagePage(context,isTest: isTest,setTestLocale: setTestLocale,),
          ),
        );
      },
    );
  }
}
