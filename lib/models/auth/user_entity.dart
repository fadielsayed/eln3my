class UserEntity {
  final int id;
  final String displayName;
  final String email;
  final String phone;

  UserEntity({this.id, this.displayName, this.email, this.phone});

  @override
  String toString() {
    return '{id: $id, displayName: $displayName,email:$email,phone:$phone }';
  }

  dynamic toJson() => {
        "id": this.id,
        "displayName": this.displayName,
        "email": this.email,
        "phone": this.phone
      };

  UserEntity compyWith(
      {String displayName, String photo, String email, String phone}) {
    return UserEntity(
        id: this.id,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        phone: phone ?? this.phone);
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
        id: json['id'] as int,
        displayName: json['displayName'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String);
  }
}
