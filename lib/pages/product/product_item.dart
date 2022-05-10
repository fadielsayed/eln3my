import 'package:elnaamy_group/pages/product/product_details.dart';
import 'package:elnaamy_group/pages/widget/button_add_cart.dart';
import 'package:elnaamy_group/pages/widget/start_rating.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final int id;
  final Function onTapNavigDetails;
  final String lable;
  final String image;
  final String name;
  final int rate;
  final double oldPrice;
  final double newPrice;

  ProductItem(
      {Key key,
      this.id,
      this.onTapNavigDetails,
      this.lable,
      this.image,
      this.name,
      this.rate,
      this.oldPrice,
      this.newPrice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProductDetailsPage(
                      id: id,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  lable == "تخفيض"
                      ? Container(
                          // height: MediaQuery.of(context).size.height * 0.1,
                          // width: MediaQuery.of(context).size.width * 0.12,
                          child: Image.asset("assets/images/offer.png",scale: 3.5,))
                      : Container(
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Text(lable),
                        ),
                  Ink(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                name.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xff00577d)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  // SizedBox(width: 20.0,),
                                  StarRating(rating: rate)
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              oldPrice.toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              newPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ButtonAddCard(
                              productId: id,
                              quantity: 1,
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
