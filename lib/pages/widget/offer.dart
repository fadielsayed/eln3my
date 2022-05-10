import 'package:flutter/material.dart';

class OfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final servicesData = Provider.of<Servics>(context);
    // final services = servicesData.items;
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
        color: Colors.black.withOpacity(0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("10:15:01",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            Text("Hrs : Min : Sec",
                style: TextStyle(color: Colors.white, fontSize: 14))
          ],
        ),
      ),
    );
  }
}
