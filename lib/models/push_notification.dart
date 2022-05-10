import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();
  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
      PushNotificationsManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _intilize = false;

  Future<void> init() async {
    if (!_intilize) {
      //ios config permission
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      String token = await _firebaseMessaging.getToken();
      print("My New Token=$token");
      _intilize = true;
    }
  }
}
