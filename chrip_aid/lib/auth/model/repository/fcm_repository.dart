import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmRepositoryProvider = Provider((ref) {
  return FcmRepository();
});


class FcmRepository {
  Future<String> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance
        .getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
    if (fcmToken == null) throw Exception("FCM Token 발급 에러");
    return fcmToken;
  }
}