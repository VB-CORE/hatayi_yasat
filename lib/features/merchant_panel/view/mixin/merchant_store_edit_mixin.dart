import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_store_edit_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_store_edit_sub_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/controller/time_picker_controller.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/sheet/general_media_sheet.dart';

mixin MerchantStoreEditMixin
    on
        ConsumerState<MerchantStoreEditSubView>,
        AppProviderMixin<MerchantStoreEditSubView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final openTimeController = TimePickerController();
  final closeTimeController = TimePickerController();
  final formKey = GlobalKey<FormState>();

  MerchantStoreEditViewModel get viewModel => ref.read(
    merchantStoreEditViewModelProvider(widget.store.documentId).notifier,
  );

  @override
  void initState() {
    super.initState();
    nameController.text = widget.store.name;
    descriptionController.text = widget.store.description ?? '';
    phoneController.text = widget.store.phone;
    addressController.text = widget.store.address ?? '';
    openTimeController.text = widget.store.openTime ?? '';
    closeTimeController.text = widget.store.closeTime ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    addressController.dispose();
    openTimeController.dispose();
    closeTimeController.dispose();
    super.dispose();
  }

  Future<void> pickPhoto({int? replaceIndex}) async {
    final file = await GeneralMediaSheet.open(context);
    if (!mounted || file == null) return;
    if (!viewModel.isFileSizeValid(file)) {
      appProvider.showSnackbarMessage(
        LocaleKeys.requestScholarship_error_fileSizeError.tr(),
      );
      return;
    }
    if (replaceIndex == null) {
      viewModel.addPhoto(file);
    } else {
      viewModel.replacePhoto(replaceIndex, file);
    }
  }

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final state = ref.read(
      merchantStoreEditViewModelProvider(widget.store.documentId),
    );
    if (state.photos.isEmpty) {
      appProvider.showSnackbarMessage(
        LocaleKeys.merchantPanel_store_photoRequired.tr(),
      );
      return;
    }
    if (state.category == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.merchantPanel_store_categoryRequired.tr(),
      );
      return;
    }

    viewModel.setWorkingHours(
      openTime: _timeValueOf(openTimeController),
      closeTime: _timeValueOf(closeTimeController),
    );

    final isSuccess = await viewModel.save(
      name: nameController.text,
      description: descriptionController.text,
      phone: phoneController.text,
      address: addressController.text,
    );
    if (!mounted) return;

    appProvider.showSnackbarMessage(
      isSuccess
          ? LocaleKeys.merchantPanel_store_saveSuccess.tr()
          : LocaleKeys.merchantPanel_store_saveError.tr(),
    );
  }

  String? _timeValueOf(TimePickerController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : text;
  }
}
