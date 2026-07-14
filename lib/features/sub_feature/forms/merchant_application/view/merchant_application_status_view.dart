import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

final class MerchantApplicationStatusView extends StatelessWidget {
  const MerchantApplicationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GeneralSubTitle(
          value: LocaleKeys.merchantApplication_status_title.tr(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const EmptyBox.largeHeight(),
            const _ReviewingBadge(),
            Text(
              LocaleKeys.merchantApplication_status_headline.tr(),
              style: AppText.displayLg.copyWith(),
              textAlign: TextAlign.center,
            ),
            GeneralContentSubTitle(
              value: LocaleKeys.merchantApplication_status_description.tr(),
              textAlign: TextAlign.center,
              color: AppColors.ink500,
            ),
            const _StatusTimelineCard(),
            const EmptyBox.largeXHeight(),
          ],
        ),
      ),
    );
  }
}

final class _ReviewingBadge extends StatelessWidget {
  const _ReviewingBadge();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const PagePadding.all(),
          decoration: const BoxDecoration(
            color: AppColors.gold200,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            AppIcons.hourglass,
            color: AppColors.gold,
            size: WidgetSizes.spacingXxl,
          ),
        ),
        const EmptyBox.middleHeight(),
        GeneralBodySmallTitle(
          LocaleKeys.merchantApplication_status_reviewing.tr().toUpperCase(),
          color: AppColors.gold,
        ),
      ],
    );
  }
}

final class _StatusTimelineCard extends StatelessWidget {
  const _StatusTimelineCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const PagePadding.all(),
      margin: const PagePadding.horizontal16Symmetric(),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.ink50),
      ),
      child: Column(
        children: [
          _StatusTimelineRow(
            icon: AppIcons.check,
            iconColor: AppColors.olive,
            backgroundColor: AppColors.olive50,
            title: LocaleKeys.merchantApplication_status_submitted.tr(),
            subtitle: DateFormat(
              'd MMMM y, HH:mm',
              context.locale.toString(),
            ).format(DateTime.now()),
          ),
          const EmptyBox.largeHeight(),
          _StatusTimelineRow(
            icon: AppIcons.hourglass,
            iconColor: AppColors.gold,
            backgroundColor: AppColors.gold200,
            title: LocaleKeys.merchantApplication_status_documentReview.tr(),
            subtitle: LocaleKeys.merchantApplication_status_documentReviewHint
                .tr(),
          ),
          const EmptyBox.largeHeight(),
          _StatusTimelineRow(
            icon: AppIcons.verifiedUser,
            iconColor: AppColors.ink400,
            backgroundColor: AppColors.ink50,
            title: LocaleKeys.merchantApplication_status_approval.tr(),
            subtitle: LocaleKeys.merchantApplication_status_approvalHint.tr(),
          ),
        ],
      ),
    );
  }
}

final class _StatusTimelineRow extends StatelessWidget {
  const _StatusTimelineRow({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const PagePadding.allVeryLow(),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: WidgetSizes.spacingL,
          ),
        ),
        const EmptyBox.middleWidth(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralBodyTitle(title),

              GeneralContentSubTitle(
                value: subtitle,
                color: AppColors.ink500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
