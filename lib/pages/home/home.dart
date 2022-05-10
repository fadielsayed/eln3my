import 'package:elnaamy_group/component/drawer.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:elnaamy_group/pages/cart_screen/screen_cart.dart';
import 'package:elnaamy_group/pages/home/dropdown_branch.dart';
import 'package:elnaamy_group/pages/home/swiper_widget.dart';
import 'package:elnaamy_group/pages/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<String> locations = ['dmam', 'maka'];

  // var selectedLocationIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Container(
              width: 120,
              height: 50,
              child: ImageIcon(
                AssetImage("assets/images/logo-title.png"),
              ),
            ),
            VerticalDivider(color: Colors.white, width: 20),
            Expanded(
              child: DropDownBranch(),
            )
            // PopupMenuButton(

            //   onSelected: (index) {
            //     setState(() {
            //       selectedLocationIndex = index;
            //     });
            //   },
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         locations[selectedLocationIndex],
            //         style: TextStyle(color: Colors.white, fontSize: 12),
            //       ),
            //       Icon(
            //         Icons.keyboard_arrow_down,
            //         color: Colors.white,
            //       )
            //     ],
            //   ),
            //   itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
            //     PopupMenuItem(
            //       child: Text(
            //         locations[0],
            //         style: TextStyle(color: Colors.black, fontSize: 12),
            //       ),
            //       value: 0,
            //     ),
            //     PopupMenuItem(

            //       child: Text(
            //         locations[1],
            //         style: TextStyle(color: Colors.black, fontSize: 12),
            //       ),
            //       value: 1,
            //     ),
            //   ],
            // ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          // Consumer<Cart>(
          //   builder: (_, cartData, child) => Badge(
          //     color: Color(0xff143240),
          //     value: cartData.itemCount.toString(),
          //     child:
          IconButton(
            icon: ImageIcon(
              AssetImage("assets/icon/icon-cart.png"),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ScreenCart()));
            },
          ),
          //   ),
          // )
        ],
        leading: IconButton(
          icon: ImageIcon(
            AssetImage("assets/icon/icon-menu.png"),
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        // bottom: _buildBottomBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            SwiperPage(),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xff143240),
              child: Text(
                AppLocalizations.of(context).subscribenow,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height / 20,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: AppLocalizations.of(context).searchForProduct,
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff143240),
                  borderRadius: new BorderRadius.all(Radius.circular(5.0))),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 11,
              child: IconButton(
                icon: ImageIcon(
                  AssetImage("assets/icon/icon-filter.png"),
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () {},
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      preferredSize: Size.fromHeight(70.0),
    );
  }
}
