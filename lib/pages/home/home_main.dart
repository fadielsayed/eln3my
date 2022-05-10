import 'package:elnaamy_group/component/drawer.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/favorite_page/favorite_tab.dart';
import 'package:elnaamy_group/pages/home/home.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:flutter/material.dart';

import '../section_pages.dart';
import '../my_account/my_account.dart';
import '../favorite_page/favorite_product.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedTabIndex = 0;

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: IndexedStack(
        children: <Widget>[
          Home(),
          SectionPage(),
          MyOrderManagment(),
          FavoriteTab(),
          MyAccount(),
        ],
        index: _selectedTabIndex,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Color(0xff143240),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.blue,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icon/menu-homea.png"),
                ),
                title: Text(
                  AppLocalizations.of(context).home,
                  style: TextStyle(
                    fontFamily: 'DinNextRegular',
                  ),
                )),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icon/menu-catogrya.png"),
                  size: 21,
                ),
                title: Text(
                  AppLocalizations.of(context).section,
                  style: TextStyle(
                    fontFamily: 'DinNextRegular',
                  ),
                )),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icon/menu-trackinga.png"),
                  size: 28,
                ),
                title: Text(
                  AppLocalizations.of(context).myOrders,
                  style: TextStyle(
                    fontFamily: 'DinNextRegular',
                  ),
                )),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icon/menu-hearta.png"),
                ),
                title: Text(
                AppLocalizations.of(context).favorits,
                  style: TextStyle(
                    fontFamily: 'DinNextRegular',
                  ),
                )),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icon/menu-usera.png"),
                ),
                title: Text(
                 AppLocalizations.of(context).myAccount,
                  style: TextStyle(
                    fontFamily: 'DinNextRegular',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
