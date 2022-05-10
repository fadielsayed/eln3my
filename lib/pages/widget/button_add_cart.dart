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

class ButtonAddCard extends StatefulWidget {
  final int productId;

  final int quantity;

  ButtonAddCard({Key key, this.productId, this.quantity}) : super(key: key);

  @override
  _ButtonAddCardState createState() => _ButtonAddCardState();
} 

class _ButtonAddCardState extends State<ButtonAddCard> {
  bool isLoading = false;

  Future addCart({BuildContext context}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null||token=="") {
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
    var currentLocal = Localizations.localeOf(context).languageCode;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : InkWell(
            onTap: () {
              addCart(context: context);
            },
            child: currentLocal == "en"
                ? Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0))),
                        child: Center(
                          child: ImageIcon(
                            AssetImage("assets/icon/icon-cart.png"),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: new BorderRadius.only(
                                topRight: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0))),
                        // color: Colors.black,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).addCart,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: new BorderRadius.only(
                                topRight: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0))),
                        // color: Colors.black,
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).addCart,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0))),
                        child: Center(
                          child: ImageIcon(
                            AssetImage("assets/icon/icon-cart.png"),
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ));
  }
}
