import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/finish_pay_page.dart';
import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
import 'package:elnaamy_group/pages/my_orders/order_details.dart';
import 'package:elnaamy_group/pages/my_orders/order_json.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:elnaamy_group/pages/my_orders/widget_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;

    return (token == null || token == "")
        ? Center(
            child: FlatButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => LoginPage())),
            child: Text(AppLocalizations.of(context).youShouldLogIn),
          ))
        : Consumer<Orders>(
            builder: (context, odersProvider, child) => FutureBuilder(
              future: odersProvider.loadmyOrders(context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == null) {
                  return Center(
                    child: Text(AppLocalizations.of(context).noData),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppLocalizations.of(context).productManagment,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            MyOrders myOrders = snapshot.data[i];
                            return Row(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          child: Image.asset(
                                              "assets/images/logo-about.png")),
                                      Expanded(
                                        child: RaisedButton(
                                          onPressed: () {
                                            myOrders.status == "cart"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ScreenCart()))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            OrderDetails(
                                                              idOrder:
                                                                  myOrders.id,
                                                            )));
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4.0)),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .productDetails,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Color(0xff00577d),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4.0)),
                                          onPressed: () {},
                                          child: Text(
                                            AppLocalizations.of(context).close,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                WidgetOrder(
                                  idOrder: myOrders.id,
                                  status: myOrders.status,
                                  orderDate: myOrders.orderDate,
                                  totalPrice: myOrders.totalPrice,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}
