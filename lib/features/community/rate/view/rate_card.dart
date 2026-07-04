import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/view/mixin/rate_community_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';
import 'package:lifeclient/product/widget/text_field/index.dart';

class RateCard extends ConsumerStatefulWidget {
  const RateCard({required this.esnafId, super.key});
  final String esnafId;

  @override
  ConsumerState<RateCard> createState() => _RateCardState();
}

class _RateCardState extends ConsumerState<RateCard>
    with RateCommentControllerMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen(rateCommunityProviderProvider(widget.esnafId), onVoteChanged);

    final state = ref.watch(rateCommunityProviderProvider(widget.esnafId));
    final notifier = ref.read(
      rateCommunityProviderProvider(widget.esnafId).notifier,
    );

    return Container(
      margin: const PagePadding.all(),
      padding: const PagePadding.all(),
      decoration: _cardDecoration(state.isReadOnly),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RateCardHeader(isReadOnly: state.isReadOnly),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 4),
            child: AppRatingWidget(
              itemSize: 40,
              value: state.value,
              isReadOnly: state.isReadOnly,
              onRatingUpdate: notifier.selectRating,
            ),
          ),
          if (!state.isReadOnly)
            _RateCommentSection(
              controller: commentController,
              canSubmit: state.canSubmit,
              onSubmit: () => notifier.submit(comment: commentController.text),
            ),
        ],
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
            Icon(Icons.verified_user, size: 24, color: accent),
            const EmptyBox.smallWidth(),
            Text(
              LocaleKeys.rate_trustQuestion.tr(),
              style: context.general.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          isReadOnly
              ? LocaleKeys.rate_voteRecorded.tr()
              : LocaleKeys.rate_singleVoteHint.tr(),
          style: context.general.textTheme.labelMedium?.copyWith(
            color: ColorsCustom.darkGray,
          ),
        ),
      ],
    );
  }
}

class _RateCommentSection extends StatelessWidget {
  const _RateCommentSection({
    required this.controller,
    required this.canSubmit,
    required this.onSubmit,
  });
  final TextEditingController controller;
  final bool canSubmit;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.rate_evaluatePlace.tr(),
          style: context.general.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const EmptyBox.smallHeight(),
        CustomTextFormMultiField(
          hint: '2 kişi oyladı - ort:4.5',
          controller: controller,
          validator: ValidatorNormalTextField(),
        ),
        const EmptyBox.middleHeight(),
        GeneralButtonV2.active(
          label: LocaleKeys.button_send.tr(),
          isEnabled: canSubmit,
          action: onSubmit,
        ),
      ],
    );
  }
}
