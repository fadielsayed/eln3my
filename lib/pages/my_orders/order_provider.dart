import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:elnaamy_group/pages/my_orders/order_json.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:elnaamy_group/locale/localizations.dart';

class Orders with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool islaoding) {
    _isLoading = islaoding;
    notifyListeners();
  }

  bool _radioValue = false;
  bool get radioValue => _radioValue;

  void setRadioValue(bool value) {
    _radioValue = value;
    notifyListeners();
  }

  Future<List<MyReservations>> loadmyreservations(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null||token=="") {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    http.Response response = await http.get("$baseUrl/my-reservations",
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        // print(responseDecoded);
        if (responseDecoded["status"] == 1) {
          List<MyReservations> lis = new List<MyReservations>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(MyReservations.fromJson(u));
          }

          return lis;
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(e, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        throw  AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show(  AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
    notifyListeners();
  }

  Future<List<MyOrders>> loadmyOrders(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null||token=="") {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    http.Response response = await http.get("$baseUrl/my-orders", headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        // print(responseDecoded);
        if (responseDecoded["status"] == 1) {
          List<MyOrders> lis = new List<MyOrders>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(MyOrders.fromJson(u));
          }

          return lis;
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(e, context, duration: 5, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show(  AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
    notifyListeners();
  }

  Future newOrder(
      {BuildContext context,
      int shippingId,
      int paymentMethodId,
      String notes}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    // setState(() {
    //   isLoading = true;
    // });
    setIsLoading(true);

    final branchId =
        Provider.of<AppStateModel>(context, listen: false).selectedBranch;

    return http.post('$baseUrl/new-order',
        body: json.encode({
          "shipping_id": shippingId,
          "payment_method_id": paymentMethodId,
          "branch_id": branchId,
          "notes": notes
        }),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      // setState(() {
      //   isLoading = false;
      // });
      setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => MyOrderManagment()));
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          // setState(() {
          //   isLoading = false;
          // });
          setIsLoading(false);
          Toast.show(  AppLocalizations.of(context).error, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show(  AppLocalizations.of(context).someThingWorngHappen, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print("error");
      }
      notifyListeners();
    });
  }

  //addrarting
  Future addRatingProduct(
      {BuildContext context,
      int productId,
      int rating,
      String comment}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    // if (token == null) {
    //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
    //   return null;
    // }
    // setState(() {
    //   isLoading = true;
    // });
    setIsLoading(true);

    final branchId =
        Provider.of<AppStateModel>(context, listen: false).selectedBranch;

    return http.post('$baseUrl/add_rating_product',
        body: json.encode({
          "product_id": productId,
          "rating": rating,
          "branch_id": branchId,
          "comment": comment
        }),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      // setState(() {
      //   isLoading = false;
      // });
      setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            Navigator.pop(context);
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          // setState(() {
          //   isLoading = false;
          // });
          setIsLoading(false);
          Toast.show(  AppLocalizations.of(context).error, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show(  AppLocalizations.of(context).someThingWorngHappen, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print("error");
      }
      notifyListeners();
    });
  }
}
