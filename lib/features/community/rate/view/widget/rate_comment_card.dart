part of '../rate_comment_list_view.dart';

final class _RateCommentCard extends StatelessWidget {
  const _RateCommentCard({
    required this.rateModel,
    this.onEdit,
    this.onDelete,
  });
  final RateModel rateModel;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool get _hasActions => onEdit != null || onDelete != null;
  @override
  Widget build(BuildContext context) {
    final comment = rateModel.comment;
    return Container(
      padding: const PagePadding.generalCardAll(),
      decoration: const BoxDecoration(
        color: AppColors.surface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rateModel.photoUrl?.isNotEmpty ?? false)
            CustomCircleNetworkImage(
              imageUrl: rateModel.photoUrl,
              radius: CustomCircleRadius.medium,
            )
          else
            CircleAvatar(
              radius: CustomCircleRadius.medium,
              backgroundColor: AppColors.coral,
              child: GeneralContentSmallTitle(
                value: rateModel.userName.initials,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
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
                        child: const Padding(
                          padding: PagePadding.generalIconLowAll(),
                          child: Icon(
                            AppIcons.moreDots,
                            color: AppColors.navy,
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
                      value: rateModel.rate,
                      isReadOnly: true,
                    ),
                    Flexible(
                      child: GeneralContentSmallTitle(
                        value: ' - ${rateModel.createdAt.timeAgo}',
                      ),
                    ),
                  ],
                ),
                if (comment != null && comment.isNotEmpty)
                  Padding(
                    padding: const PagePadding.verticalVeryLowSymmetric(),
                    child: GeneralContentSubTitle(
                      value: comment,
                      maxLine: 5,
                    ),
                  ),
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
