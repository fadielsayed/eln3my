import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/adresse_pages/my_address_json.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class AddressProvider with ChangeNotifier {
  Future<List<MyAddress>> loadAllAddress(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null||token=="") {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      return null;
    }
    http.Response response = await http.get("$baseUrl/all-addresses", headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        if (responseDecoded["status"] == 1) {
          List<MyAddress> lis = new List<MyAddress>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(MyAddress.fromJson(u));
          }
          return lis;
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(AppLocalizations.of(context).error, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).noAddress;
      }
    } else {
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
    notifyListeners();
  }

  Future addAddress(
      {BuildContext context,
      String firstName,
      String lastName,
      String ziCode,
      String destination,
      String region,
      String address,
      int cityId}) async {
    // var token =
    //     Provider.of<AppStateModel>(context, listen: false).appData.token;
    print(firstName);
    print(lastName);
    print(ziCode);
    print(destination);
    print(region);
    print(address);
    print(cityId);
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    http.post("$baseUrl/add-address",
        body: json.encode({
          "first_name": firstName,
          "last_name": lastName,
          "zip_code": ziCode,
          "city_id": cityId,
          "destination": destination,
          "region": region,
          "address": address
        }),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            loadAllAddress(context);

            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          Toast.show(AppLocalizations.of(context).error, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
            duration: 5, gravity: Toast.BOTTOM);
        print("error");
      }
    });
    Navigator.pop(context);

    notifyListeners();
  }
}
