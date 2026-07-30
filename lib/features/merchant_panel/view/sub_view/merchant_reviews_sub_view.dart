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
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/mixin/merchant_reviews_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';
import 'package:lifeclient/product/widget/list_view/firestore_sliver_list_view.dart';

part 'widget/merchant_review_card.dart';

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
    final state = ref.watch(
      merchantReviewsViewModelProvider(widget.storeId).select(
        (state) =>
            (filter: state.filter, replyingVoterUid: state.replyingVoterUid),
      ),
    );

    return CustomFireStoreListView<RateModel>(
      query: reviewsQuery(state.filter),
      padding: const PagePadding.generalAllLow(),
      separator: const EmptyBox.smallHeight(),
      itemBuilder: (context, review) => _MerchantReviewCard(
        review: review,
        isSubmitting: state.replyingVoterUid == review.voterUid,
        onReply: () => unawaited(openReplySheet(review)),
        onRemoveReply: () => unawaited(confirmRemoveReply(review)),
      ),
    );
  }
}
