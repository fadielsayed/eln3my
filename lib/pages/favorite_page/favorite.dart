import 'package:flutter/material.dart';

class Favorite {
  final int id;
  final String name;
  final double oldPrice;
  final double newPrice;

  final String lable;
  final bool isInStock;
  final String image;
  final int rate;
  Favorite({
    @required this.id,
    @required this.name,
    @required this.oldPrice,
    @required this.newPrice,
    @required this.lable,
    @required this.isInStock,
    this.image,
    @required this.rate,
  });
  static Favorite fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: (json['id'] as int) ?? 0,
      name: (json['name'] as String) ?? "Favorite Name not found",
      oldPrice: json['price_before_sale'] == null
          ? 0
          : double.tryParse(json['price_before_sale'] as String),
      newPrice: json['price_after_sale'] == null
          ? 0
          : double.tryParse(json['price_after_sale'] as String),
      lable: (json['label'] as String) ?? "",
      isInStock: (json['is_in_stock'] as bool) ?? false, //change reminder
      rate: (json['rate'] as int) ?? 0,
      image: (json['image'] as String) ?? "",
    );
  }
}
