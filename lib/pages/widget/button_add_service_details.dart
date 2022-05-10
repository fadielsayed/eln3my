import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:elnaamy_group/pages/my_orders/order_service_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import '../services_page/service_note_rservation.dart';

class ButtonAddServiceDetails extends StatefulWidget {
  final int serviceId;

  ButtonAddServiceDetails({
    Key key,
    this.serviceId,
  }) : super(key: key);

  @override
  _ButtonAddServiceDetailsState createState() =>
      _ButtonAddServiceDetailsState();
}

class _ButtonAddServiceDetailsState extends State<ButtonAddServiceDetails> {
  bool isLoading = false;
  TextEditingController _notes = TextEditingController();
  Future addReservation({BuildContext context}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    setState(() {
      isLoading = true;
    });
    final branchId =
        Provider.of<AppStateModel>(context, listen: false).selectedBranch;

    return http.post('$baseUrl/add-reservation',
        body: json.encode({
          "service_id": widget.serviceId,
          "branch_id": branchId,
          "notes": _notes.text
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
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              elevation: 0,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context).addNotes),
                        content: TextField(
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).notes),
                          controller: _notes,
                        ),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text(AppLocalizations.of(context).close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child:
                                new Text(AppLocalizations.of(context).saveNow),
                            onPressed: () {
                              addReservation(context: context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                child: Text(
                  AppLocalizations.of(context).subscribenow,
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
