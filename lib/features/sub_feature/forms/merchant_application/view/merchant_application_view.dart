import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/sub_feature/forms/index.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_state.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_view_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/view/widget/merchant_step_indicator.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/widget/open_and_close_time_picker.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/features/sub_feature/map_picker/map_place_picker.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_formatters.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/package/file_picker/upload_file_section_v2.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';
import 'package:lifeclient/product/utility/decorations/box_decorations.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/general/dropdown/custom_dropdown_form_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/list_view/list_view_with_space.dart';
import 'package:lifeclient/product/widget/sheet/general_media_sheet.dart';

part 'mixin/merchant_application_view_mixin.dart';
part 'mixin/merchant_company_step_mixin.dart';
part 'mixin/merchant_owner_step_mixin.dart';
part 'sub_view/merchant_company_step.dart';
part 'sub_view/merchant_owner_step.dart';
part 'sub_view/place_location_picker.dart';

final class MerchantApplicationView extends ConsumerStatefulWidget {
  const MerchantApplicationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantApplicationViewState();
}

final class _MerchantApplicationViewState
    extends ConsumerState<MerchantApplicationView>
    with
        AppProviderMixin<MerchantApplicationView>,
        MerchantApplicationViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantApplicationViewModelProvider);
    ref.listen(
      merchantApplicationViewModelProvider.select((value) => value.currentStep),
      onStepChanged,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MerchantStepIndicator(
              currentStep: state.currentStep,
              stepCount: MerchantApplicationState.stepCount,
              title: _stepTitle(state.currentStep),
              onClose: onClosePressed,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _MerchantCompanyStep(key: companyStepKey),
                  _MerchantOwnerStep(key: ownerStepKey),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const PagePadding.defaultPadding(),
          child: IntrinsicHeight(
            child: Row(
              children: [
                if (!state.isFirstStep) ...[
                  Expanded(
                    child: GeneralButtonV2.active(
                      label: LocaleKeys.merchantApplication_back.tr(),
                      isBorderless: true,
                      action: onBackPressed,
                    ),
                  ),
                  const SizedBox(width: WidgetSizes.spacingM),
                ],
                Expanded(
                  flex: 2,
                  child: GeneralButtonV2.active(
                    label: state.isLastStep
                        ? LocaleKeys.merchantApplication_submit.tr()
                        : LocaleKeys.merchantApplication_next.tr(),
                    action: onNextPressed,
                  ),
                ),
              ],
            ),
          ).ext.toDisabled(disable: state.isSubmitting, opacity: 0.5),
        ),
      ),
    );
  }

  String _stepTitle(int step) => switch (step) {
    0 => LocaleKeys.merchantApplication_steps_company,
    _ => LocaleKeys.merchantApplication_steps_owner,
  }.tr();
}
