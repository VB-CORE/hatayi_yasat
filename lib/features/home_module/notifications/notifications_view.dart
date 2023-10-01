import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notification_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/notification_type.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/notifier/loading_notifier.dart';
import 'package:vbaseproject/product/utility/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/icon_size.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with LoadingNotifier<NotificationsView>, NotificationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.home_notifications).tr(),
        actions: [
          _Loading(loadingNotifier: loadingNotifier),
        ],
      ),
      body: FirestoreListView<AppNotificationModel?>(
        query: reference(),
        emptyBuilder: (_) => NotFoundLottie(
          title: LocaleKeys.notFound_notification.tr(),
          onRefresh: () {},
        ),
        loadingBuilder: (context) => const PlaceShimmerList(),
        itemBuilder: (context, doc) {
          final model = doc.data();
          if (model == null) return const SizedBox.shrink();
          return ListTile(
            onTap: () async {
              if (loadingNotifier.value) return;
              showLoading();
              if (model.type == AppNotificationType.campaign) {
                await MessagingNavigate.instance
                    .detailModelCampaignCheckAndNavigate(
                  context: context,
                  id: model.id,
                  customService: customService,
                );
              } else {
                await MessagingNavigate.instance.detailModelCheckAndNavigate(
                  context: context,
                  id: model.id,
                  customService: customService,
                );
              }

              hideLoading();
            },
            leading: _NotificationTypeLeadingIcon(model: model),
            title: Text(model.title ?? ''),
            dense: true,
            subtitle: Text(model.body ?? ''),
            trailing: const Icon(Icons.chevron_right_outlined),
          );
        },
        // ...
      ),
    );
  }
}

class _NotificationTypeLeadingIcon extends StatelessWidget {
  const _NotificationTypeLeadingIcon({
    required this.model,
  });

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return model.type == AppNotificationType.campaign
        ? const Icon(Icons.campaign_outlined)
        : const Icon(Icons.home_outlined);
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    required this.loadingNotifier,
  });

  final ValueNotifier<bool> loadingNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: loadingNotifier,
      child: const Padding(
        padding: PagePadding.allLow(),
        child: CircularProgressIndicator(),
      ),
      builder: (BuildContext context, bool value, Widget? child) {
        if (!value) return const SizedBox.shrink();
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
