import 'package:flutter/material.dart';

class CartModel {
  final double totalPrice;
  final int totalQuantity;
  final List<CartItemModel> cartItemModel;

  CartModel({this.totalPrice, this.totalQuantity, this.cartItemModel});
}

class CartItemModel {
  final int id;
  final int orderId;

  final String name;
  final int productId;
  final int quantity;
  final double price;
  final double totalPrice;
  final Map<String, dynamic> product;
  CartItemModel(
      {@required this.id,
      @required this.orderId,
      @required this.name,
      @required this.quantity,
      @required this.price,
      @required this.totalPrice,
      @required this.product,
      @required this.productId});
  static CartItemModel fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: (json['id'] as int) ?? 0,
      productId: (json["product_id"] as int) ?? 0,
      orderId: (json["order_id"] as int) ?? 0,
      name: (json['name'] as String) ?? " Name not found",
      price: json['price'] == null
          ? 0.0
          : double.tryParse(json['price'] as String),
      quantity: (json['quantity'] as int) ?? 0,
      totalPrice: json['total_price'] == null
          ? 0.0
          : double.tryParse(json['total_price'] as String),
      product: (json["product"] as Map) ?? null,
    );
  }
}
