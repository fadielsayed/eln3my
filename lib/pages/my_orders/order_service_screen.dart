import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/my_orders/order_json.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Orders>(
      builder: (context, ordersProvider, child) => FutureBuilder<
              List<MyReservations>>(
          future: ordersProvider.loadmyreservations(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  // appBar: appBar,
                  body: Center(
                child: Text(snapshot.error),
              ));
            }

            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return Scaffold(
                  // appBar: appBar,
                  body: Center(
                child: Text(  AppLocalizations.of(context).noData),
              ));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  // appBar: appBar,
                  body: Center(
                child: CircularProgressIndicator(),
              ));
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
                    AppLocalizations.of(context).serviceManagment,
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
                        MyReservations myReservations = snapshot.data[i];
                        return Card(
                          child: Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      myReservations.service["image"]),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            SizedBox( 
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context).dateOrder),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(myReservations.orderDate),
                                      SizedBox(
                                        width: 5,
                                      ),
                                     
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        myReservations.service["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Spacer(),
                                      Text(
                                        myReservations.notes,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    color: Colors.grey[100],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    child: Row(
                                      children: <Widget>[
                                        Text(AppLocalizations.of(context).yourOrderNum),
                                        Spacer(),
                                        Text(myReservations.id.toString())
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.grey[100],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    child: Row(
                                      children: <Widget>[
                                        Text(AppLocalizations.of(context).sumOrder),
                                        Spacer(),
                                        Text(myReservations.price.toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
