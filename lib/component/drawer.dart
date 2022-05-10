import 'package:elnaamy_group/component/language_dialog.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/auth/signup/signup_page.dart';
import 'package:elnaamy_group/pages/drawer_items/about_page.dart';
import 'package:elnaamy_group/pages/drawer_items/connectus_page.dart';
import 'package:elnaamy_group/pages/home/home_main.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:elnaamy_group/pages/products_page.dart';
import 'package:elnaamy_group/pages/services_page/services_page.dart';
import 'package:elnaamy_group/pages/widget/dialog_log_out.dart';
import 'package:elnaamy_group/pages/widget/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../pages/my_account/my_account.dart';
// import 'package:maps/component/language_dialoge.dart';
// import 'package:maps/component/log_out_dialog.dart';
// import 'package:maps/component/oval-right-clipper.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  _buildDrawer() {
    var currentLocal = Localizations.localeOf(context).languageCode;

    final isLoggedIn =
        Provider.of<AppStateModel>(context, listen: false).userEntity != null;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context: context),
          isLoggedIn
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  color: Color(0xff143240),
                  child: FlatButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DilogLogOut();
                            });
                        // Provider.of<AppStateModel>(context, listen: false)
                        //     .unauthenticate();
                        // Navigator.pop(context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.white,
                      ),
                      label: Text(
                        AppLocalizations.of(context).logOut,
                        style: TextStyle(color: Colors.white),
                      )))
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  color: Color(0xff143240),
                  child: Row(
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                        icon: ImageIcon(
                          AssetImage("assets/icon/menu-usera.png"),
                          color: Colors.white,
                        ),
                        label: Text(
                          AppLocalizations.of(context).login,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "DinNextLight"),
                        ),
                      ),
                      Spacer(),
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignUpPage()));
                        },
                        icon: ImageIcon(
                          AssetImage("assets/images/add-user.png"),
                          color: Colors.white,
                        ),
                        label: Text(
                          AppLocalizations.of(context).newUser,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "DinNextLight"),
                        ),
                      ),
                    ],
                  ),
                ),
          _createDrawerItem(
              text: AppLocalizations.of(context).home,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeMain()));
              }),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: AppLocalizations.of(context).product,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductsPage()));
              }),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: AppLocalizations.of(context).services,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ServicesPage(
                            title: AppLocalizations.of(context).services,
                            offer: Container(),
                          )))),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: AppLocalizations.of(context).offersAndDiscount,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ServicesPage(
                            title:
                                AppLocalizations.of(context).offersAndDiscount,
                            offer: OfferPage(),
                          )))),
          Divider(
            height: 1,
            color: divider,
          ),
          if (isLoggedIn)
            _createDrawerItem(text: AppLocalizations.of(context).favorits),
          Divider(
            height: 1,
            color: divider,
          ),
          if (isLoggedIn)
            _createDrawerItem(
                text: AppLocalizations.of(context).myOrders,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MyOrderManagment()))),
          Divider(
            height: 1,
            color: divider,
          ),
          if (isLoggedIn)
            _createDrawerItem(
                text: AppLocalizations.of(context).myAccount,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyAccount()))),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(text: AppLocalizations.of(context).shareApp),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: AppLocalizations.of(context).aboutApp,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AboutAppPage()));
              }),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: AppLocalizations.of(context).contactus,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ConnectUs()));
              }),
          Divider(
            height: 1,
            color: divider,
          ),
          _createDrawerItem(
              text: currentLocal == "en" ? "عربي" : "English",
              onTap: () => Provider.of<AppStateModel>(context, listen: false)
                  .onLocaleChange(Locale(currentLocal == "en" ? "ar" : "en"))),
        ],
      ),
    );
  }
}

Widget _createDrawerItem({String text, GestureTapCallback onTap}) {
  return ListTile(
    onTap: onTap,
    title: Text(text),
  );
}

Widget _createHeader({BuildContext context}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.28,
    child: DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/baneer-menu.png'))),
      child: Text(""),
    ),
  );
}
