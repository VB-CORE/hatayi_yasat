import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_status.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

final class MerchantApplicationStatusView extends ConsumerWidget {
  const MerchantApplicationStatusView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final application = authState is Authenticated
        ? authState.user.application
        : null;
    return Scaffold(
      appBar: AppBar(
        title: GeneralSubTitle(
          value: LocaleKeys.merchantApplication_status_title.tr(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: application == null
            ? GeneralNotFoundWidget(
                title: LocaleKeys.message_somethingWentWrong.tr(),
              )
            : _StatusBody(application: application),
      ),
    );
  }
}

final class _StatusBody extends StatelessWidget {
  const _StatusBody({required this.application});

  final Application application;

  @override
  Widget build(BuildContext context) {
    return switch (application.status) {
      MerchantApplicationStatus.pending => const _PendingContent(),
      MerchantApplicationStatus.approved => const _ApprovedContent(),
      MerchantApplicationStatus.denied => _DeniedContent(
        deniedMessage: application.deniedMessage,
      ),
    };
  }
}

final class _PendingContent extends StatelessWidget {
  const _PendingContent();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const _StatusTimelineCard(),
        const EmptyBox.largeXHeight(),
      ],
    );
  }
}

final class _ApprovedContent extends StatelessWidget {
  const _ApprovedContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StatusBadge(
          icon: AppIcons.check,
          iconColor: context.appColors.olive,
          backgroundColor: context.appColors.olive50,
          label: LocaleKeys.merchantApplication_status_approved.tr(),
          labelColor: context.appColors.olive,
        ),
        const EmptyBox.largeHeight(),
        Text(
          LocaleKeys.merchantApplication_status_approvedHeadline.tr(),
          style: AppText.displayLg,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

final class _DeniedContent extends StatelessWidget {
  const _DeniedContent({required this.deniedMessage});

  final String? deniedMessage;

  @override
  Widget build(BuildContext context) {
    final message = deniedMessage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StatusBadge(
          icon: AppIcons.close,
          iconColor: context.general.colorScheme.error,
          backgroundColor: context.appColors.coral100,
          label: LocaleKeys.merchantApplication_status_denied.tr(),
          labelColor: context.general.colorScheme.error,
        ),
        const EmptyBox.largeHeight(),
        Text(
          LocaleKeys.merchantApplication_status_deniedHeadline.tr(),
          style: AppText.displayLg,
          textAlign: TextAlign.center,
        ),
        if (message != null && message.isNotEmpty) ...[
          const EmptyBox.largeHeight(),
          _DeniedReasonCard(message: message),
        ],
      ],
    );
  }
}

final class _DeniedReasonCard extends StatelessWidget {
  const _DeniedReasonCard({required this.message});

  final String message;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralBodySmallTitle(
            LocaleKeys.merchantApplication_status_deniedReason.tr(),
            color: context.general.colorScheme.error,
          ),
          const EmptyBox.smallHeight(),
          GeneralContentSubTitle(
            value: message,
            color: context.appColors.ink500,
          ),
        ],
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
  const _StatusTimelineCard();

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
            subtitle: DateFormat(
              'd MMMM y, HH:mm',
              context.locale.toString(),
            ).format(DateTime.now()),
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
