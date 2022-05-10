import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/drawer_items/setting_load_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplacePloicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).replacementPolicy),
        backgroundColor: Color(0xff00577d),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                AppLocalizations.of(context).replacementAndReturnPolicy,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
               Provider.of<SettingLoadData>(context, listen: true).replacementPolicy ??
                    "",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
