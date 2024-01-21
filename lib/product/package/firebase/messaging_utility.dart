import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

@immutable
final class MessagingUtility {
  const MessagingUtility._();

  static Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();
    await Future.wait([
      FirebaseMessaging.instance
          .subscribeToTopic(NotificationTopics.toAll.rawValue),
      FirebaseMessaging.instance
          .subscribeToTopic(NotificationTopics.forCampaign.rawValue),
      FirebaseMessaging.instance
          .subscribeToTopic(NotificationTopics.news.rawValue),
      FirebaseMessaging.instance
          .subscribeToTopic(NotificationTopics.advertise.rawValue),
    ]);
  }

  static Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
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
      onMessageHandle.call(
        NotificationModel.fromJson(messageBody),
      );
    });

    FirebaseMessaging.onMessage.listen((event) {
      final messageBody = event.data;
      if (messageBody.isEmpty) return;
      onMessageHandleInApp.call(
        MapEntry(
          event.notification?.body ??
              LocaleKeys.notification_defaultMessage.tr(),
          NotificationModel.fromJson(messageBody),
        ),
      );
    });
  }
}
