import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class LanguageDialog extends StatefulWidget {
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _store = Provider.of<GeneralProvider>(context);
    // AppRepository appRepository = new AppRepository();
    var currentLocal = Localizations.localeOf(context).languageCode;
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: Text(
          "Choose Language",
          // AppLocalizations.of(context).chooseLanguage,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              RadioButtonGroup(
                  orientation: GroupedButtonsOrientation.VERTICAL,
                  onSelected: (String selected) {
                    
                  },
                  // _store.setLanguagePicked(selected),
                  labels: <String>[
                    "ar",
                    "en"
                    // AppLocalizations.of(context).arabicLang,
                    // AppLocalizations.of(context).englishLang,
                  ],
                  picked: currentLocal
                  //  _store.languagePicked ==
                  //         AppLocalizations.of(context).arabicLang
                  //     ? AppLocalizations.of(context).arabicLang
                  //     : AppLocalizations.of(context).englishLang,
                  ),
              FlatButton(
                onPressed: () {
                  // if (_store.languagePicked ==
                  //     AppLocalizations.of(context).englishLang) {
                  //   appRepository.setUserLang('en');
                  //   // Provider.of<GeneralProvider>(context)
                  //   //     .setCurrentLanguage('en');
                  //   helper.onLocaleChanged(new Locale('en'));
                  // } else if (_store.languagePicked ==
                  //     AppLocalizations.of(context).arabicLang) {
                  //   appRepository.setUserLang('ar');
                  //   // Provider.of<GeneralProvider>(context)
                  //   //     .setCurrentLanguage('ar');

                  //   helper.onLocaleChanged(new Locale('ar'));
                  // }
                  Navigator.pop(context);
                },
                child: new Text(
                  "chanage Language",
                  // AppLocalizations.of(context).changeLanguage,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          )),
        )
      ],
    );
  }
}
