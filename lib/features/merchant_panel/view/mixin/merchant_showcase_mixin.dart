import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_showcase_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_showcase_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/widget/merchant_module_form_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

mixin MerchantShowcaseMixin
    on
        ConsumerState<MerchantShowcaseSubView>,
        AppProviderMixin<MerchantShowcaseSubView> {
  MerchantShowcaseViewModel get viewModel =>
      ref.read(merchantShowcaseViewModelProvider(widget.storeId).notifier);

  Future<void> openModuleForm({MerchantShowcaseModuleModel? module}) async {
    final result = await MerchantModuleFormSheet.open(
      context,
      moduleId: module?.id ?? viewModel.createModuleId(),
      module: module,
    );
    if (result == null || !mounted) return;

    final (draft, file) = result;
    var saved = draft;
    if (file != null) {
      final url = await viewModel.uploadImage(file);
      if (url == null) {
        if (!mounted) return;
        _notify(isSuccess: false);
        return;
      }
      saved = draft.copyWith(imageUrl: url);
    }

    final isSuccess = await viewModel.upsert(saved);
    if (!mounted) return;
    _notify(isSuccess: isSuccess);
  }

  Future<void> confirmDelete(MerchantShowcaseModuleModel module) async {
    final isConfirmed = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.merchantPanel_showcase_deleteConfirmTitle.tr(),
      LocaleKeys.merchantPanel_showcase_deleteConfirmContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_iAmSure,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
    if (isConfirmed != true || !mounted) return;

    final isSuccess = await viewModel.remove(module.id);
    if (!mounted) return;
    _notify(isSuccess: isSuccess);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final isSuccess = await viewModel.reorder(oldIndex, newIndex);
    if (!mounted || isSuccess) return;
    _notify(isSuccess: false);
  }

  Future<void> toggleActive(MerchantShowcaseModuleModel module) async {
    final isSuccess = await viewModel.toggleActive(module);
    if (!mounted || isSuccess) return;
    _notify(isSuccess: false);
  }

  void _notify({required bool isSuccess}) {
    appProvider.showSnackbarMessage(
      isSuccess
          ? LocaleKeys.merchantPanel_showcase_saveSuccess.tr()
          : LocaleKeys.merchantPanel_showcase_saveError.tr(),
    );
  }
}
