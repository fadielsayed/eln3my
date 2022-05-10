import 'package:flutter/cupertino.dart';

class SelectBarnchJson {
  final int id;
  final String name;
  final String delevryCoast;
  final int hospitalId;
  final Map<String, dynamic> hosiptal;

  SelectBarnchJson(
      {@required this.id,
      this.name,
      this.delevryCoast,
      this.hospitalId,
      @required this.hosiptal});
  static SelectBarnchJson fromJson(Map<String, dynamic> json) {
    return SelectBarnchJson(
        id: (json['id'] as int) ?? 0,
        name: (json['name'] as String) ?? "name",
        delevryCoast: (json['delivery_cost'] as String) ?? "0",
        hospitalId: (json['hospital_id'] as int) ?? 0,
        hosiptal: (json['hospital'] as Map) ?? {});
  }
}
