import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/forget_passowrd/reset_passowrd_activate.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

class ForgetPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool islaoding) {
    _isLoading = islaoding;
    notifyListeners();
  }

  Future resetPassword(String email, BuildContext context) async {
    setIsLoading(true);

    http.post('$baseUrl/reset-password',
        body: json.encode({"email": email}),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPassowrdActivate(
                          pinCode: responseDecoded["data"].toString(),
                        )));
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
  }

  Future newPassowrd(String pincode, String password, String confirmPassword,
      BuildContext context) async {
    setIsLoading(true);
    http.post('$baseUrl/new-password',
        body: json.encode({
          "pin_code": pincode,
          "password": password,
          "password_confirmation": confirmPassword
        }),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response response) {
      setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          if (responseDecoded["status"] == 1) {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
            Navigator.pop(context);
            Navigator.pop(context);
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
  }
}
