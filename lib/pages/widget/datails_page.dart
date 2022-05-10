import 'dart:ui';

import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/widget/start_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

class ItemDeatilsWidget extends StatefulWidget {
  final int id;
  final bool isFavorite;
  final String name;
  final int rate;
  final double newPrice;
  final double oldPrice;
  final String description;
  final Widget swiper;
  final Widget bottomNavigationBar;
  final Function onFavortit;

  ItemDeatilsWidget(
      {Key key,
      @required this.swiper,
      @required this.isFavorite,
      @required this.name,
      @required this.rate,
      @required this.newPrice,
      @required this.oldPrice,
      @required this.description,
      this.bottomNavigationBar,
      this.id, this.onFavortit})
      : super(key: key);

  @override
  _ItemDeatilsWidgetState createState() => _ItemDeatilsWidgetState();
}

class _ItemDeatilsWidgetState extends State<ItemDeatilsWidget> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).productDetails),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    widget.swiper,
                    Consumer<AppStateModel>(
                      builder: (context, toogleProvite, child) => Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            widget.isFavorite == false
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed:widget.onFavortit
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        // SizedBox(width: 20.0,),
                        StarRating(rating: widget.rate)
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Text(widget.newPrice.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                            backgroundColor: Color(0xffb2b2b2),
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(widget.oldPrice.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.lineThrough,
                              backgroundColor: Color(0xffb2b2b2))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(AppLocalizations.of(context).description,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),

                Divider(
                  thickness: 1,
                ),

                Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                SizedBox(
                  height: 20,
                ),
                // Spacer(),
                // FlatButton( child: Text("data"),onPressed: (){},),
                // Center(
                //   child: Container(
                //     width: MediaQuery.of(context).size.width * 0.62,
                //     height: 50,
                //     child: MaterialButton(
                //       color: Theme.of(context).accentColor,
                //       elevation: 0,
                //       onPressed: () {},
                //       child: Container(
                //         child: Text(
                //           "Buy Now",
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               // fontSize: 18.0,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500),
                //         ),
                //       ),
                //     ),

                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.bottomNavigationBar);
  }
}
