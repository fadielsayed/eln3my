import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/product/products_list.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).product),
      ),
      body: ProductList(),
    );
  }
}
