part of '../widget/merchant_company_sheet.dart';

mixin MerchantCompanySheetMixin on ConsumerState<MerchantCompanySheet> {
  static const int _fetchLimit = 5;

  final TextEditingController searchController = TextEditingController();
  List<StoreModel> companies = [];
  bool isLoading = true;
  bool hasError = false;
  String _query = '';

  List<StoreModel> get visibleCompanies {
    if (_query.isEmpty) return companies;
    final lowerQuery = _query.toLowerCase();
    return companies
        .where((company) => company.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    unawaited(_fetchCompanies());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) => setState(() => _query = value);

  Future<void> _fetchCompanies() async {
    try {
      final query = ref
          .read(homeViewModelProvider.notifier)
          .fetchApprovedCollectionQuery();
      final snapshot = await query.limit(_fetchLimit).get();
      if (!mounted) return;
      setState(() {
        companies = snapshot.docs
            .map((doc) => doc.data())
            .whereType<StoreModel>()
            .toList();
        isLoading = false;
      });
    } on Exception catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }
}
