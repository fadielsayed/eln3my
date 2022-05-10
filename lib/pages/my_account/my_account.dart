import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/drawer_items/privcy_policy_page.dart';
import 'package:elnaamy_group/pages/adresse_pages/adresse_page.dart';
import 'package:elnaamy_group/pages/favorite_page/favorite_tab.dart';
import 'package:elnaamy_group/pages/my_account/replace_policy_page.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:elnaamy_group/pages/widget/dialog_log_out.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './account_details.dart';
import './terms_and_conditions.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final isLoggedIn =
        Provider.of<AppStateModel>(context, listen: false).userEntity != null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).myAccount),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            _list(
                img: "assets/icon/account-box.png",
                text: AppLocalizations.of(context).myOrders,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MyOrderManagment()))),
            _divider(context),
            _list(
                img: "assets/icon/account-place.png",
                text: AppLocalizations.of(context).address,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdressePage()))),
            _divider(context),
            _list(
                img: "assets/icon/account-heart.png",
                text: AppLocalizations.of(context).favoriteLists,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FavoriteTab()))),
            _divider(context),
            _list(
                img: "assets/icon/account-user.png",
                text: AppLocalizations.of(context).accountDeatails,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AccountDetails()))),
            _divider(context),
            _list(
                img: "assets/icon/account-box2.png",
                text: AppLocalizations.of(context).replacementAndReturnPolicy,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ReplacePloicy()))),
            _divider(context),
            _list(
                img: "assets/icon/account-gold-medal.png",
                text: AppLocalizations.of(context).priacyPolicy,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PrivacyPolicy()))),
            _divider(context),
            _list(
                img: "assets/icon/account-id-card.png",
                text: AppLocalizations.of(context).termsAndConditions,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TermsAndConditons()))),
            _divider(context),
            // _list(
            //     img: "assets/icon/account-hours.png",
            //     text: AppLocalizations.of(context).replaceMentAndReturnRequest,
            //     onPressed: () => Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => RepalcementRequest()))),
            // _divider(context),
            isLoggedIn?
            _list(
                img: "assets/icon/account-log-out.png",
                text: AppLocalizations.of(context).logOut,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) { 
                        return DilogLogOut();
                      });
                }):SizedBox(),
            // _divider(context),
          ],
        ),
      ),
    );
    
  }

  Widget _divider(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Divider(
          color: Colors.grey.shade600,
        ),
      );
  Widget _list({String img, String text, Function onPressed}) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              ImageIcon(
                AssetImage(img),
                color: Colors.black,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 18, fontFamily: "DinNextBold"),
              ),
            ],
          ),
        ),
      );
}
