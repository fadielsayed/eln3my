import 'package:elnaamy_group/locale/localizations.dart';
import 'package:flutter/material.dart';

class ReturnDialog extends StatelessWidget {
   final TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).returnOrder),
         
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).reasonreturn),
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
              RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xff00577e),
                  onPressed: () {
                    // orders.addRatingProduct(
                    //     context: context,
                    //     productId: widget.productId,
                    //     rating: rating,
                    //     comment: _comment.text);
                    // Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).send),
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