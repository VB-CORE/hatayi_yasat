import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

final class MerchantApplicationPendingView extends StatelessWidget {
  const MerchantApplicationPendingView(this.application, {super.key});

  final UserApplicationModel application;

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
            _StatusBadge(
              icon: AppIcons.hourglass,
              iconColor: context.appColors.gold,
              backgroundColor: context.appColors.gold200,
              label: LocaleKeys.merchantApplication_status_reviewing.tr(),
              labelColor: context.appColors.gold,
            ),
            Text(
              LocaleKeys.merchantApplication_status_headline.tr(),
              style: AppText.displayLg,
              textAlign: TextAlign.center,
            ),
            GeneralContentSubTitle(
              value: LocaleKeys.merchantApplication_status_description.tr(),
              textAlign: TextAlign.center,
              color: context.appColors.ink500,
            ),
            _StatusTimelineCard(
              submittedAt: application.createdAt ?? DateTime.now(),
            ),
            const EmptyBox.largeXHeight(),
          ],
        ),
      ),
    );
  }
}

final class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.label,
    required this.labelColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const PagePadding.all(),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: WidgetSizes.spacingXxl,
          ),
        ),
        const EmptyBox.middleHeight(),
        GeneralBodySmallTitle(label.toUpperCase(), color: labelColor),
      ],
    );
  }
}

final class _StatusTimelineCard extends StatelessWidget {
  const _StatusTimelineCard({required this.submittedAt});

  final DateTime submittedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const PagePadding.all(),
      margin: const PagePadding.horizontal16Symmetric(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: context.general.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _StatusTimelineRow(
            icon: AppIcons.check,
            iconColor: context.appColors.olive,
            backgroundColor: context.appColors.olive50,
            title: LocaleKeys.merchantApplication_status_submitted.tr(),
            subtitle: submittedAt.dateTimeLabel,
          ),
          const EmptyBox.largeHeight(),
          _StatusTimelineRow(
            icon: AppIcons.hourglass,
            iconColor: context.appColors.gold,
            backgroundColor: context.appColors.gold200,
            title: LocaleKeys.merchantApplication_status_documentReview.tr(),
            subtitle: LocaleKeys.merchantApplication_status_documentReviewHint
                .tr(),
          ),
          const EmptyBox.largeHeight(),
          _StatusTimelineRow(
            icon: AppIcons.verifiedUser,
            iconColor: context.general.colorScheme.onSurfaceVariant,
            backgroundColor: context.general.colorScheme.outlineVariant,
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
                color: context.appColors.ink500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
