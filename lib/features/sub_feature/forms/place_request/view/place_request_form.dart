import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/provider/place_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/mixin/place_request_form_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/index.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_formatters.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/general/dotted/index.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_view/list_view_with_space.dart';
import 'package:lifeclient/product/widget/text_field/custom_category_field.dart';
import 'package:lifeclient/product/widget/text_field/custom_district_field.dart';
import 'package:lifeclient/product/widget/text_field/index.dart';

part 'widget/place_request_send.dart';

final class PlaceRequestForm extends ConsumerStatefulWidget {
  const PlaceRequestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceRequestFormState();
}

class _PlaceRequestFormState extends RequestFormConsumerState<PlaceRequestForm>
    with AppProviderMixin, PlaceRequestFormMixin {
  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(LocaleKeys.requestCompany_title.tr()),
      ),
      bottomNavigationBar: _PlaceRequestSend(
        onTapped: () async {
          if (!validateAndSave()) return;
          final model = requestModel();
          if (model == null) return;
          final response = await ref
              .read(placeRequestProviderProvider.notifier)
              .addNewDataToService(model);
          await dataSendingComplete(isOkay: response);
        },
        onKVKKChanged: updateKVKK,
      ).ext.toDisabled(
            disable: ref.watch(placeRequestProviderProvider).isSendingRequest ??
                false,
            opacity: 0.5,
          ),
      body: ListViewWithSpace(
        children: [
          GeneralDottedPhotoAdd(onSelected: onImageSelected),
          CustomTextFormField(
            maxLength: TextFieldMaxLengths.small,
            hint: LocaleKeys.requestCompany_name.tr(),
            controller: placeNameController,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormMultiField(
            hint: LocaleKeys.requestCompany_description.tr(),
            controller: placeDescriptionController,
            textInputType: TextInputType.multiline,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormField(
            maxLength: TextFieldMaxLengths.small,
            hint: LocaleKeys.requestCompany_ownerName.tr(),
            controller: placeOwnerNameController,
            textInputType: TextInputType.name,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormMultiField(
            hint: LocaleKeys.requestCompany_address.tr(),
            controller: placeAddressController,
            textInputType: TextInputType.streetAddress,
            autoFills: TextFieldAutoFills.address,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormField(
            hint: LocaleKeys.requestCompany_phoneNumber.tr(),
            controller: placePhoneNumberController,
            textInputType: TextInputType.phone,
            formatters: TextFieldFormatters.phone,
            validator: ValidatorPhoneTextField(),
          ),
          CustomCategorySelectionFormField(
            items: categoryModels,
            hint: LocaleKeys.requestCompany_chooseCategory.tr(),
            controller: placeCategoryController,
            onSelected: updateCategoryItem,
            validator: TextFieldValidatorIsNullEmpty(),
          ),
          CustomDistrictSelectionFormField(
            hint: LocaleKeys.requestCompany_chooseDistrict.tr(),
            controller: placeDistrictController,
            onSelected: updateTownItem,
            validator: TextFieldValidatorIsNullEmpty(),
            items: townModels,
          ),
        ],
      ).ext.toDisabled(
            disable: ref.watch(placeRequestProviderProvider).isSendingRequest ??
                false,
            opacity: 0.5,
          ),
    );
  }
}
