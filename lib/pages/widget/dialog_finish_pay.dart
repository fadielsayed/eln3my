import 'package:elnaamy_group/locale/localizations.dart';
import 'package:flutter/material.dart';

class DialogFinishPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        // title: Text("Return Order"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Image.asset(
              "assets/images/logo-about.png",
              scale: 5,
            )),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "You Request is done",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[300],
              child: Row(
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context).yourOrderNum,
                    style: TextStyle(fontSize: 13),
                  ),
                  Spacer(),
                  Text("15445#", style: TextStyle(fontSize: 13))
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: (){},
              child: Text(
                "more details you connect the service users",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 14),
              ),
            ),SizedBox(
              height: 35,
            ),
            Divider(thickness: 2,),
            Center(
                child: Image.asset(
              "assets/images/promo.png",
              scale: 2,
            )),
          ],
        ),
      
    );
  }
}
