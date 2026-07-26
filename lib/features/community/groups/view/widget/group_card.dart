import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/widget/group_cover_image.dart';
import 'package:lifeclient/features/community/widget/group_type_presentation.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupCard extends StatelessWidget {
  const GroupCard({required this.model, required this.onTap, super.key});

  final GroupModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.155),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.dynamicWidth(0.28),
      height: double.infinity,
      child: GroupCoverImage(groupId: model.id, imageUrl: model.imageUrl),
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
          color: context.appColors.navy300,
          maxLine: AppConstants.kOne,
        ),
        const EmptyBox.smallHeight(),
        _GroupMetaRow(model: model),
      ],
    );
  }
}

final class _GroupMetaRow extends ConsumerWidget {
  const _GroupMetaRow({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUid = ref.watch(
      authViewModelProvider.select((state) => state.user?.uid),
    );
    return Wrap(
      spacing: WidgetSizes.spacingXs,
      runSpacing: WidgetSizes.spacingXxs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          AppIcons.group,
          size: AppIconSizes.xMedium,
          color: context.appColors.navy300,
        ),
        GeneralContentSmallTitle(
          value: model.memberCount.toString(),
          color: context.appColors.navy300,
        ),
        GeneralStatusBadge(
          label: model.type.label,
          color: model.type.badgeColor(context),
          icon: model.type.icon,
        ),
        if (model.categoryName.isNotEmpty)
          GeneralStatusBadge(
            label: model.categoryName,
            color: context.appColors.navy400,
          ),
        if (model.isCreatedBy(currentUid))
          GeneralStatusBadge(
            label: LocaleKeys.community_groups_adminBadge.tr(),
            color: context.general.colorScheme.tertiary,
          ),
      ],
    );
  }
}
