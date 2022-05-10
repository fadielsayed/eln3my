import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/widget/button_add_cart_details.dart.dart';
import 'package:elnaamy_group/pages/widget/datails_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import './product.dart';
import 'package:toast/toast.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;

  ProductDetailsPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Future<ProductDetails> loadDetils(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;

    var header = {
      'content-type': 'application/json',
    };
    if (token != null || token != "") {
      header['Authorization'] = 'Bearer $token';
    }
    http.Response response =
        await http.get("$baseUrl/product/${widget.id}", headers: header);
    // setIsLoading(false);
    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseDecoded["data"]);
      try {
        if (responseDecoded["status"] == 1) {
          return ProductDetails.fromJson(responseDecoded["data"]);
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
      throw AppLocalizations.of(context).cantLoad;
    }
  }

  Future favoriteProduct(
    BuildContext context,
  ) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    // setIsLoading(true);
    http.post('$baseUrl/favourite-product',
        body: json.encode({"product_id": widget.id}),
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
    // final productsData =
    //     Provider.of<ProductDetailsProvider>(context, listen: false)
    //         .productDetails;

    return FutureBuilder(
        future: loadDetils(context),
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

          ProductDetails productDetails = snapshot.data;
          return ItemDeatilsWidget(
              id: widget.id,
              isFavorite: productDetails.isFavorite,
              name: productDetails.name,
              rate: productDetails.rate,
              newPrice: productDetails.newPrice,
              oldPrice: productDetails.oldPrice,
              description: productDetails.description,
              onFavortit: () {
                favoriteProduct(context);
              },
              swiper: Container(
                  child:
                      _swiper(context: context, images: productDetails.images)),
              bottomNavigationBar: ButtonaddCartDetails(
                productId: widget.id,
                quantity: 1,
              ));
        });
  }

  Widget _swiper({BuildContext context, List images}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      // width: MediaQuery.of(context).size.width*0.99,
      child: Swiper(
        autoplay: true,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return new Image.network(
            images[index],
            fit: BoxFit.contain,
          );
        },
        itemCount: images.length,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
