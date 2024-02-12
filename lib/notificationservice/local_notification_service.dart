import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Noti {
  void showNotification() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "notifications-youtube", "YouTube Notifications",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // DateTime scheduleDate = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    await notificationsPlugin.show(
        0, "Sample Notification", "This is a notification",
         notiDetails,
        payload: "notification-payload");
  }

  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload: $payload");
        }
      }
    }
  }
}
