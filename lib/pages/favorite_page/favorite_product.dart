import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elnaamy_group/pages/product/product_item.dart';
import 'favorite.dart';
import 'package:provider/provider.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';

class FavoriteProduct extends StatefulWidget {
  @override
  _FavoriteProductState createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  Future<List<Favorite>> loadedFavoritList(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    if (token == null || token == "") {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      return null;
    }
    http.Response response = await http.get("$baseUrl/my-favourites", headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(responseDecoded);

      try {
        if (responseDecoded["status"] == 1) {
          List<Favorite> lis = new List<Favorite>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(Favorite.fromJson(u));
          }
          return lis;
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
      Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
          duration: 5, gravity: Toast.BOTTOM);
      print("error");
    }
  }

  Future favoriteProduct({BuildContext context, int productId}) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    // setIsLoading(true);
    http.post('$baseUrl/favourite-product',
        body: json.encode({"product_id": productId}),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      // setIsLoading(false);
      dynamic responseDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseDecoded);
        try {
          if (responseDecoded["status"] == 1) {
            setState(() {});
          } else {
            Toast.show(responseDecoded["message"], context,
                duration: 5, gravity: Toast.BOTTOM);
          }
        } catch (e) {
          Toast.show(AppLocalizations.of(context).error, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show(AppLocalizations.of(context).someThingWorngHappen, context,
            duration: 5, gravity: Toast.BOTTOM);
        print("error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return FutureBuilder<List<Favorite>>(
        future: loadedFavoritList(context),
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
                Favorite favorite = snapshot.data[i];
                return Stack(
                  children: <Widget>[
                    ProductItem(
                      id: favorite.id,
                      lable: favorite.lable,
                      image: favorite.image,
                      name: favorite.name,
                      rate: favorite.rate,
                      oldPrice: favorite.oldPrice,
                      newPrice: favorite.newPrice,
                    ),
                    currentLocal == "en"
                        ? _iconClose(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              favoriteProduct(
                                  context: context, productId: favorite.id);
                            })
                        : _iconClose(
                            alignment: Alignment.topLeft,
                            onPressed: () {
                              favoriteProduct(
                                  context: context, productId: favorite.id);
                            })
                  ],
                );
              });
        });
  }

  Widget _iconClose({AlignmentGeometry alignment, Function onPressed}) {
    return Container(
      alignment: alignment,
      child: IconButton(
        icon: Icon(Icons.close),
        onPressed: onPressed,
      ),
    );
  }
}
