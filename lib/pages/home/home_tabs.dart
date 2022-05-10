import 'package:elnaamy_group/pages/services_page/services_items.dart';
import 'package:elnaamy_group/pages/widget/offer.dart';
import 'package:elnaamy_group/pages/product/products_list.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                text: 'Product',
              ),
              new Tab(
                text: 'Services',
              ),
              Tab(
                text: 'Offers',
              ),
            ],
            labelColor: Colors.white,
            indicatorColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              ProductList(),
              SrvicesItem(
                offer: Container(),
              ),
              SrvicesItem(
                offer: OfferPage(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
