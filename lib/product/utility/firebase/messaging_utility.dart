import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/model/firebase/notification_model.dart';

enum _SubscriptionTopic {
  everyone;
}

@immutable
final class MessagingUtility {
  const MessagingUtility._();

  static Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance
        .subscribeToTopic(_SubscriptionTopic.everyone.name);
  }

  static Future<NotificationModel?> getInitialData() async {
    final response = await FirebaseMessaging.instance.getInitialMessage();

    final messageBody = response?.data;
    if (messageBody == null || messageBody.isEmpty) return null;
    return NotificationModel.fromJson(messageBody);
  }

  /// This method is used to listen notification when user in app
  static void listenData({
    required ValueChanged<MapEntry<String, NotificationModel>>
        onMessageHandleInApp,
    required ValueChanged<NotificationModel> onMessageHandle,
  }) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final messageBody = event.data;
      if (messageBody.isEmpty) return;
      onMessageHandleInApp.call(
        MapEntry(
          event.notification?.title ?? '',
          NotificationModel.fromJson(messageBody),
        ),
      );
    });

    FirebaseMessaging.onMessage.listen((event) {
      final messageBody = event.data;
      if (messageBody.isEmpty) return;
      // TODO: default message notification geldi
      onMessageHandleInApp.call(
        MapEntry(
          event.notification?.body ?? '',
          NotificationModel.fromJson(messageBody),
        ),
      );
    });
  }
}
