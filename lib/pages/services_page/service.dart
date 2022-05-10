import 'package:flutter/foundation.dart';

class Service {
  final int id;
  final String name;
  final double oldPrice;
  final double newPrice;

  final String image;
  final int rate;
  Service({
    @required this.id,
    @required this.name,
    @required this.oldPrice,
    @required this.newPrice,
     this.image,
    @required this.rate,
  });
  static Service fromJson(Map<String, dynamic> json) {
    return Service(
      id: (json['id'] as int) ?? 0,
      name: (json['name'] as String) ?? "Service Name not found",
      oldPrice: json['price_before_sale'] == null
          ? 0
          : double.tryParse(json['price_before_sale'] as String),
      newPrice: json['price_after_sale'] == null
          ? 0
          : double.tryParse(json['price_after_sale'] as String),
      // isInStock: (json['in_stock'] as bool) ?? false, //change reminder
      rate: (json['rate'] as int) ?? 0,
      image: (json['image'] as String) ?? "",
    );
  }
}

class ServiceDetails extends Service {
  final bool isFavorite;
  final String description;
  final List  images;

  ServiceDetails({
    @required id,
    @required name,
    @required oldPrice,
    @required newPrice,
    @required rate,
     image,
    @required this.isFavorite,
    @required this.description,
    @required this.images
  }) : super(
            id: id,
            name: name,
            oldPrice: oldPrice,
            newPrice: newPrice,
            rate: rate,
            image : image);

  static ServiceDetails fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      id: (json['id'] as int) ?? 0,
      name: (json['name'] as String) ?? "Product Name not found",
      oldPrice: json['price_before_sale'] == null
          ? 0.0 
          : double.tryParse(json['price_before_sale'] as String),
      newPrice: json['price_after_sale'] == null
          ? 0.0
          : double.tryParse(json['price_after_sale'] as String),
      rate: (json['rate'] as int) ?? 0,
      isFavorite: (json['is_favourite'] as bool) ?? false,
      description:
          (json['description'] as String) ?? "description not avalible",
      // image: (json['image'] as String) ?? "",

      images: (json['photos'] as List) ?? [],
    );
  }
}
