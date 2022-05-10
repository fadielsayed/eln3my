import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:elnaamy_group/pages/favorite_page/favorit_service.dart';
import 'package:elnaamy_group/pages/favorite_page/favorite_product.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).favoriteLists),
      ),
      body: (token == null||token=="")
          ? Center(
              child: FlatButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginPage())),
              child: Text(AppLocalizations.of(context).youShouldLogIn),
            ))
          : Column(
              children: <Widget>[
                Material(
                  color: Color(0xff143240),
                  child: TabBar(
                    // isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,

                    controller: _controller,
                    tabs: [
                      new Tab(
                        // icon: const Icon(Icons.HomeTab),
                        text: AppLocalizations.of(context).productFavorite,
                      ),
                      new Tab(
                        text: AppLocalizations.of(context).servicesFavorite,
                      ),
                    ],
                    labelColor: Colors.white,
                    indicatorColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Colors.white70,
                  ),
                ),
                Expanded(
                  // height: MediaQuery.of(context).size.height * 0.55,
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[FavoriteProduct(), FavoritService()],
                  ),
                ),
              ],
            ),
    );
  }
}
