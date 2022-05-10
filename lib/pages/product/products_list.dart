import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';

import 'package:elnaamy_group/pages/product/product_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import './product.dart';
import 'package:toast/toast.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Product>> loadProductList(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;

    var header = {
      'content-type': 'application/json',
    };
    if (token != null || token != "") {
      header['Authorization'] = 'Bearer $token';
    }
    final branchId = Provider.of<AppStateModel>(context);
    http.Response response = await http.get(
        "$baseUrl/products?branch_id=${branchId.selectedBranch}",
        headers: header);

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        if (responseDecoded["status"] == 1) {
          // print(responseDecoded);
          List<Product> lis = new List<Product>();
          for (var u in responseDecoded["data"]["data"]) {
            // print(u);
            lis.add(Product.fromJson(u));
          }
          return lis;
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: 5, gravity: Toast.BOTTOM);
          throw responseDecoded["message"];
        }
      } catch (e) {
        Toast.show("error catch", context, duration: 5, gravity: Toast.BOTTOM);
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
    // final productsData = Provider.of<Products>(context, listen: false);
    // final products = productsData.items;
    // final cart = Provider.of<Cart>(context);
    return FutureBuilder<List<Product>>(
        future: loadProductList(context),
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
                Product product = snapshot.data[i];
                return ProductItem(
                  id: product.id,
                  lable: product.lable,
                  image: product.image,
                  name: product.name,
                  rate: product.rate,
                  oldPrice: product.oldPrice,
                  newPrice: product.newPrice,
                );
              });
        });
  }
}
