import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class DropDownBranch extends StatelessWidget {
  Future<List> _getBranchId(BuildContext context) async {
    http.Response response = await http.get("$baseUrl/branches",
        headers: {'content-type': 'application/json'});

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(responseDecoded);
      try {
        if (responseDecoded["status"] == 1) {
          return responseDecoded["data"];
        }
      } catch (e) {
        Toast.show(AppLocalizations.of(context).error, context, duration: 5, gravity: Toast.BOTTOM);
        throw AppLocalizations.of(context).cantLoad;
      }
    } else {
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getBranchId(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Container(); 
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Container();
          }
          return Consumer<AppStateModel>(
              builder: (context, appModel, child) =>
                  DropdownButtonHideUnderline(
                    child: Theme(
                      data: ThemeData.dark(),
                      child: DropdownButton(
                        items: snapshot.data?.map<DropdownMenuItem<int>>((map) {
                          return DropdownMenuItem<int>(
                            value: map["id"],
                            child: new Text(
                              map["name"],
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        })?.toList(),

                        onChanged: (value) async {
                          await appModel.repository.store
                              .setSelectedBranch(value);
                          appModel.branchselect(value);
                          print(appModel.selectedBranch);
                        },
                        // isExpanded: false,
                        value: appModel.selectedBranch,
                        hint: Text(
                          AppLocalizations.of(context).selectBranch,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ));
        });
  }
}
