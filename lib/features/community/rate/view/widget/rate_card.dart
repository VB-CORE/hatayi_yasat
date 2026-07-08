import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/view/mixin/rate_community_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';

class RateCard extends ConsumerStatefulWidget {
  const RateCard({
    required this.esnafId,
    super.key,
    this.onSubmitted,
    this.initialComment,
  });
  final String esnafId;
  final VoidCallback? onSubmitted;
  final String? initialComment;

  static Future<void> show(
    BuildContext context, {
    required String esnafId,
    String? initialComment,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: CustomRadius.large.topLeft),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: sheetContext.general.keyboardPadding,
        ),
        child: RateCard(
          esnafId: esnafId,
          initialComment: initialComment,
          onSubmitted: () => Navigator.of(sheetContext).pop(),
        ),
      ),
    );
  }

  @override
  ConsumerState<RateCard> createState() => _RateCardState();
}

class _RateCardState extends ConsumerState<RateCard>
    with AppProviderMixin<RateCard>, RateCommentControllerMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      rateCommunityProviderProvider(widget.esnafId),
      onRateStateChanged,
    );

    final state = ref.watch(rateCommunityProviderProvider(widget.esnafId));
    final notifier = ref.read(
      rateCommunityProviderProvider(widget.esnafId).notifier,
    );

    return PopScope(
      canPop: !state.isBusy,
      child: Container(
        margin: const PagePadding.all(),
        padding: const PagePadding.all(),
        decoration: _cardDecoration(state.isReadOnly),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RateCardHeader(isReadOnly: state.isReadOnly),
            Padding(
              padding: const PagePadding.onlyTopMedium(),
              child: AppRatingWidget(
                itemSize: AppIconSizes.largeX,
                value: state.value,
                isReadOnly: state.isReadOnly || state.isBusy,
                onRatingUpdate: notifier.selectRating,
              ),
            ),
            const EmptyBox.middleHeight(),
            if (state.isReadOnly)
              _RateCommentSection(
                title: LocaleKeys.rate_editComment.tr(),
                buttonLabel: LocaleKeys.button_save.tr(),
                controller: commentController,
                canSubmit: state.canSubmit,
                isBusy: state.isBusy,
                onSubmit: () => notifier.editComment(commentController.text),
              )
            else
              _RateCommentSection(
                title: LocaleKeys.rate_evaluatePlace.tr(),
                buttonLabel: LocaleKeys.button_send.tr(),
                controller: commentController,
                canSubmit: state.canSubmit,
                isBusy: state.isBusy,
                onSubmit: () =>
                    notifier.submit(comment: commentController.text),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(bool isReadOnly) => BoxDecoration(
    color: ColorsCustom.white,
    borderRadius: CustomRadius.medium,
    border: Border.all(
      color: isReadOnly ? ColorsCustom.green : ColorsCustom.softGray,
    ),
  );
}

class _RateCardHeader extends StatelessWidget {
  const _RateCardHeader({required this.isReadOnly});
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final accent = isReadOnly ? ColorsCustom.green : ColorsCustom.imperilRead;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.verifiedUser,
              size: AppIconSizes.large,
              color: accent,
            ),
            const EmptyBox.smallWidth(),
            GeneralContentTitle(
              value: LocaleKeys.rate_trustQuestion.tr(),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        const EmptyBox.smallHeight(),
        GeneralContentSmallTitle(
          value: isReadOnly
              ? LocaleKeys.rate_voteRecorded.tr()
              : LocaleKeys.rate_singleVoteHint.tr(),
          color: ColorsCustom.darkGray,
        ),
      ],
    );
  }
}

class _RateCommentSection extends StatelessWidget {
  const _RateCommentSection({
    required this.title,
    required this.buttonLabel,
    required this.controller,
    required this.canSubmit,
    required this.onSubmit,
    required this.isBusy,
  });
  final String title;
  final String buttonLabel;
  final TextEditingController controller;
  final bool canSubmit;
  final VoidCallback onSubmit;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralBodyTitle(title, fontWeight: FontWeight.bold),
        const EmptyBox.smallHeight(),
        CustomTextFormMultiField(
          hint: LocaleKeys.rate_commentHint.tr(),
          controller: controller,
          validator: ValidatorNormalTextField(),
          enabled: !isBusy,
        ),
        const EmptyBox.middleHeight(),
        GeneralButtonV2.active(
          label: buttonLabel,
          isEnabled: canSubmit,
          action: onSubmit,
        ),
      ],
    );
  }
}
