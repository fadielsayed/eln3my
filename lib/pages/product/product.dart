import 'package:flutter/foundation.dart';

class Product {
  final int id;
  final String name;
  final double oldPrice;
  final double newPrice;

  final String lable;
  final bool isInStock;
  final String image;
  final int rate;
  Product({
    @required this.id,
    @required this.name,
    @required this.oldPrice,
    @required this.newPrice,
    @required this.lable,
    @required this.isInStock,
    this.image,
    @required this.rate,
  });
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as int) ?? 0,
      name: (json['name'] as String) ?? "Product Name not found",
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

class ProductDetails extends Product {
  final bool isFavorite;
  final String description;
  final List images;

  ProductDetails(
      {@required id,
      @required name,
      @required oldPrice,
      @required newPrice,
      @required lable,
      @required isInStock,
      @required rate,
      image,
      @required this.isFavorite,
      @required this.description,
      @required this.images})
      : super(
            id: id,
            name: name,
            oldPrice: oldPrice,
            newPrice: newPrice,
            lable: lable,
            isInStock: isInStock,
            rate: rate,
            image: image);

  static ProductDetails fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: (json['id'] as int) ?? 0,
      name: (json['name'] as String) ?? "Product Name not found",
      oldPrice: json['price_before_sale'] == null
          ? 0.0
          : double.tryParse(json['price_before_sale'] as String),
      newPrice: json['price_after_sale'] == null
          ? 0.0
          : double.tryParse(json['price_after_sale'] as String),
      lable: (json['label'] as String) ?? "",
      isInStock: (json['is_in_stock'] as bool) ?? false,
      rate: (json['rate'] as int) ?? 0,
      isFavorite: (json['is_favourite'] as bool) ?? false,
      description:
          (json['description'] as String) ?? "description not avalible",
      // image: (json['image'] as String) ?? "",
      images: (json['photos'] as List) ?? [],

      // image: (json['image'] as List<String>) ?? "",
    );
  }
}
