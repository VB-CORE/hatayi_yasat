import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_view_model.dart';
import 'package:lifeclient/features/community/create_group/view/mixin/create_group_view_mixin.dart';
import 'package:lifeclient/features/community/create_group/view/widget/category_chip.dart';
import 'package:lifeclient/features/community/create_group/view/widget/cover_image_picker.dart';
import 'package:lifeclient/features/community/model/group_category_model.dart';
import 'package:lifeclient/features/community/widget/community_submit_button.dart';
import 'package:lifeclient/features/community/widget/required_label.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_field.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';

part 'sub_view/create_group_category_section.dart';
part 'sub_view/create_group_cover_section.dart';
part 'sub_view/create_group_description_section.dart';
part 'sub_view/create_group_name_section.dart';

final class CreateGroupView extends ConsumerStatefulWidget {
  const CreateGroupView({super.key});

  @override
  ConsumerState<CreateGroupView> createState() => _CreateGroupViewState();
}

final class _CreateGroupViewState extends ConsumerState<CreateGroupView>
    with AppProviderMixin<CreateGroupView>, CreateGroupViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createGroupViewModelProvider);
    return GeneralScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(AppIcons.close),
          onPressed: () => context.pop(),
        ),
        title: GeneralContentTitle(
          value: LocaleKeys.community_createGroup_title.tr(),
        ),
        actions: [
          Padding(
            padding: const PagePadding.onlyRight(),
            child: GeneralStatusBadge(
              label: LocaleKeys.community_createGroup_openBadge.tr(),
              color: AppColors.olive600,
              icon: AppIcons.globe,
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const EmptyBox.middleHeight(),
                  _CoverSection(
                    imageFile: coverImageFile,
                    onTap: pickCoverImage,
                  ),
                  const EmptyBox.middleHeight(),
                  _NameSection(controller: nameController),
                  const EmptyBox.middleHeight(),
                  _CategorySection(
                    categories: state.categories,
                    selectedCategory: selectedCategory,
                    onSelected: onCategorySelected,
                  ),
                  const EmptyBox.middleHeight(),
                  _DescriptionSection(controller: descriptionController),
                  const EmptyBox.middleHeight(),
                ],
              ),
            ),
            CommunitySubmitButton(
              onPressed: submit,
              label: LocaleKeys.community_createGroup_submitButton.tr(),
              icon: AppIcons.personAdd,
              isEnabled: isFormValid,
            ),
            const EmptyBox.largeHeight(),
          ],
        ),
      ),
    );
  }
}
