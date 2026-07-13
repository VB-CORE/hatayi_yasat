import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/mixin/start_discussion_sheet_mixin.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/widget/community_submit_button.dart';
import 'package:lifeclient/features/community/widget/required_label.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/product_textfield.dart';

final class StartDiscussionSheet extends ConsumerStatefulWidget {
  const StartDiscussionSheet({super.key});

  /// Kapatılırsa `null`, başlatılırsa oluşturulan model döner.
  static Future<GroupDiscussionModel?> show(BuildContext context) {
    return showModalBottomSheet<GroupDiscussionModel>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: CustomRadius.large.topLeft),
      ),
      builder: (context) => const StartDiscussionSheet(),
    );
  }

  @override
  ConsumerState<StartDiscussionSheet> createState() =>
      _StartDiscussionSheetState();
}

final class _StartDiscussionSheetState
    extends ConsumerState<StartDiscussionSheet>
    with StartDiscussionSheetMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontal16Symmetric(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SheetHeader(),
                const EmptyBox.middleHeight(),
                RequiredLabel(
                  LocaleKeys.community_groupDetail_discussions_titleFieldLabel
                      .tr(),
                ),
                const EmptyBox.smallHeight(),
                ProductTextField(
                  hintText: LocaleKeys
                      .community_groupDetail_discussions_titleFieldHint
                      .tr(),
                  controller: titleController,
                  maxLength: TextFieldMaxLengths.large,
                  validator: ValidatorNormalTextField().validate,
                ),
                const EmptyBox.middleHeight(),
                RequiredLabel(
                  LocaleKeys.community_groupDetail_discussions_messageFieldLabel
                      .tr(),
                ),
                const EmptyBox.smallHeight(),
                ProductTextField(
                  hintText: LocaleKeys
                      .community_groupDetail_discussions_messageFieldHint
                      .tr(),
                  controller: messageController,
                  maxLength: TextFieldMaxLengths.veryLarge,
                  isMultiline: true,
                  validator: ValidatorNormalTextField().validate,
                ),
                const EmptyBox.largeHeight(),
                CommunitySubmitButton(
                  onPressed: () async => submit(),
                  isEnabled: canSubmit,
                  label: LocaleKeys
                      .community_groupDetail_discussions_startButton
                      .tr(),
                ),
                const EmptyBox.middleHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SoftIconBox(icon: AppIcons.forum, iconColor: AppColors.coral),
        const EmptyBox(width: WidgetSizes.spacingS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentTitle(
              value: LocaleKeys.community_groupDetail_discussions_startTitle
                  .tr(),
              fontWeight: FontWeight.w700,
            ),
            GeneralContentSmallTitle(
              value: LocaleKeys.community_groupDetail_discussions_sheetSubtitle
                  .tr(),
              color: AppColors.navy300,
            ),
          ],
        ),
      ],
    );
  }
}
