import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/product/product.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


// class Product {
//   final int id;
//   final String name;
//   final double oldPrice;
//   final double newPrice;

//   final String lable;
//   final String isInStock;

//   Product({
//     @required this.id,
//     @required this.name,
//     @required this.oldPrice,
//     @required this.newPrice,
//     @required this.lable,
//     @required this.isInStock,
//   });
// }

class Products with ChangeNotifier {
  int _count = 1;
  int get count => _count;

  List<Product> _items = [
    // Product(
    //     id: 1,
    //     name: "Cream for acne oily skin",
    //     // description: 'A red shirt - it is pretty red!',
    //     oldPrice: 29.99,
    //     newPrice: 10.99,
    //     image: "assets/images/product1.png",
    //     isInStock: false,
    //     rate: 2,
    //     lable: "assets/images/new.png"),
    // Product(
    //     id: 1,
    //     name: "Cream for acne oily skin",
    //     // description: 'A red shirt - it is pretty red!',
    //     oldPrice: 29.99,
    //     newPrice: 10.99,
    //     image: "assets/images/product2.png",
    //     isInStock: true,
    //     lable: "assets/images/offer.png",
    //     rate: 4),
    // Product(
    //     id: 1,
    //     name: "Cream for acne oily skin",
    //     // description: 'A red shirt - it is pretty red!',
    //     oldPrice: 29.99,
    //     newPrice: 10.99,
    //     image: "assets/images/product3.png",
    //     isInStock: false,
    //     lable: "assets/images/new.png",
    //     rate: 4),
  ];
  List<Product> get items => [..._items];

  void addProduct() {
    _count++;
    notifyListeners();
  }

  void minsProduct() {
    if (_count <= 1) {
      return;
    }
    _count--;
    notifyListeners();
  }

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future getListOfProduct() async {
    http.get("$baseUrl/products?branch_id=1", headers: {
      'content-type': 'application/json'
    }).then((http.Response response) {
      final responseDecoded = json.decode(response.body);
      // List<Product> loadedProduct;
      if (response.statusCode == 200) {
        // print(responseDecoded);
        try {
          // if (responseDecoded["status"] == 1) {
          //   responseDecoded.forEach((prodId, prodData) {
          //     loadedProduct.add(Product(
          //         id: prodId,
          //         description: prodData[""],
          //         imageUrl: null,
          //         price: null,
          //         title: null));
          //   });
          //   _items = loadedProduct;
          //   notifyListeners();
          // }
        } catch (e) {}
      }
    });
  }
}
