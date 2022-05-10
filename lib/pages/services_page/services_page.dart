import 'package:flutter/material.dart';
import './services_items.dart';
class ServicesPage extends StatelessWidget {
  final String title;
  final Widget offer;
  const ServicesPage({Key key, this.title, this.offer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: SrvicesItem(offer: offer,),
    );
  }
}
