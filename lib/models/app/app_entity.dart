enum AppState {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  notCompleted,
  notVerified
}

class AppData {
  final String token;
  final String languageCode;
  // final bool isCompleted;
  // final bool isWheelEnabled;//remove now

  AppData({
    this.token,
    this.languageCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppData &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          languageCode == other.languageCode;

  @override
  int get hashCode => token.hashCode ^ languageCode.hashCode;

  @override
  String toString() {
    return 'AppData{token: $token, languageCode: $languageCode,}';
  }

  dynamic toJson() => {
        "token": this.token,
        "languageCode": this.languageCode,
      };

  AppData compyWith({
    bool isCompleted,
    String langCode,
  }) {
    return AppData(
        languageCode: langCode ?? this.languageCode, token: this.token);
  }

  static AppData fromJson(Map<String, dynamic> json) {
    return AppData(
      token: (json['token'] as String) ?? "",
      languageCode: (json['languageCode'] as String) ?? "en",
    );
  }
}
