import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:elnaamy_group/pages/product/product.dart';
import 'package:elnaamy_group/pages/widget/start_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogRatingStart extends StatefulWidget {
  final int productId;

  DialogRatingStart({Key key, this.productId}) : super(key: key);
  @override
  _DialogRatingStartState createState() => _DialogRatingStartState();
}

class _DialogRatingStartState extends State<DialogRatingStart> {
  int rating = 3;
  TextEditingController _comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).rateProduct),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: StarRating(
              starCount: 5,
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).notes),
          SizedBox(
            height: 5,
          ),
          TextField(
              maxLines: 2,
              controller: _comment,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              )),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Consumer<Orders>(
                builder: (context, orders, child) => RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xff00577e),
                  onPressed: () {
                    orders.addRatingProduct(
                        context: context,
                        productId: widget.productId,
                        rating: rating,
                        comment: _comment.text);
                    // Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).rateProduct),
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).close),
              )
            ],
          )
        ],
      ),
    );
  }
}
