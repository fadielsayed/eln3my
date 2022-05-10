import 'package:elnaamy_group/pages/services_page/service.dart';
import 'package:flutter/material.dart';

class Servics with ChangeNotifier {
  List<Service> _items = [
    // Service(
    //     id: 1,
    //     title:"Smile Holyod static",
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl: "assets/images/product3.png",
    //     offertime: "18:22:33"),
    // Service(
    //     id: 2,
    //     title: "Smile Holyod static",
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl: "assets/images/product4.png",
    //     offertime:"10:22:33"),
    // Service(
    //     id: 3,
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl: "assets/images/product3.png",
    //     offertime:"9:22:33"),
    // Service(
    //     id: 4,
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl: "assets/images/product4.png",
    //     offertime: "3:22:33"),
  ];
  List<Service> get items => _items;
}
