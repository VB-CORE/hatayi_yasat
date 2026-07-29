import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_store_edit_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/mixin/merchant_store_edit_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_photo.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/widget/open_and_close_time_picker.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';
import 'package:lifeclient/product/widget/text_field/labeled_product_textfield.dart';
import 'package:lifeclient/product/widget/text_field/phone_text_form_field.dart';

part 'widget/merchant_category_picker.dart';
part 'widget/merchant_photo_grid.dart';
part 'widget/merchant_section_title.dart';

final class MerchantStoreEditSubView extends ConsumerStatefulWidget {
  const MerchantStoreEditSubView({required this.store, super.key});

  final StoreModel store;

  @override
  ConsumerState<MerchantStoreEditSubView> createState() =>
      _MerchantStoreEditSubViewState();
}

final class _MerchantStoreEditSubViewState
    extends ConsumerState<MerchantStoreEditSubView>
    with AppProviderMixin<MerchantStoreEditSubView>, MerchantStoreEditMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      merchantStoreEditViewModelProvider(widget.store.documentId),
    );

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const PagePadding.generalAllLow(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _MerchantSectionTitle(
            icon: AppIcons.photoLibrary,
            title: LocaleKeys.merchantPanel_store_photosTitle.tr(),
            subtitle: LocaleKeys.merchantPanel_store_photosSubtitle.tr(),
          ),
          _MerchantPhotoGrid(
            photos: state.photos,
            onAdd: pickPhoto,
            onReplace: (index) => pickPhoto(replaceIndex: index),
            onRemove: viewModel.removePhotoAt,
          ),
          const EmptyBox.middleHeight(),
          _MerchantSectionTitle(
            icon: AppIcons.infoFilled,
            title: LocaleKeys.merchantPanel_store_basicTitle.tr(),
          ),
          LabeledProductTextField(
            labelText: LocaleKeys.merchantPanel_store_nameLabel.tr(),
            controller: nameController,
            validator: ValidatorNormalTextField().validate,
          ),
          const EmptyBox.smallHeight(),
          Text(
            LocaleKeys.merchantPanel_store_categoryLabel.tr(),
            style: AppText.label,
          ),
          const EmptyBox.xSmallHeight(),
          _MerchantCategoryPicker(
            selected: state.category,
            categories: productState.categoryItems,
            onSelected: viewModel.selectCategory,
          ),
          const EmptyBox.smallHeight(),
          Text(
            LocaleKeys.merchantPanel_store_descriptionLabel.tr(),
            style: AppText.label,
          ),
          const EmptyBox.xSmallHeight(),
          CustomTextFormMultiField(
            hint: LocaleKeys.merchantPanel_store_descriptionHint.tr(),
            controller: descriptionController,
            maxLength: TextFieldMaxLengths.max,
            validator: ValidatorNormalTextField(),
          ),
          const EmptyBox.middleHeight(),
          _MerchantSectionTitle(
            icon: AppIcons.phone,
            title: LocaleKeys.merchantPanel_store_phoneLabel.tr(),
          ),
          PhoneTextFormField(controller: phoneController),
          LabeledProductTextField(
            labelText: LocaleKeys.merchantPanel_store_addressLabel.tr(),
            controller: addressController,
            isMultiline: true,
            validator: ValidatorNormalTextField().validate,
          ),
          const EmptyBox.middleHeight(),
          _MerchantSectionTitle(
            icon: AppIcons.timerOn,
            title: LocaleKeys.merchantPanel_store_hoursTitle.tr(),
          ),
          OpenAndCloseTimePicker(
            openTimeController: openTimeController,
            closeTimeController: closeTimeController,
          ),
          SwitchListTile.adaptive(
            value: state.isCommentEnabled,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) => viewModel.setCommentEnabled(value: value),
            title: Text(
              LocaleKeys.merchantPanel_store_commentEnabledLabel.tr(),
              style: AppText.bodyLg,
            ),
            subtitle: Text(
              LocaleKeys.merchantPanel_store_commentEnabledSubtitle.tr(),
              style: AppText.caption,
            ),
          ),
          const EmptyBox.middleHeight(),
          GeneralButtonV2.async(
            action: save,
            isEnabled: !state.isSaving,
            label: LocaleKeys.merchantPanel_store_saveAction.tr(),
          ),
          const EmptyBox.largeHeight(),
        ],
      ),
    );
  }
}
