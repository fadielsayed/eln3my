import 'dart:convert';

class Settings {
  final int id;
  final String appUrl;
  final String aboutApp;
  final String privacyPolice;
  final String termsConditions;
  final String replacementPolicy;

  Settings(
      {this.id,
      this.appUrl,
      this.aboutApp,
      this.privacyPolice,
      this.termsConditions,
      this.replacementPolicy});

  static Settings fromJson(Map<String, dynamic> json) {
    return Settings(
        id: (json["id"] as int) ?? 0,
        appUrl: (json["app_url"] as String) ?? "",
        aboutApp: (json["about_app"] as String) ?? "",
        privacyPolice: (json["privacy_police"] as String) ?? "",
        termsConditions: (json["terms_conditions"] as String) ?? "",
        replacementPolicy: (json["replacement_policy"] as String) ?? "");
  }
}
