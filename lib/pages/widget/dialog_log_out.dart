import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/home/home_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DilogLogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).areYouSure,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Color(0xff707070),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context).close,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500))),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black,
                ),
                GestureDetector(
                    onTap: () {
                      Provider.of<AppStateModel>(context, listen: false)
                          .unauthenticate();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false);
                    },
                    child: Text(AppLocalizations.of(context).yes,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)))
              ],
            )
          ],
        )),
      ),
    );
  }
}
