import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/button/icon_title_button.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class AdvertisePlaceCard extends StatelessWidget {
  const AdvertisePlaceCard({
    required this.item,
    super.key,
  });
  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    if (item.title.ext.isNullOrEmpty) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.general.colorScheme.secondary,
        borderRadius: BorderRadius.circular(WidgetSizes.spacingS),
        border: Border.all(
          color: context.general.colorScheme.onSecondaryFixed.withOpacity(.3),
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidgetSizes.spacingS),
        ),
        tilePadding: EdgeInsets.zero,
        trailing: Icon(
          Icons.arrow_drop_down,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: _TitleExpension(item: item),
        children: [
          _TitleDescribtion(
            title: LocaleKeys.advertise_jobDescription.tr(),
            description: item.description ?? '-',
          ),
          _TitleDescribtion(
            title: LocaleKeys.advertise_options.tr(),
            description: item.gender.displayName,
          ),
          Padding(
            padding: const PagePadding.allLow(),
            child: _ActionButtons(item: item),
          ),
        ],
      ),
    );
  }
}

final class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconTitleButton(
          onPressed: () async {
            if (item.phoneNumber.ext.isNullOrEmpty) return;
            await RedirectionMixin.openToPhone(
              context: context,
              phoneNumber: item.phoneNumber!,
            );
          },
          icon: AppIcons.phone,
          text: LocaleKeys.button_call.tr(),
        ),
        const EmptyBox.smallWidth(),
        IconTitleButton(
          onPressed: () async {
            if (item.title.ext.isNullOrEmpty) return;
            await Share.share(
              '${LocaleKeys.advertise_message.tr()}'
              ' ${item.title}',
            );
          },
          icon: AppIcons.share,
          text: LocaleKeys.button_share.tr(),
        ),
      ],
    );
  }
}

class _TitleExpension extends StatelessWidget {
  const _TitleExpension({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allVeryLow(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.owner ?? '',
            overflow: TextOverflow.ellipsis,
            style: context.general.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.title ?? '',
            style: context.general.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: context.general.colorScheme.onSecondaryFixed.withOpacity(.3),
          ),
          _Subtitle(item.role ?? '-'),
        ],
      ),
    );
  }
}

class _TitleDescribtion extends StatelessWidget {
  const _TitleDescribtion({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allLow(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: context.general.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: context.general.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}

final class _Subtitle extends StatelessWidget {
  const _Subtitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.labelMedium?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}
