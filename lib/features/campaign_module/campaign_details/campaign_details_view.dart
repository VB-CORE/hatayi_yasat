import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaign_details/mixin/campaign_details_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/calendar/calendar_model.dart';
import 'package:vbaseproject/product/package/calendar/calendar_utility.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/formatter/custom_date_time_formatter.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';
import 'package:vbaseproject/product/widget/dialog/phone_zoom_dialog.dart';
import 'package:vbaseproject/product/widget/sliver/home_appbar_sliver.dart';

final class CampaignDetailsView extends StatefulWidget {
  const CampaignDetailsView({required this.campaignModel, super.key});
  final CampaignModel campaignModel;

  @override
  State<CampaignDetailsView> createState() => _CampaignDetailsViewState();
}

class _CampaignDetailsViewState extends State<CampaignDetailsView>
    with CampaignDetailsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _FABButton(widget: widget),
      body: NotificationListener(
        onNotification: listenNotification,
        child: CustomScrollView(
          slivers: [
            ValueListenableBuilder<bool>(
              valueListenable: isPinnedNotifier,
              builder: (context, value, child) {
                return HomeAppBarSliver.fromCampaign(
                  model: campaignModel,
                  isPinned: value,
                );
              },
            ),
            _SliverDetail(model: campaignModel),
          ],
        ),
      ),
    );
  }
}

class _FABButton extends StatelessWidget {
  const _FABButton({required this.widget});

  final CampaignDetailsView widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.calendar_month_outlined),
      onPressed: () => CalendarUtility.saveCalendar(
        model: CalendarModel.fromCampaignModel(
          campaignModel: widget.campaignModel,
        ),
      ),
    );
  }
}

class _SliverDetail extends StatelessWidget {
  const _SliverDetail({
    required this.model,
  });

  final CampaignModel model;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_publisher).tr(),
          subtitle: Text(model.publisher ?? ''),
        ),
        const Divider(),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_topic).tr(),
          subtitle: Text(model.topic ?? ''),
        ),
        const Divider(),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_description).tr(),
          subtitle: Text(model.description ?? ''),
        ),
        if (model.phone.ext.isNotNullOrNoEmpty)
          Column(
            children: [
              const Divider(),
              ListTile(
                trailing: const Icon(Icons.call_outlined),
                title: const Text(LocaleKeys.campaignDetailsView_phone).tr(),
                subtitle: Text(model.phone!),
                onTap: () => RedirectionMixin.openToPhone(
                  context: context,
                  phoneNumber: model.phone!,
                ),
              ),
            ],
          ),
        const Divider(),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_expireDate).tr(),
          subtitle: Text(
            CustomDateTimeFormatter.formatValueTr(
              model.expireDate ?? DateTime.now(),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_photo).tr(),
          subtitle: InkWell(
            onTap: () =>
                PhoneZoomDialog(imageUrl: model.coverPhoto ?? '').show(context),
            child: CustomNetworkImage(
              imageUrl: model.coverPhoto,
            ),
          ),
        ),
      ]),
    );
  }
}
