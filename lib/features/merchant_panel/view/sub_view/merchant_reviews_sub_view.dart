import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_state.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/mixin/merchant_reviews_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

part 'widget/merchant_review_card.dart';
part 'widget/merchant_review_filter_bar.dart';

final class MerchantReviewsSubView extends ConsumerStatefulWidget {
  const MerchantReviewsSubView({required this.storeId, super.key});

  final String storeId;

  @override
  ConsumerState<MerchantReviewsSubView> createState() =>
      _MerchantReviewsSubViewState();
}

final class _MerchantReviewsSubViewState
    extends ConsumerState<MerchantReviewsSubView>
    with
        AppProviderMixin<MerchantReviewsSubView>,
        MerchantReviewsMixin<MerchantReviewsSubView> {
  @override
  String get storeId => widget.storeId;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantReviewsViewModelProvider(widget.storeId));

    if (state.isFetching) return const PlaceShimmerList();
    if (state.isError && state.reviews.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.message_somethingWentWrong.tr(),
        onRefresh: () => unawaited(
          ref
              .read(merchantReviewsViewModelProvider(widget.storeId).notifier)
              .retry(),
        ),
      );
    }

    final reviews = state.visibleReviews;

    return Column(
      children: [
        _MerchantReviewFilterBar(
          state: state,
          onChanged: (filter) => ref
              .read(merchantReviewsViewModelProvider(widget.storeId).notifier)
              .changeFilter(filter),
        ),
        if (reviews.isEmpty)
          GeneralNotFoundWidget(
            title: LocaleKeys.merchantPanel_reviews_empty.tr(),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const PagePadding.generalAllLow(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _MerchantReviewCard(
                review: review,
                isSubmitting: state.replyingVoterUid == review.voterUid,
                onReply: () => unawaited(openReplySheet(review)),
                onRemoveReply: () => unawaited(confirmRemoveReply(review)),
              );
            },
          ),
      ],
    );
  }
}
