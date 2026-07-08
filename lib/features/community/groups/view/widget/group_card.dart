import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupCard extends StatelessWidget {
  const GroupCard({
    required this.model,
    required this.onTap,
    super.key,
  });

  final GroupModel model;
  final VoidCallback onTap;

  static const double _cardHeightFactor = 0.155;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(_cardHeightFactor),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              _CoverImage(model: model),
              Expanded(
                child: Padding(
                  padding: const PagePadding.generalCardAll(),
                  child: _GroupInfo(model: model),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.model});

  final GroupModel model;

  static const double _coverWidthFactor = 0.28;

  // TODO(community): Gerçek kapak görselleri backend'den gelince
  // gradient fallback yalnızca görselsiz gruplarda görünecek.
  static const List<List<Color>> _fallbackGradients = [
    [AppColors.coral300, AppColors.coral700],
    [AppColors.teal300, AppColors.navy500],
    [AppColors.olive300, AppColors.olive700],
    [AppColors.navy300, AppColors.teal600],
  ];

  @override
  Widget build(BuildContext context) {
    final imageUrl = model.coverImageUrl;
    return SizedBox(
      width: context.sized.dynamicWidth(_coverWidthFactor),
      height: double.infinity,
      child: imageUrl == null
          ? DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      _fallbackGradients[model.id.hashCode.abs() %
                          _fallbackGradients.length],
                ),
              ),
            )
          : CustomNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
    );
  }
}

final class _GroupInfo extends StatelessWidget {
  const _GroupInfo({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentSubTitle(
          value: model.name,
          fontWeight: FontWeight.bold,
          maxLine: AppConstants.kOne,
        ),
        const EmptyBox.xSmallHeight(),
        GeneralContentSmallTitle(
          value: model.description,
          color: AppColors.navy300,
          maxLine: AppConstants.kOne,
        ),
        const EmptyBox.smallHeight(),
        _GroupMetaRow(model: model),
      ],
    );
  }
}

final class _GroupMetaRow extends StatelessWidget {
  const _GroupMetaRow({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WidgetSizes.spacingXs,
      runSpacing: WidgetSizes.spacingXxs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          AppIcons.group,
          size: AppIconSizes.xMedium,
          color: AppColors.navy300,
        ),
        GeneralContentSmallTitle(
          value: model.memberCount.toString(),
          color: AppColors.navy300,
        ),
        GeneralStatusBadge(
          label: model.type == GroupType.open
              ? LocaleKeys.community_groups_openGroup.tr()
              : LocaleKeys.community_groups_closedGroup.tr(),
          color: AppColors.olive600,
          icon: AppIcons.globe,
        ),
        if (model.isCurrentUserAdmin)
          GeneralStatusBadge(
            label: LocaleKeys.community_groups_adminBadge.tr(),
            color: AppColors.coral500,
          ),
      ],
    );
  }
}
