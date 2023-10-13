import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notification_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/notifier/loading_notifier.dart';
import 'package:vbaseproject/product/utility/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
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
          if (model == null || model.id.isEmpty) return const SizedBox.shrink();

          return Column(
            children: [
              ListTile(
                tileColor: _getColorByNotificationCreatedAt(model),
                contentPadding: const PagePadding.defaultPadding(),
                dense: true,
                leading: _NotificationTypeLeadingIcon(model: model),
                onTap: () => navigateToDetail(model),
                title: Text(model.body ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.createdAt != null)
                      Padding(
                        padding: const PagePadding.onlyTopLow(),
                        child: Text(
                          DateTimeFormatter.formatValueDetail(
                            model.createdAt!,
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right_outlined),
              ),
              const _CustomDivider(),
            ],
          );
        },
        // ...
      ),
    );
  }

  Color _getColorByNotificationCreatedAt(AppNotificationModel model) {
    return model.createdAt?.isAfter(lastNotificationSeen) ?? false
        ? ColorsCustom.white
        : ColorsCustom.lightGray;
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorsCustom.black,
      height: AppConstants.kZero.toDouble(),
      thickness: AppConstants.kZero.toDouble(),
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
