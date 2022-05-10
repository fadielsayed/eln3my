import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/auth/branch_json.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/home/home_main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SelectBranch extends StatelessWidget {
  Future<List<SelectBarnchJson>> _getBranchId(BuildContext context) async {
    http.Response response = await http.get("$baseUrl/branches",
        headers: {'content-type': 'application/json'});

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseDecoded);
      try {
        if (responseDecoded["status"] == 1) {
          List<SelectBarnchJson> lis = new List<SelectBarnchJson>();
          for (var u in responseDecoded["data"]) {
            print(u);
            lis.add(SelectBarnchJson.fromJson(u));
          }

          return lis;
        }
      } catch (e) {
        Toast.show(AppLocalizations.of(context).error, context,
            duration: 5, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xff696b9e),
      elevation: 0.0,
      title: Text(AppLocalizations.of(context).selectBranch),
      centerTitle: true,
      actions: <Widget>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<SelectBarnchJson>>(
        future: _getBranchId(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: _appBar(context),
                body: Center(
                  child: Text(snapshot.error),
                ));
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Scaffold(
                appBar: _appBar(context),
                body: Center(
                  child: Text(AppLocalizations.of(context).noData),
                ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                appBar: _appBar(context),
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          }

          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Color(0xff696b9e),
              elevation: 0.0,
              title: Text(AppLocalizations.of(context).selectBranch),
              centerTitle: true,
              actions: <Widget>[],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 145),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: MediaQuery.of(context).size.width * 0.98,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      37.43296265331129, -122.08832357078792),
                                  zoom: 10),
                              mapType: MapType.normal,
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int i) {
                            SelectBarnchJson selectBarnch = snapshot.data[i];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              selectBarnch.hosiptal["image"]),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              selectBarnch.hosiptal["name"],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              selectBarnch.hosiptal["address"],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<AppStateModel>(
                                    builder: (context, selectProvider, child) =>
                                        InkWell(
                                      onTap: () {
                                        selectProvider.repository.store
                                            .setSelectedBranch(selectBarnch.id);
                                        selectProvider
                                            .branchselect(selectBarnch.id);
                                        print(selectProvider.selectedBranch);
                                        Toast.show(
                                            "you Select  ${selectBarnch.name}",
                                            context,
                                            duration: 5,
                                            gravity: Toast.BOTTOM);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(8))),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .selectBranch,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/baneer-menu.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => HomeMain()));
                },
                child: Text(
                  "Folow",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
