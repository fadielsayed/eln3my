import 'package:flutter/cupertino.dart';

class MyAddress {
  final int id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String destination;
  final String region;
  final String address;
  final String zipCode;
  final int cityID;
  final int clintId;

  MyAddress(
      {this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.companyName,
      @required this.destination,
      @required this.region,
      @required this.address,
      @required this.zipCode,
      this.cityID,
      this.clintId});

  static MyAddress fromJson(Map<String, dynamic> json) {
    return MyAddress(
      id: (json['id'] as int) ?? 0,
      firstName: (json['first_name'] as String) ?? " first_name not found",
      lastName: (json['last_name'] as String) ?? " last_name not found",
      companyName: (json['company_name'] as String) ?? " company not found",
      destination: (json['destination'] as String) ?? " destination not found",
      region: (json['region'] as String) ?? " region not found",
      address: (json['address'] as String) ?? " address not found",
      zipCode: (json['zip_code'] as String) ?? " zipCode not found",
      cityID: (json['city_id'] as int) ?? 0,
      clintId: (json['client_id'] as int) ?? 0,
    );
  }
}
