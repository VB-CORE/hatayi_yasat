import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/features/community/rate/provider/mock_user_provider.dart';
import 'package:lifeclient/features/community/rate/view/widget/comment_option_sheet.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';

class CommentCard extends ConsumerWidget {
  const CommentCard({
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(mockUserProvider(rateModel.userId));
    return Container(
      padding: const PagePadding.generalCardAll(),
      margin: const PagePadding.verticalLowSymmetric(),
      decoration: const BoxDecoration(
        color: ColorsCustom.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorsCustom.endless,
            backgroundImage: user.photoUrl != null
                ? NetworkImage(user.photoUrl!)
                : null,
            child: user.photoUrl == null
                ? GeneralContentSmallTitle(
                    value: user.initials,
                    color: ColorsCustom.white,
                    fontWeight: FontWeight.w600,
                  )
                : null,
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
                    GeneralBodyTitle(user.name),

                    if (_isOwnComment)
                      GestureDetector(
                        onTap: () => _showCommentOptions(context),
                        child: Icon(
                          AppIcons.moreDots,
                          color: context.general.colorScheme.primary,
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
                    GeneralContentSmallTitle(
                      value: ' - ${rateModel.createdAt.timeAgo}',
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
    final result = await CommentOptionsSheet.show(context);
    if (result == null) return;
    switch (result) {
      case CommentOptionAction.delete:
        onDelete?.call();
      case CommentOptionAction.edit:
        onEdit?.call();
    }
  }
}
