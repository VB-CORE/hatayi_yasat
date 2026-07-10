import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_comment_options_sheet.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/product/package/image/custom_circle_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_circle_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';

final class RateCommentCard extends StatelessWidget {
  const RateCommentCard({
    required this.rateModel,
    super.key,
    this.onEdit,
    this.onDelete,
  });
  final RateModel rateModel;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool get _isOwnComment => onEdit != null || onDelete != null;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalCardAll(),
      margin: const PagePadding.verticalLowSymmetric(),
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
                value: rateModel.initials,
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
                    if (_isOwnComment)
                      GestureDetector(
                        onTap: () => _showCommentOptions(context),
                        child: const Icon(
                          AppIcons.moreDots,
                          color: AppColors.navy,
                          size: AppIconSizes.medium,
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
                Padding(
                  padding: const PagePadding.verticalVeryLowSymmetric(),
                  child: GeneralContentSubTitle(
                    value: rateModel.comment ?? '',
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
