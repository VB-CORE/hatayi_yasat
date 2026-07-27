part of '../widget/merchant_company_sheet.dart';

mixin MerchantCompanySheetMixin on ConsumerState<MerchantCompanySheet> {
  static const Duration _debounce = Duration(milliseconds: 300);

  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      _debounce,
      () => ref
          .read(merchantCompanySheetViewModelProvider.notifier)
          .search(value),
    );
  }

  Future<void> onCompanySelected(String id) async {
    final company = await ref
        .read(merchantCompanySheetViewModelProvider.notifier)
        .selectCompany(id);
    if (!mounted || company == null) return;
    Navigator.pop(context, company);
  }
}
