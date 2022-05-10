import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCart extends StatelessWidget {
  final int id;
  final int productId;
  final double price;
  final int quantity;
  final String title;
  final String image;
  final double totalPrice;

  const ItemCart(
      {Key key,
      this.id,
      this.productId,
      this.price,
      this.quantity,
      this.title,
      this.image,
      this.totalPrice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final _counter = Provider.of<Products>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Consumer<Cart>(
                builder: (context, cartRemove, child) => IconButton(
                  icon: Container(
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ),
                      decoration: new BoxDecoration(
                        border: new Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                      )),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title:
                                Text(AppLocalizations.of(context).areYouSure),
                            content: Text(
                                AppLocalizations.of(context).doYouWantRemove),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(AppLocalizations.of(context).no),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(AppLocalizations.of(context).yes),
                                onPressed: () {
                                  cartRemove.removeItemFromCart(
                                      context: context, productId: productId);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
              Container(
                  width: 90,
                  height: 100,
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                    image: new DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.fitHeight,
                    ),
                  )),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "$price SR",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Consumer<Cart>(
                    builder: (context, cartProvider, child) => Row(
                      children: <Widget>[
                        //
                        Container(
                          width: 50,
                          child: _button(
                            onPressed: () {
                              int q = quantity + 1;
                              cartProvider.updateQuantity(
                                  context: context,
                                  productId: productId,
                                  quantity: q);
                            },
                            icon: Icons.add,
                          ),
                        ),
                        Card(
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 3),
                              child: Text(
                                "$quantity",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        Container(
                          width: 50,
                          child: _button(
                              onPressed: () {
                                int q = quantity - 1;
                                cartProvider.updateQuantity(
                                    context: context,
                                    productId: productId,
                                    quantity: q);
                              },
                              icon: Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).sum,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        "$totalPrice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({Function onPressed, IconData icon}) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Icon(
          icon,
          size: 20,
        ),
      ),
    );
  }
}
