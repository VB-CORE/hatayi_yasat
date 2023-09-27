import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/notifications/notification_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/firebase/messaging_navigate.dart';
import 'package:vbaseproject/product/utility/notifier/loading_notifier.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/package/shimmer/place_shimmer_list.dart';

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
      body: ValueListenableBuilder<List<AppNotificationModel>>(
        valueListenable: notificationNotifier,
        builder: (context, value, child) {
          if (value.isEmpty) return const PlaceShimmerList();
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.length,
            itemBuilder: (context, index) {
              final model = value[index];
              return ListTile(
                onTap: () async {
                  if (loadingNotifier.value) return;
                  showLoading();
                  await MessagingNavigate.instance.detailModelCheckAndNavigate(
                    context: context,
                    id: model.id,
                    customService: customService,
                  );
                  hideLoading();
                },
                title: Text(model.title ?? ''),
                subtitle: Text(model.body ?? ''),
                trailing: const Icon(Icons.chevron_right_outlined),
              );
            },
          );
        },
      ),
    );
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
