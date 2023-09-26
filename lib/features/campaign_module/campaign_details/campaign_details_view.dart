import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaign_details/mixin/campaign_details_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/widget/dialog/phone_zoom_dialog.dart';
import 'package:vbaseproject/product/widget/package/custom_network_image.dart';

class CampaignDetailsView extends StatefulWidget {
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
      body: NotificationListener(
        onNotification: listenNotification,
        child: CustomScrollView(
          slivers: [
            ValueListenableBuilder<bool>(
              valueListenable: isPinnedNotifier,
              builder: (context, value, child) {
                return _SliverAppBar(
                  isPinned: value,
                  model: campaignModel,
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
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_topic).tr(),
          subtitle: Text(model.topic ?? ''),
        ),
        if (model.description.ext.isNotNullOrNoEmpty)
          ListTile(
            titleTextStyle: context.general.textTheme.titleMedium,
            title: const Text(LocaleKeys.campaignDetailsView_description).tr(),
            subtitle: Text(model.description ?? ''),
          ),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_startDate).tr(),
          subtitle: Text(model.startDate.toString()),
        ),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_endDate).tr(),
          subtitle: Text(model.endDate.toString()),
        ),
        ListTile(
          title: const Text(LocaleKeys.campaignDetailsView_photo).tr(),
          subtitle: SizedBox(
            height: context.sized.dynamicHeight(.2),
            child: InkWell(
              onTap: () {
                PhoneZoomDialog(imageUrl: model.coverPhoto ?? '').show(context);
              },
              child: CustomNetworkImage(
                imageUrl: model.coverPhoto,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({
    required this.isPinned,
    required this.model,
  });

  final bool isPinned;
  final CampaignModel model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL13,
      pinned: true,
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              context.general.colorScheme.background.withOpacity(0.5),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: context.general.colorScheme.background,
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: context.general.colorScheme.onSurface,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          color: isPinned ? null : Colors.black.withOpacity(0.5),
          width: isPinned ? null : context.sized.width,
          child: Padding(
            padding: const PagePadding.onlyLeft(),
            child: Text(
              model.name ?? '',
              style: context.general.textTheme.titleLarge?.copyWith(
                color: isPinned
                    ? context.general.colorScheme.onSurface
                    : context.general.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        titlePadding: isPinned ? null : EdgeInsets.zero,
        centerTitle: false,
        background: Hero(
          tag: ValueKey(model.documentId),
          child: CustomNetworkImage(
            imageUrl: model.coverPhoto,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
