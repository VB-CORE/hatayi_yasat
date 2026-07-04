import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/rate_model.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/widget/rating/app_rating_widget.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({required this.rateModel, super.key});
  final RateModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalCardAll(),
      decoration: const BoxDecoration(
        color: ColorsCustom.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorsCustom.endless,
            child: Text(
              'RT',
              style: context.general.textTheme.titleSmall?.copyWith(
                color: ColorsCustom.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const EmptyBox.middleWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Eylem Akdeniz',
                  style: context.general.textTheme.labelLarge,
                ),
                const EmptyBox.smallHeight(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRatingWidget(
                      itemSize: 12,
                      value: 4,
                      isReadOnly: true,
                      onRatingUpdate: (value) {},
                    ),
                    Text(
                      ' - 3 gün önce',
                      style: context.general.textTheme.labelSmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const PagePadding.verticalVeryLowSymmetric(),
                  child: Text(
                    rateModel.comment ?? '',
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: context.general.textTheme.labelMedium?.copyWith(),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '491 likes',
                      style: context.general.textTheme.labelMedium,
                    ),
                    const EmptyBox.smallWidth(),
                    Text(
                      'Reply',
                      style: context.general.textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
