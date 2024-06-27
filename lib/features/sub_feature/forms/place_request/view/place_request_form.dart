import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/provider/place_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/mixin/place_request_form_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/widget/open_and_close_time_picker.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_auto_fills.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_formatters.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/general/dotted/index.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_provider.dart';
import 'package:lifeclient/product/widget/general/dropdown/custom_dropdown_form_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/list_view/list_view_with_space.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_field.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';

part 'widget/custom_text_form_field_with_title.dart';
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
        title: GeneralSubTitle(
          value: LocaleKeys.requestCompany_title.tr(),
        ),
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
        onKVKKChanged: (val) => updateKVKK(value: val),
      ).ext.toDisabled(
            disable: ref.watch(placeRequestProviderProvider).isSendingRequest ??
                false,
            opacity: 0.5,
          ),
      body: ListViewWithSpace(
        children: [
          CustomTextFormFieldWithTitle(
            title: LocaleKeys.requestCompany_ownerName.tr(),
            controller: placeOwnerNameController,
            textInputType: TextInputType.name,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle(
            controller: placePhoneNumberController,
            textInputType: TextInputType.phone,
            formatters: TextFieldFormatters.phone,
            validator: ValidatorPhoneTextField(),
            title: LocaleKeys.requestCompany_phoneNumber.tr(),
          ),
          GeneralDottedPhotoAddProvider(
            onSelected: onImageSelected,
            child: const GeneralDottedPhotoAdd(),
          ),
          CustomTextFormFieldWithTitle(
            maxLength: TextFieldMaxLengths.large,
            title: LocaleKeys.requestCompany_name.tr(),
            controller: placeNameController,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle.multiLine(
            title: LocaleKeys.requestCompany_description.tr(),
            controller: placeDescriptionController,
            textInputType: TextInputType.multiline,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle.multiLine(
            title: LocaleKeys.requestCompany_address.tr(),
            controller: placeAddressController,
            textInputType: TextInputType.streetAddress,
            autoFills: TextFieldAutoFills.address,
            validator: ValidatorNormalTextField(),
          ),
          CustomDropdownFormField<TownModel>(
            hint: LocaleKeys.requestCompany_chooseDistrict.tr(),
            onSelected: updateTownItem,
            items: townModels,
          ),
          CustomDropdownFormField<CategoryModel>(
            hint: LocaleKeys.requestCompany_chooseCategory.tr(),
            onSelected: updateCategoryItem,
            items: categoryModels,
          ),
          OpenAndCloseTimePicker(
            closeTimeController: closeTimeController,
            openTimeController: openTimeController,
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
