import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/home/view/home_view.dart';
import 'package:vbaseproject/product/package/firebase/messaging_utility.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/mixin/notification_type_mixin.dart';
import 'package:vbaseproject/sub_feature/notification_navigate/notificaiton_navigate_parse.dart';

mixin HomeViewMixin
    on
        ConsumerState<HomeView>,
        NotificationTypeMixin,
        AppProviderMixin<HomeView> {
  @override
  void initState() {
    super.initState();
    MessagingUtility.init();
    listenToNotification();
  }

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
    await NotificationNavigateParse(context).makeWithModel(
      model: model,
    );
  }

  Future<void> _openSnackbarMessage(
    MapEntry<String, NotificationModel> model,
  ) async {
    final (type, id) = modelConvertToType(model.value);
    if (type == null) return;

    appProvider.showSnackbarNotification(
      model.key,
      id,
      context,
      type,
    );
  }
}
