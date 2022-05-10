import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_entity.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/auth/user_entity.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/select_branch.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:toast/toast.dart';

class SignUpProvider with ChangeNotifier {
  bool _radioValue = false;
  bool get radioValue => _radioValue;

  void setRadioValue(bool value) {
    _radioValue = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool islaoding) {
    _isLoading = islaoding;
    notifyListeners();
  }

  Future signUp(String name, String email, String phone, String password,
      String confirmpasswor, BuildContext context) async {
    setIsLoading(true);

    http.post("$baseUrl/register",
        body: json.encode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "password_confirmation": confirmpasswor
        }),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            UserEntity userData = UserEntity(
                displayName: responseDecoded["data"]["client"]["name"],
                id: responseDecoded["data"]["client"]["id"],
                email: responseDecoded["data"]["client"]["email"],
                phone: responseDecoded["data"]["client"]["phone"]
                );
                
            AppData appData = AppData(
                token: responseDecoded["data"]["api_token"],
                languageCode: "en");

            Provider.of<AppStateModel>(context, listen: false)
                .authenticate(appData, userData);
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => SelectBranch()));
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          Toast.show(AppLocalizations.of(context).error, context,
              duration: 5, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
            duration: 5, gravity: Toast.BOTTOM);
        print("error");
      }
    });

    notifyListeners();
  }
}
