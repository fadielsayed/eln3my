import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/drawer_items/settings_data_json.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class SettingLoadData with ChangeNotifier {
  String _appUrl ="";
  String get aboutUrl => _appUrl;

  String _aboutApp="";
  String get aboutApp => _aboutApp;

  String _privacyPolicy="";
  String get privacyPolicy => _privacyPolicy;

  String _termsConditions="";
  String get termsConditions => _termsConditions;

  String _replacementPolicy="";
  String get replacementPolicy => _replacementPolicy;

  Future<void> loadGeneralSetting(
    BuildContext context,
  ) async {
  
    http.Response response = await http.get(
        "$baseUrl/settings?api_token=A7Gsh5nDUMbkmVJDSgga0EayoQBDvuXidwlLyW1AiFhR6mt6d0VunoA8J0mN",
        headers: {
          'content-type': 'application/json',
          // 'Authorization': 'Bearer $token'
        });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        print(responseDecoded);
        if (responseDecoded["status"] == 1) {
          // List<Settings> lis = new List<Settings>();
          // for (var u in responseDecoded["data"]) {
          //   print(u);
          //   lis.add(Settings.fromJson(u));
          // }
          _appUrl = responseDecoded["data"]["app_url"];
          _aboutApp = responseDecoded["data"]["about_app"];
          _privacyPolicy = responseDecoded["data"]["privacy_police"];
          _termsConditions = responseDecoded["data"]["terms_conditions"];
          _replacementPolicy = responseDecoded["data"]["replacement_policy"];
          notifyListeners();
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(e, context, duration: 5, gravity: Toast.BOTTOM);
        throw responseDecoded["message"];
      }
    } else {
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
  }
}
