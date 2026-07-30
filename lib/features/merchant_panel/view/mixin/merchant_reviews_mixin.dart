import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/widget/merchant_reply_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin MerchantReviewsMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, AppProviderMixin<T> {
  String get storeId;

  Query<RateModel?> reviewsQuery(MerchantReviewFilter filter) {
    final collection = ProjectDependencyItems.firestoreService
        .collectionReference(
          CollectionPaths.approvedApplications.sub(
            storeId,
            SubCollectionPaths.votes,
          ),
          const RateModel(),
        );

    return switch (filter) {
      MerchantReviewFilter.all => collection.orderBy(
        FirestoreFields.createdAt.name,
        descending: true,
      ),
      MerchantReviewFilter.pending =>
        collection
            .where(RateModel.merchantReplyField, isNull: true)
            .orderBy(FirestoreFields.createdAt.name, descending: true),
      MerchantReviewFilter.answered =>
        collection
            .where(RateModel.merchantReplyField, isGreaterThan: '')
            .orderBy(RateModel.merchantReplyField)
            .orderBy(FirestoreFields.createdAt.name, descending: true),
    };
  }

  Future<void> openReplySheet(RateModel review) async {
    final message = await MerchantReplySheet.open(context, review: review);
    if (message == null || !mounted) return;

    final isSuccess = await ref
        .read(merchantReviewsViewModelProvider(storeId).notifier)
        .reply(review: review, message: message);
    if (!mounted) return;

    appProvider.showSnackbarMessage(
      isSuccess
          ? LocaleKeys.merchantPanel_reviews_replySuccess.tr()
          : LocaleKeys.merchantPanel_reviews_replyError.tr(),
    );
  }

  Future<void> confirmRemoveReply(RateModel review) async {
    final isConfirmed = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.merchantPanel_reviews_removeReplyConfirmTitle.tr(),
      LocaleKeys.merchantPanel_reviews_removeReplyConfirmContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_iAmSure,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
    if (isConfirmed != true || !mounted) return;

    final isSuccess = await ref
        .read(merchantReviewsViewModelProvider(storeId).notifier)
        .removeReply(review);
    if (!mounted) return;

    appProvider.showSnackbarMessage(
      isSuccess
          ? LocaleKeys.merchantPanel_reviews_removeReplySuccess.tr()
          : LocaleKeys.merchantPanel_reviews_replyError.tr(),
    );
  }
}
