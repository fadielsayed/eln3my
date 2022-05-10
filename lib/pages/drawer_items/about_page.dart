import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/drawer_items/setting_load_data.dart';
import 'package:elnaamy_group/pages/drawer_items/settings_data_json.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPaageState createState() => _AboutAppPaageState();
}

class _AboutAppPaageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).aboutApp,
            style: TextStyle(fontFamily: "DinNextRegular"),
          ),
          // backgroundColor: Color(0xff00577d),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset('assets/images/logo-about.png'),
                ),
                Text(
                  AppLocalizations.of(context).aboutApp,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  Provider.of<SettingLoadData>(context,listen: true).aboutApp ?? "",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ));
  }
}
