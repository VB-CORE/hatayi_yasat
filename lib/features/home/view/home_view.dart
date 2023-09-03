import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home/view/search/home_search_delegate.dart';
import 'package:vbaseproject/features/home/view_model/home_provider.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/features/settings/settings_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/animated/animated_page_change.dart';
import 'package:vbaseproject/product/widget/card/place_card.dart';
import 'package:vbaseproject/product/widget/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/widget/text_field/search_field_disabled.dart';

final StateNotifierProvider<HomeViewModel, HomeState> _homeViewModel =
    StateNotifierProvider(
  (ref) => HomeViewModel(
    productProvider: ref.read(ProductProvider.provider.notifier),
    customService: FirebaseService(),
  ),
);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_homeViewModel.notifier).fetchAllItemsAndSave();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const _RequestCompany(),
      appBar: AppBar(
        title: const Text(LocaleKeys.home_places).tr(),
        actions: const [
          _SettingsButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: Column(
          children: [
            Padding(
              padding: const PagePadding.horizontalLowSymmetric(),
              child: SearchFieldDisabled(
                hint: LocaleKeys.home_search.tr(),
                onTap: () async {
                  final items = ref.read(_homeViewModel).items;
                  final response = await showSearch<StoreModel>(
                    context: context,
                    delegate: HomeSearchDelegate(items: items),
                  );
                },
              ),
            ),
            const Expanded(child: _PageBody()),
          ],
        ),
      ),
    );
  }

  Future<void> _pullToRefresh() async {
    await ref.read(_homeViewModel.notifier).fetchAllItemsAndSave();
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.route.navigateToPage(const SettingsView());
      },
      icon: const Icon(Icons.settings),
    );
  }
}

class _PageBody extends ConsumerWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(_homeViewModel).items;
    final crossFadeState =
        items.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedPageSwitch(
          firstChild: const PlaceShimmerList(),
          secondChild: SizedBox(
            height: constraints.maxHeight,
            child: ListView.builder(
              padding: const PagePadding.horizontalLowSymmetric() +
                  const PagePadding.onlyTop(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return PlaceCard(item: items[index]);
              },
            ),
          ),
          crossFadeState: crossFadeState,
        );
      },
    );
  }
}

class _RequestCompany extends ConsumerWidget {
  const _RequestCompany();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(_homeViewModel).isServiceRequestSending;
    return FloatingActionButton(
      onPressed: isLoading
          ? null
          : () {
              context.route.navigateToPage(const RequestCompanyView());
            },
      child: const Icon(Icons.add),
    );
  }
}
