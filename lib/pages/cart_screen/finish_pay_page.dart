import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address_provider.dart';
import 'package:elnaamy_group/pages/adresse_pages/my_address_json.dart';
import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:elnaamy_group/pages/widget/dialog_finish_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class FinshPayPage extends StatefulWidget {
  final double totalPrice;
  final int totalQuantity;
  final double price;
  final String name;
  final String notes;
  FinshPayPage(
      {Key key,
      this.totalPrice,
      this.totalQuantity,
      this.price,
      this.name,
      this.notes})
      : super(key: key);
  @override
  _FinshPayPageState createState() => _FinshPayPageState();
}

class _FinshPayPageState extends State<FinshPayPage> {
  MyAddress selectedAddress;
  bool isSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("انهاء الدفع"),
        backgroundColor: Color(0xff00577d),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context).invoiceDetails,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<AddressProvider>(
                builder: (context, addressProvider, child) => FutureBuilder(
                    future: addressProvider.loadAllAddress(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (snapshot.error == "No Address" ||
                            snapshot.error == "لايوجد عنوان") {
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Text(AppLocalizations.of(context)
                                    .noAddressGoToAddAddress),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => AddAddress()));
                                    },
                                    child: Text(AppLocalizations.of(context)
                                        .addAddress))
                              ],
                            ),
                          );
                        }
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
                      return ListTile(
                        onTap: () {},
                        title: Text(selectedAddress == null
                            ? AppLocalizations.of(context).selectAddress
                            : "${selectedAddress.region}- ${selectedAddress.destination}"),
                        subtitle: Text(selectedAddress == null
                            ? ""
                            : "${selectedAddress.address}- ${selectedAddress.zipCode}"),
                        leading: Icon(
                          Icons.location_on,
                          size: 35,
                          color: Theme.of(context).accentColor,
                        ),
                        trailing: FlatButton(
                          onPressed: () {
                            var controller = _scaffoldkey.currentState
                                .showBottomSheet((context) => Container(
                                    height: 350.0,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, i) {
                                                MyAddress myAddress =
                                                    snapshot.data[i];

                                                return ListTile(
                                                  selected: isSelected,
                                                  onTap: () {
                                                    // myAddress.id;
                                                    setState(() {
                                                      selectedAddress =
                                                          myAddress;
                                                    });
                                                    _bottomSheetController
                                                        .close();
                                                    print(myAddress.id);
                                                  },
                                                  leading: Icon(
                                                    Icons.location_on,
                                                    size: 35,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  title: Text(
                                                      "${myAddress.region} - ${myAddress.destination} }"),
                                                  subtitle: Text(
                                                      "${myAddress.address} - ${myAddress.zipCode}"),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon:
                                                              Icon(Icons.check),
                                                          onPressed: null)
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    )));

                            setState(() {
                              _bottomSheetController = controller;
                            });
                          },
                          child: Text(AppLocalizations.of(context).chanage),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context).yourOrder,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "#10115",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Cream for acne oily skin",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("290 sr"),
                    Spacer(),
                    Text(widget.totalQuantity.toString() + "x"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context).sum),
                          Text(
                            widget.totalPrice.toString(),
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          // Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context).shipping),
                          Text("50 sr",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context).tax5vat),
                          Text("35 sr",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor)),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).totalAmount,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.totalPrice + 35 + 50}",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   color: Colors.grey[300],
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text("Do you have a vouchers"),
              //         Row(
              //           children: <Widget>[
              //             Expanded(
              //                 child: Container(
              //               height: MediaQuery.of(context).size.height / 17,
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                   focusedBorder: OutlineInputBorder(
              //                     borderSide: BorderSide(
              //                       color: Colors.black26,
              //                     ),
              //                   ),
              //                   filled: true,
              //                   fillColor: Colors.white,
              //                   focusColor: Colors.white,
              //                 ),
              //               ),
              //             )),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             RaisedButton(
              //               onPressed: () {},
              //               color: Colors.black,
              //               child: Text(
              //                 "Use Coupon",
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // Container(
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.black)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: <Widget>[
              //         Row(
              //           children: <Widget>[
              //             Radio(
              //               value: 1,
              //               activeColor: Colors.blue,
              //               groupValue: group,
              //               onChanged: (T) {
              //                 setState(() {
              //                   group = T;
              //                 });
              //               },
              //             ),
              //             Text(
              //               "Mada card",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 15),
              //             ),
              //             SizedBox(
              //               width: 35,
              //             ),
              //             Image.asset(
              //               "assets/images/mada.png",
              //               scale: 3,
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: <Widget>[
              //             Radio(
              //               value: 2,
              //               activeColor: Colors.blue,
              //               groupValue: group,
              //               onChanged: (T) {
              //                 setState(() {
              //                   group = T;
              //                 });
              //               },
              //             ),
              //             Text(
              //               "Sadad Card",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 15),
              //             ),
              //             SizedBox(
              //               width: 35,
              //             ),
              //             Image.asset(
              //               "assets/images/sadad.png",
              //               scale: 3,
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: <Widget>[
              //             Radio(
              //               value: 3,
              //               activeColor: Colors.blue,
              //               groupValue: group,
              //               onChanged: (T) {
              //                 setState(() {
              //                   group = T;
              //                 });
              //               },
              //             ),
              //             Text(
              //               "Paiement when recieving",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 15),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Privacy policy",
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    Consumer<Orders>(
                      builder: (_, radioValue, child) => Checkbox(
                        value: radioValue.radioValue,
                        onChanged: (bool value) {
                          radioValue.setRadioValue(value);
                        },
                      ),
                    ),
                    Text(AppLocalizations.of(context).iAgreeAll,
                        style: TextStyle(fontSize: 14)),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context).termsAndConditions,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<Orders>(
                builder: (context, orders, child) => Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xff143240),
                    ),
                    child: FlatButton(
                      child: Text(
                        AppLocalizations.of(context).confirmation,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (selectedAddress == null) {
                          Toast.show(
                              AppLocalizations.of(context)
                                  .youShouldSelectaddress,
                              context,
                              duration: 5,
                              gravity: Toast.BOTTOM);
                          return;
                        }
                        if (orders.radioValue == false) {
                          Toast.show(
                              AppLocalizations.of(context)
                                  .youShouldApproveTermsAndCondition,
                              context,
                              duration: 5,
                              gravity: Toast.BOTTOM);
                          return;
                        }
                        orders.newOrder(
                            context: context,
                            shippingId: selectedAddress.id,
                            paymentMethodId: 1,
                            notes: widget.notes);

                        // showDialog(
                        //     context: context,
                        //     builder: (ctx) {
                        //       return DialogFinishPay();
                        //     });
                      },
                    ),
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
  }
}
