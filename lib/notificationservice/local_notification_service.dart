import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  
}

class NotificationService {

 static Future<void> initialize() async {
    try {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          log(token);
        }

        FirebaseMessaging.onBackgroundMessage(backgroundHandler);

        log("Notifications Initialized!");
      } else {
        log("Notification permission denied.");
      }
    } catch (e) {
      log("Error initializing notifications: $e");
      // Handle the error appropriately, e.g., show an error dialog or log it
    }
  }


}
