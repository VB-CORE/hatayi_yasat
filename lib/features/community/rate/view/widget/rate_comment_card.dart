part of '../rate_comment_list_view.dart';

final class _RateCommentCard extends StatelessWidget {
  const _RateCommentCard({
    required this.rateModel,
    this.onEdit,
    this.onDelete,
  });
  final VoteModel rateModel;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool get _hasActions => onEdit != null || onDelete != null;
  @override
  Widget build(BuildContext context) {
    final comment = rateModel.comment;
    final createdAt = rateModel.createdAt;
    return Container(
      padding: const PagePadding.generalCardAll(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomUserAvatar(
            userName: rateModel.userName,
            avatarType: rateModel.avatarType,
          ),
          const EmptyBox.middleWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GeneralBodyTitle(
                        rateModel.userName,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    if (_hasActions)
                      GestureDetector(
                        onTap: () => _showCommentOptions(context),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const PagePadding.generalIconLowAll(),
                          child: Icon(
                            AppIcons.moreDots,
                            color: context.general.colorScheme.onSurface,
                            size: AppIconSizes.medium,
                          ),
                        ),
                      ),
                  ],
                ),
                const EmptyBox.xSmallHeight(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRatingWidget(
                      itemSize: AppIconSizes.smallX,
                      value: rateModel.score.toDouble(),
                      isReadOnly: true,
                    ),
                    if (createdAt != null)
                      Flexible(
                        child: GeneralContentSmallTitle(
                          value: ' - ${createdAt.timeAgo}',
                        ),
                      ),
                  ],
                ),
                if (comment != null && comment.isNotEmpty)
                  Padding(
                    padding: const PagePadding.verticalVeryLowSymmetric(),
                    child: GeneralContentSubTitle(
                      value: comment,
                      maxLine: 6,
                    ),
                  ),
                if (rateModel.hasMerchantReply)
                  _RateMerchantReply(reply: rateModel.merchantReply!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCommentOptions(BuildContext context) async {
    final result = await RateSheetFactory.showCommentOptions(context);
    if (result == null) return;
    switch (result) {
      case RateCommentOptionAction.delete:
        onDelete?.call();
        return;
      case RateCommentOptionAction.edit:
        onEdit?.call();
        return;
    }
  }
}

final class _RateMerchantReply extends StatelessWidget {
  const _RateMerchantReply({required this.reply});

  final String reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const PagePadding.verticalVeryLowSymmetric(),
      padding: const PagePadding.generalCardAll(),
      decoration: BoxDecoration(
        color: context.appColors.ink200.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons.storeFilled,
                size: AppIconSizes.smallX,
                color: context.appColors.ink500,
              ),
              const EmptyBox.smallWidth(),
              GeneralContentSmallTitle(
                value: LocaleKeys.rate_merchantReplyTitle.tr(),
              ),
            ],
          ),
          const EmptyBox.xSmallHeight(),
          GeneralContentSubTitle(value: reply, maxLine: 6),
        ],
      ),
    );
  }
}
