import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_notification_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_provider.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/card/place_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/utility/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/widget/text_field/search_field_disabled.dart';
import 'package:vbaseproject/sub_feature/filter_button/filter_button.dart';

final StateNotifierProvider<HomeViewModel, HomeState> _homeViewModel =
    StateNotifierProvider(
  (ref) => HomeViewModel(
    productProvider: ref.read(ProductProvider.provider.notifier),
    customService: FirebaseCustomService(),
  ),
);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with
        AppProviderMixin,
        AutomaticKeepAliveClientMixin,
        HomeViewMixin,
        HomeNotificationMixin {
  @override
  void initState() {
    super.initState();
    init(ref.read(_homeViewModel.notifier));
    listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchNewItemsWithRefresh(ref.read(_homeViewModel.notifier));
        },
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              _SearchField(() {
                searchPressed(ref.read(_homeViewModel));
              }),
              SliverToBoxAdapter(
                child: _FilterButton(),
              ),
              const _PageBody(),
              SizedBox(height: context.sized.dynamicHeight(0.2)).ext.sliver,
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRequestSending = ref.watch(_homeViewModel).isServiceRequestSending;

    if (isRequestSending) return const SizedBox.shrink();
    final isAvailableItem = ref.watch(_homeViewModel).items.isEmpty;

    if (isAvailableItem) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerRight,
      child: FilterButton(
        onSelected: (value) {
          ref.read(_homeViewModel.notifier).filter(value);
        },
      ),
    );
  }
}

class _SearchField extends ConsumerWidget {
  const _SearchField(this.onPressed);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(_homeViewModel).isEnabled;
    if (!isEnabled) return const SizedBox.shrink().ext.sliver;
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: SearchFieldDisabled(
        hint: LocaleKeys.home_search.tr(),
        onTap: () async {
          onPressed.call();
        },
      ),
    ).ext.sliver;
  }
}

class _PageBody extends ConsumerWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(_homeViewModel).items;
    final isRequestSending = ref.watch(_homeViewModel).isServiceRequestSending;

    if (isRequestSending) {
      return const SliverFillRemaining(
        child: Padding(
          padding: PagePadding.onlyTop(),
          child: PlaceShimmerList(),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverList.list(
        key: UniqueKey(),
        children: const [
          NotFoundLottie(),
        ],
      );
    }

    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PlaceCard(
            item: items[index],
            onTap: () {
              context.route.navigateToPage(HomeDetailView(model: items[index]));
            },
          );
        },
      ),
    );
  }
}
