import 'package:flutter/material.dart';

class MyReservations {
  final int id;
  final String notes;
  final String orderDate;
  final double price;
  final double totalPrice;
  final Map<String, dynamic> service;
  MyReservations({
    @required this.id,
    @required this.notes, 
    @required this.orderDate,
    @required this.price,
    @required this.totalPrice,
    @required this.service,
  });
  static MyReservations fromJson(Map<String, dynamic> json) {
    return MyReservations(
      id: (json['id'] as int) ?? 0,
      notes: (json['notes'] as String) ?? " notes not found",
      price: json['price'] == null
          ? 0.0
          : double.tryParse(json['price'] as String),
      orderDate: (json['created_at'] as String) ?? DateTime.now().toString(),
      totalPrice: json['total_price'] == null
          ? 0.0
          : double.tryParse(json['total_price'] as String),
      service: (json["service"] as Map) ?? null,
    );
  }
}

class MyOrders {
  final int id;
  final String status;
  final int clientId;
  final int shippingId;
  final int branchId;
  final double price;
  final double totalPrice;
  final double commission;
  final double deliveryCost;
  final int paymentMethodId;
  final int promoCodeId;
  final String notes;
  final String orderDate;

  MyOrders(
      {@required this.id,
      @required this.status,
      @required this.clientId,
      @required this.shippingId,
      @required this.branchId,
      @required this.price,
      @required this.totalPrice,
      @required this.commission,
      @required this.deliveryCost,
      @required this.paymentMethodId,
      @required this.promoCodeId,
      @required this.orderDate,
      @required this.notes});

  static MyOrders fromJson(Map<String, dynamic> json) {
    return MyOrders(
        id: (json['id'] as int) ?? 0,
        status: (json['status'] as String) ?? "non status",
        clientId: (json['client_id'] as int) ?? 0,
        shippingId: (json['shipping_id'] as int) ?? 0,
        branchId: (json['branch_id'] as int) ?? 0,
        price: json['price'] == null
            ? 0.0
            : double.tryParse(json['price'] as String),
        totalPrice: json['total_price'] == null
            ? 0.0
            : double.tryParse(json['total_price'] as String),
        commission: json['commission'] == null
            ? 0.0
            : double.tryParse(json['commission'] as String),
        deliveryCost: json['delivery_cost'] == null
            ? 0.0
            : double.tryParse(json['delivery_cost'] as String),
        paymentMethodId: (json['payment_method_id'] as int) ?? 0,
        promoCodeId: (json['promo_code_id'] as int) ?? 0,
        orderDate: (json['created_at'] as String) ?? DateTime.now().toString(),
        notes: (json['notes'] as String) ?? "no notes");
  }
}

class OrdersDetails extends MyOrders {
  final List products;
  OrdersDetails(
      {@required this.products,
      @required id,
      @required status,
      @required branchId,
      @required price,
      @required totalPrice,
      @required orderDate,
      clientId,
      shippingId,
      commission,
      deliveryCost,
      paymentMethodId,
      promoCodeId,
      notes})
      : super(
            id: id,
            status: status,
            branchId: branchId,
            price: price,
            totalPrice: totalPrice,
            orderDate: orderDate,
            clientId: clientId,
            shippingId: shippingId,
            commission: commission,
            deliveryCost: deliveryCost,
            paymentMethodId: paymentMethodId,
            promoCodeId: promoCodeId,
            notes: notes);

  static OrdersDetails fromJson(Map<String, dynamic> json) {
    return OrdersDetails(
      products: (json['products'] as List) ?? [],
      id: (json['id'] as int) ?? 0,
      status: (json['status'] as String) ?? "non status",
      branchId: (json['branch_id'] as int) ?? 0,
      price: json['price'] == null
          ? 0.0
          : double.tryParse(json['price'] as String),
      totalPrice: json['total_price'] == null
          ? 0.0
          : double.tryParse(json['total_price'] as String),
      orderDate: (json['created_at'] as String) ?? DateTime.now().toString(),
    );
  }
}
