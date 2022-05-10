import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:elnaamy_group/pages/cart_screen/cart_json.dart';
import 'package:elnaamy_group/pages/cart_screen/item_cart.dart';
import 'package:elnaamy_group/pages/cart_screen/finish_pay_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ScreenCart extends StatelessWidget {
  final TextEditingController _nots = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    var appBar = AppBar(
      title: Text(AppLocalizations.of(context).shopingCart),
      centerTitle: true,
    ); 
    return(token==null||token=="")
        ? Scaffold(
            appBar: appBar,
            body: Center(
                child: FlatButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginPage())),
              child: Text(AppLocalizations.of(context).youShouldLogIn),
            )),
          )
        : Consumer<Cart>(
            builder: (context, cartProvider, child) => FutureBuilder(
              future: cartProvider.loadCart(context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                      appBar: appBar,
                      body: Center(
                        child: Text(snapshot.error),
                      ));
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == null) {
                  return Scaffold(
                      appBar: appBar,
                      body: Center(
                        child: Text(AppLocalizations.of(context).noData),
                      ));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      appBar: appBar,
                      body: Center(
                        child: CircularProgressIndicator(),
                      ));
                }

                return Scaffold(
                  appBar: appBar,
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.cartItemModel.length,
                                itemBuilder: (context, i) {
                                  CartItemModel cartJson =
                                      snapshot.data.cartItemModel[i];
                                  // CartModel cartModel=snapshot.data[i];
                                  return ItemCart(
                                    id: cartJson.product["id"],
                                    productId: cartJson.productId,
                                    price:
                                        cartJson.product["price_after_sale"] ==
                                                null
                                            ? 0.0
                                            : double.parse(cartJson
                                                .product["price_after_sale"]),
                                    title: cartJson.product["name"],
                                    quantity: cartJson.quantity,
                                    image: cartJson.product["image"],
                                    totalPrice: cartJson.totalPrice == null
                                        ? 0.0
                                        : double.tryParse(
                                            cartJson.totalPrice.toString()),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            AppLocalizations.of(context).notesToReqest,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              width: 40,
                              height: 10,
                              child: Divider(
                                thickness: 3,
                                color: Theme.of(context).accentColor,
                                height: 36,
                              )),
                          TextField(
                            controller: _nots,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).notes,
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context).sumOrder,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      // cart.totalAmount.toString(),
                                      snapshot.data.totalPrice.toString(),
                                      // "222",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Spacer(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                     AppLocalizations.of(context).totalAmount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data.totalQuantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context).tax5vat,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          AppLocalizations.of(context).thePriceIncludeTax,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Colors.black26),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "3.5 sr",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context).sum,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      // cart.totalAmount.toString(),
                                      " ${3.5 + snapshot.data.totalPrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.94,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xff143240),
                              ),
                              child: FlatButton(
                                child: Text(
                                 AppLocalizations.of(context).followUpThePurchase,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => FinshPayPage(
                                                notes: _nots.text,

                                                totalPrice:
                                                    snapshot.data.totalPrice,
                                                totalQuantity:
                                                    snapshot.data.totalQuantity,
                                                // price: snapshot.data
                                                //         .cartItemModel.product[
                                                //     "price_after_sale"],
                                                // name: snapshot
                                                //     .data
                                                //     .cartItemModel
                                                //     .product["name"],
                                              )));
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
