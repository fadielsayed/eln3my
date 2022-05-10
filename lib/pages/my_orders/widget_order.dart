import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/my_orders/order_details.dart';
import 'package:flutter/material.dart';

class WidgetOrder extends StatelessWidget {
  final int idOrder;
  final String status;
  final double totalPrice;
  final String orderDate;

  WidgetOrder(
      {Key key, this.idOrder, this.status, this.totalPrice, this.orderDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      ImageIcon(
                        status == "new"
                            ? AssetImage("assets/icon/order-new.png")
                            : status == "delivered"
                                ? AssetImage("assets/icon/order-done.png")
                                : AssetImage("assets/icon/order-new.png"),
                        size: 20,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        status,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       ImageIcon(
                //         AssetImage("assets/icon/order-preper.png"),
                //         color: Colors.blue,
                //         size: 20,
                //       ),
                //       SizedBox(
                //         width: 3,
                //       ),
                //       Text(
                //         "preparing",
                //         style: TextStyle(fontSize: 13),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       ImageIcon(
                //         AssetImage("assets/icon/order-way.png"),
                //         size: 20,
                //       ),
                //       SizedBox(
                //         width: 3,
                //       ),
                //       Text(
                //         "on way",
                //         style: TextStyle(fontSize: 14),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       ImageIcon(
                //         AssetImage("assets/icon/order-done.png"),
                //         size: 20,
                //       ),
                //       SizedBox(
                //         width: 3,
                //       ),
                //       Text(
                //         "done",
                //         style: TextStyle(fontSize: 14),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(AppLocalizations.of(context).dateOrder),
              SizedBox(
                width: 5,
              ),
              Text(orderDate),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Row(
              children: <Widget>[
                Text(AppLocalizations.of(context).yourOrderNum),
                Spacer(),
                Text("$idOrder")
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Row(
              children: <Widget>[
                Text(AppLocalizations.of(context).sumOrder),
                Spacer(),
                Text(totalPrice.toString())
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
