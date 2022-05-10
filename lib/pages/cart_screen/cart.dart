// import 'dart:html';
// import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:elnaamy_group/http_request/api_client.dart';
import 'package:elnaamy_group/http_request/request_config.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/cart_json.dart';
import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
// import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';



class Cart with ChangeNotifier {
//loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool islaoding) {
    _isLoading = islaoding;
    notifyListeners();
  }



  Future<CartModel> loadCart(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null||token=="") {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    http.Response response = await http.get("$baseUrl/list-cart", headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        // print(responseDecoded);
        if (responseDecoded["status"] == 1) {
          List<CartItemModel> lis = new List<CartItemModel>();
          for (var u in responseDecoded["data"]["products"]["data"]) {
            // print(u);
            lis.add(CartItemModel.fromJson(u));
          }
          print(responseDecoded["data"]["total_price"]);
          print(responseDecoded["data"]["total_quantity"]);
          CartModel cart = CartModel(
              cartItemModel: lis,
              totalPrice: responseDecoded["data"]["total_price"] == null
                  ? 0.0
                  : double.tryParse(
                      responseDecoded["data"]["total_price"] as String),
              totalQuantity: responseDecoded["data"]["total_quantity"] == null
                  ? 0
                  : int.tryParse(
                      responseDecoded["data"]["total_quantity"] as String));
          return cart;
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
    notifyListeners();
  }

  Future removeItemFromCart({BuildContext context, int productId}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    print(productId);

    http.post("$baseUrl/remove-from-cart",
        body: json.encode({
          "product_id": productId,
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
            loadCart(context);
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
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

  Future updateQuantity(
      {BuildContext context, int productId, int quantity}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    print(productId);
    print(quantity);

    http.post("$baseUrl/update-cart",
        body: json.encode({"product_id": productId, "quantity": quantity}),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            loadCart(context);

            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
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

//add Product

}
