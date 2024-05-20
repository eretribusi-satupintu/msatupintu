import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

  

    final fcmToken = await _firebaseMessaging.getToken();
    return fcmToken!;
  }
}
