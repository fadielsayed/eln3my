import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/products_page.dart';
import 'package:elnaamy_group/pages/widget/offer.dart';
import 'package:elnaamy_group/pages/services_page/services_page.dart';
import 'package:flutter/material.dart';

class SectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).sectionStore),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: GridView.count(
              primary: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(5.0),
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 40,
              crossAxisSpacing: 41,
              children: <Widget>[
                _gestureDetector(
                    context: context,
                    img: "assets/images/catogry-medicine.png",
                    text: AppLocalizations.of(context).productMedicine,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductsPage()))),
                _gestureDetector(
                    context: context,
                    img: "assets/images/catogry-examination.png",
                    text: AppLocalizations.of(context).servicesMedicine,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ServicesPage(
                                  title:  AppLocalizations.of(context).services,
                                  offer: Container(),
                                )))),
                _gestureDetector(
                    context: context,
                    img: "assets/images/catogry-discount.png",
                    text:AppLocalizations.of(context).offersAndDiscount,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ServicesPage(
                                  title: AppLocalizations.of(context).offersAndDiscount,
                                  offer: OfferPage(),
                                )))),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _gestureDetector(
          {BuildContext context,
          String img,
          String text,
          Function onPressed}) =>
      GestureDetector(
        onTap: onPressed,
        child: Card(
          color: Theme.of(context).accentColor,
          // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ImageIcon(
                  AssetImage(img),
                  size: 75,
                  color: Colors.white,
                ),
                // child: Container(
                //   width: 80,
                //   height: 65,
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).accentColor,
                //       image: DecorationImage(
                //           image: AssetImage(img), fit: BoxFit.fill)),
                // ),
              ),
              Positioned(
                  bottom: 10,
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 6),
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: MediaQuery.of(context).size.height / 25,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      text,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DinNextLight"),
                    )),
                  ))
            ],
          ),
        ),
      );
}
