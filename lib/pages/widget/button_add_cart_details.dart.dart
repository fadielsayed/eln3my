import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class ButtonaddCartDetails extends StatefulWidget {
  final int productId;

  final int quantity;

  ButtonaddCartDetails({Key key, this.productId, this.quantity})
      : super(key: key);

  @override
  _ButtonaddCartDetailsState createState() => _ButtonaddCartDetailsState();
}

class _ButtonaddCartDetailsState extends State<ButtonaddCartDetails> {
  bool isLoading = false;

  Future addCart({BuildContext context}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null || token == "") {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    setState(() {
      isLoading = true;
    });
    final branchId =
        Provider.of<AppStateModel>(context, listen: false).selectedBranch;

    return http.post('$baseUrl/add-to-cart',
        body: json.encode({
          "product_id": widget.productId,
          "branch_id": branchId,
          "quantity": widget.quantity
        }),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      setState(() {
        isLoading = false;
      });
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => ScreenCart()));
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          Toast.show("error catch", context,
              duration: 5, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show("Some thing worng happened", context,
            duration: 5, gravity: Toast.BOTTOM);
        print("error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var currentLocal = Localizations.localeOf(context).languageCode;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              elevation: 0,
              onPressed: () {
                addCart(context: context);
              },
              child: Container(
                child: Text(
                  AppLocalizations.of(context).addCart,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
  }
}
