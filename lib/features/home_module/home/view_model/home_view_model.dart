import 'package:life_shared/life_shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_state.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_view_model_mixin.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/sheet/operation/town_category_operation.dart';

class HomeViewModel extends StateNotifier<HomeState> with HomeViewModelMixin {
  HomeViewModel({
    required ProductProvider productProvider,
    required CustomService customService,
  })  : _productProvider = productProvider,
        _customService = customService,
        super(
          const HomeState(isServiceRequestSending: true),
        );

  final ProductProvider _productProvider;
  final CustomService _customService;

  List<StoreModel> _allItems = [];
  Future<void> fetchAllItemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);
    final items = await _customService.getList<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
    );

    _productProvider.saveStores(items);
    state = state.copyWith(
      isServiceRequestSending: false,
      items: items,
    );
    _allItems = items;
  }

  void filter(TownCategoryModel? value) {
    if (value == null) return;
    final filteredItems = filterWithResult(value, _allItems);
    state = state.copyWith(items: filteredItems, townCategoryModel: value);
  }
}
