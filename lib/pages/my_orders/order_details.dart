import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/cart_screen/finish_pay_page.dart';
import 'package:elnaamy_group/pages/my_orders/order_json.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:elnaamy_group/pages/my_orders/widget_order.dart';
import 'package:elnaamy_group/pages/widget/dialog_rating_start.dart';
import 'package:elnaamy_group/pages/widget/dialog_return_product.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class OrderDetails extends StatelessWidget {
  final int idOrder;

  OrderDetails({Key key, this.idOrder}) : super(key: key);

  Future<OrdersDetails> loadDetilsOrder(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null || token == "") {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    http.Response response = await http
        .get("$baseUrl/order-details?order_id=$idOrder", headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    // setIsLoading(false);
    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(responseDecoded);
      try {
        if (responseDecoded["status"] == 1) {
          return OrdersDetails.fromJson(responseDecoded["data"]);
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(AppLocalizations.of(context).error, context,
            duration: 5, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show("Some thing worng happened", context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
      throw responseDecoded["message"];
    }
  }

  @override
  Widget build(BuildContext context) {
    var userName = Provider.of<AppStateModel>(context).userEntity.displayName;

    return FutureBuilder(
      future: loadDetilsOrder(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text(snapshot.error.toString()),
          ));
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return Scaffold(
              body: Center(
            child: Text(AppLocalizations.of(context).noData),
          ));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
        OrdersDetails ordersDetails = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).ordersDetails),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  // width: 300,
                  // height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[350],
                  ),
                  child: FlatButton(
                    child: Text(
                      AppLocalizations.of(context).welcomTo + " $userName",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalizations.of(context).orderManagment,
                  style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.14,
                              child:
                                  Image.asset("assets/images/logo-about.png")),

                          // SizedBox(
                          //   height: 4,
                          // ),
                          Container(
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0)),
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context).close,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    WidgetOrder(
                      idOrder: ordersDetails.id,
                      totalPrice: ordersDetails.totalPrice,
                      status: ordersDetails.status,
                      orderDate: ordersDetails.orderDate,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context).shipingTo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  ordersDetails.shippingId.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  color: Colors.grey[200],
                  child: Text(
                    AppLocalizations.of(context).theProductIncludeYourOrder,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.products.length,
                      itemBuilder: (context, i) {
                        var orderItem = snapshot.data.products[i];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  height: 100,
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.black12,
                                      width: 1.0,
                                    ),
                                    image: new DecorationImage(
                                      image: orderItem["image"] == null
                                          ? AssetImage(
                                              "assets/images/no_image.png")
                                          : NetworkImage(orderItem["image"]),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    orderItem["name"] == null
                                        ? "Name Not Found "
                                        : orderItem["name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    orderItem["price_after_sale"] == null
                                        ? "0.0"
                                        : orderItem["price_after_sale"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    orderItem["created_at"],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ordersDetails.status == "delivered"
                                          ? RaisedButton(
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) {
                                                      return DialogRatingStart(
                                                        productId:
                                                            orderItem["id"],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .rateProduct,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                          : SizedBox()
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
