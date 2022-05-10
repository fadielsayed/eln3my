import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/widget/button_add_service.dart';
import 'package:elnaamy_group/pages/widget/start_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './service.dart';
import './service_details.dart';

class SrvicesItem extends StatelessWidget {
  final Widget offer;

  SrvicesItem({Key key, this.offer}) : super(key: key);

  Future<List<Service>> loadServiceList(BuildContext context) async {
    final branchId = Provider.of<AppStateModel>(context);
     var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;

    var header = {
      'content-type': 'application/json',
    };
    if (token != null || token != "") {
      header['Authorization'] = 'Bearer $token';
    }
    http.Response response = await http.get(
        "$baseUrl/services?branch_id=${branchId.selectedBranch}",
        headers: header);

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(responseDecoded);
      try {
        if (responseDecoded["status"] == 1) {
          List<Service> lis = new List<Service>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(Service.fromJson(u));
          }
          return lis;
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show(AppLocalizations.of(context).error, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final servicesData = Provider.of<Servics>(context);
    // final services = servicesData.items;
    // final cart = Provider.of<Cart>(context);

    return FutureBuilder(
        future: loadServiceList(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                body: Center(
              child: Text(snapshot.error),
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

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                Service service = snapshot.data[i];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ServiceDetailsPage(
                                  id: service.id,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: service.image.isEmpty
                                      ? Image.asset(
                                          "assets/images/no_image.png")
                                      : Image.network(
                                          service.image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                ),
                                height: 150,
                                width: 400,
                              ),
                              offer
                            ],
                          ),
                          Card(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        service.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          // SizedBox(width: 20.0,),
                                          StarRating(rating: service.rate)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        service.oldPrice.toString(),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Text(
                                        service.newPrice.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      ButtonAddService(
                                        serviceId: service.id,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
