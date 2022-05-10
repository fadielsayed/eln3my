import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/services_page/service.dart';
import 'package:elnaamy_group/pages/widget/button_add_service_details.dart';
import 'package:elnaamy_group/pages/widget/datails_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class ServiceDetailsPage extends StatefulWidget {
  final int id;

  ServiceDetailsPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ServiceDetailsPageState createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  Future<ServiceDetails> loadDetils(BuildContext context) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;

    var header = {
      'content-type': 'application/json',
    };
    if (token != null || token != "") {
      header['Authorization'] = 'Bearer $token';
    }
    http.Response response =
        await http.get("$baseUrl/service/${widget.id}", headers: header);
    // setIsLoading(false);
    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(responseDecoded);
      try {
        if (responseDecoded["status"] == 1) {
          return ServiceDetails.fromJson(responseDecoded["data"]);
        } else {
          Toast.show(responseDecoded["message"], context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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
      throw AppLocalizations.of(context).cantLoad;
    }
  }

  Future favoriteProduct(
    BuildContext context,
  ) async {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    // setIsLoading(true);
    http.post('$baseUrl/favourite-service',
        body: json.encode({"service_id": widget.id}),
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
    // final ServicesData =
    //     Provider.of<ServiceDetailsProvider>(context, listen: false)
    //         .ServiceDetails;

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

          ServiceDetails serviceDetails = snapshot.data;
          return ItemDeatilsWidget(
              isFavorite: serviceDetails.isFavorite,
              name: serviceDetails.name,
              rate: serviceDetails.rate,
              newPrice: serviceDetails.newPrice,
              oldPrice: serviceDetails.oldPrice,
              description: serviceDetails.description,
              onFavortit: () {
                favoriteProduct(context);
              },
              swiper: Container(
                  child:
                      _swiper(context: context, images: serviceDetails.images)),
              bottomNavigationBar: ButtonAddServiceDetails());
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
