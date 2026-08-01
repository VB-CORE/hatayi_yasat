part of '../merchant_reviews_sub_view.dart';

final class _MerchantReviewCard extends StatelessWidget {
  const _MerchantReviewCard({
    required this.review,
    required this.isSubmitting,
    required this.onReply,
    required this.onRemoveReply,
  });

  final VoteModel review;
  final bool isSubmitting;
  final VoidCallback onReply;
  final VoidCallback onRemoveReply;

  @override
  Widget build(BuildContext context) {
    final name = review.userName.trim().isEmpty
        ? LocaleKeys.merchantPanel_reviews_anonymous.tr()
        : review.userName;

    return Padding(
      padding: const PagePadding.verticalLowSymmetric(),
      child: Container(
        padding: const PagePadding.generalAllLow(),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.appColors.ink200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xs,
          children: [
            Row(
              spacing: AppSpacing.xs,
              children: [
                CustomUserAvatar(
                  userName: name,
                  avatarType: review.avatarType,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: AppConstants.kOne,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.bodyLg,
                      ),
                      Row(
                        spacing: AppSpacing.xxs,
                        children: [
                          for (var index = 0; index < 5; index++)
                            Icon(
                              AppIcons.star,
                              size: AppIconSizes.smallX,
                              color: index < review.score
                                  ? context.appColors.gold
                                  : context.appColors.ink200,
                            ),
                          Flexible(
                            child: Text(
                              review.createdAt.timeAgoOrNow,
                              maxLines: AppConstants.kOne,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.micro,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!review.hasMerchantReply)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.coral50,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      LocaleKeys.merchantPanel_reviews_pendingBadge.tr(),
                      style: AppText.micro.copyWith(
                        color: context.appColors.coral600,
                      ),
                    ),
                  ),
              ],
            ),
            Text(review.comment ?? '', style: AppText.body),
            if (review.hasMerchantReply)
              Container(
                width: double.infinity,
                padding: const PagePadding.allLow(),
                decoration: BoxDecoration(
                  color: context.appColors.ink25,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.merchantPanel_reviews_replyPrefix.tr(),
                      style: AppText.micro,
                    ),
                    Text(review.merchantReply ?? '', style: AppText.bodySm),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (review.hasMerchantReply)
                  TextButton.icon(
                    onPressed: isSubmitting ? null : onRemoveReply,
                    style: TextButton.styleFrom(
                      foregroundColor: context.appColors.coral600,
                    ),
                    icon: const Icon(
                      AppIcons.delete,
                      size: AppIconSizes.medium,
                    ),
                    label: Text(
                      LocaleKeys.merchantPanel_reviews_removeReplyAction.tr(),
                    ),
                  ),
                TextButton.icon(
                  onPressed: isSubmitting ? null : onReply,
                  icon: const Icon(AppIcons.reply, size: AppIconSizes.medium),
                  label: Text(
                    review.hasMerchantReply
                        ? LocaleKeys.merchantPanel_reviews_editReplyAction.tr()
                        : LocaleKeys.merchantPanel_reviews_replyAction.tr(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
