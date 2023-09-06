import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'package:vbaseproject/features/home/view/home_view.dart';
import 'package:vbaseproject/features/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/model/firebase/notification_model.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_utility.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';

mixin HomeNotificationMixin
    on AppProviderMixin<HomeView>, ConsumerState<HomeView> {
  final _customService = FirebaseService();
  Future<void> listenToNotification() async {
    final initialNotification = await MessagingUtility.getInitialData();
    if (initialNotification != null) {
      await _navigateToDetail(initialNotification);
    }
    MessagingUtility.listenData(
      onMessageHandle: _navigateToDetail,
      onMessageHandleInApp: _openSnackbarMessage,
    );
  }

  Future<void> _navigateToDetail(NotificationModel model) async {
    final id = model.id;
    if (id == null || id.isEmpty) return;
    await MessagingNavigate.instance.navigateDetailNotification(
      context: context,
      id: id,
      customService: _customService,
    );
  }

  Future<void> _openSnackbarMessage(
    MapEntry<String, NotificationModel> model,
  ) async {
    final id = model.value.id;
    if (id == null || id.isEmpty) return;
    appProvider.showSnackbarNotification(model.key, id, context);
  }
}
