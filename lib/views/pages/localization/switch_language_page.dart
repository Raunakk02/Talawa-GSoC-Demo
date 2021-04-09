import 'package:flutter/material.dart';
import 'package:talawa/localization/supported_locales.dart';
import 'package:talawa/main.dart';

void setTest(Locale _loc){}

class SwitchLanguagePage extends StatefulWidget {
  SwitchLanguagePage(this.ancestorContext,{this.isTest = false, this.setTestLocale = setTest});
  final BuildContext ancestorContext;
  final bool isTest;
  final void Function(Locale) setTestLocale;
  @override
  _SwitchLanguagePageState createState() => _SwitchLanguagePageState();
}

class _SwitchLanguagePageState extends State<SwitchLanguagePage> {

  int selectedRadioTile;
  Locale _selectedLocale;

  @override
    void initState() {
      _selectedLocale = Localizations.localeOf(widget.ancestorContext);
      selectedRadioTile = SupportedLocales.locales.indexOf(_selectedLocale);
      super.initState();
    }

  void setSelectedRadioTile(int val){
    setState(() {
          selectedRadioTile = val;
          _selectedLocale = SupportedLocales.locales[val];
          print(_selectedLocale);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        key: Key('Switch_Language_Page'),
        title: Text('Select Language'),
        actions: [
          TextButton(
            onPressed: () {
              if(widget.isTest){
                widget.setTestLocale(_selectedLocale);
              }else{
                MyApp.setLocale(context, _selectedLocale);
              }
              Navigator.of(context).pop();
            },
            child: Text('Done'),
            style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: SupportedLocales.locales.length,
        itemBuilder: (_,index){
          List<Locale> locales = SupportedLocales.locales;
          Map<Locale,String> localesMap = SupportedLocales.localesNameMap;

          return RadioListTile(
            value: index, 
            groupValue: selectedRadioTile, 
            onChanged: setSelectedRadioTile,
            title: Text(localesMap[locales[index]]),
          );
        },
      ),
    );
  }
}
