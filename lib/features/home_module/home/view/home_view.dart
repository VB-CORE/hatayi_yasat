import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_notification_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_provider.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/features/home_module/notifications/notificaitons_view.dart';
import 'package:vbaseproject/features/request/company/request_company_view.dart';
import 'package:vbaseproject/features/settings/settings_view.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/service/firebase_service.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
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

class _HomeViewState extends ConsumerState<HomeView>
    with AppProviderMixin, HomeViewMixin, HomeNotificationMixin {
  @override
  void initState() {
    super.initState();
    init(ref.read(_homeViewModel.notifier));
    listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const _RequestCompany(),
      appBar: AppBar(
        title: const Text(LocaleKeys.home_places).tr(),
        actions: const [
          _NotificationButton(),
          _SettingsButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchNewItemsWithRefresh(ref.read(_homeViewModel.notifier));
        },
        child: Column(
          children: [
            _SearchField(
              () {
                searchPressed(ref.read(_homeViewModel));
              },
            ),
            const Expanded(child: _PageBody()),
          ],
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.route.navigateToPage(const NotificationsView());
      },
      icon: const Icon(Icons.notifications_active_outlined),
    );
  }
}

class _SearchField extends ConsumerWidget {
  const _SearchField(this.onPressed);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(_homeViewModel).isEnabled;

    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: SearchFieldDisabled(
        hint: LocaleKeys.home_search.tr(),
        onTap: () async {
          onPressed.call();
        },
      ),
    ).ext.toDisabled(disable: !isEnabled);
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
      icon: const Icon(Icons.settings_outlined),
    );
  }
}

class _PageBody extends ConsumerWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(_homeViewModel).items;
    final isRequestSending = ref.watch(_homeViewModel).isServiceRequestSending;
    final crossFadeState =
        items.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedPageSwitch(
          firstChild: isRequestSending
              ? const PlaceShimmerList()
              : items.isEmpty
                  ? const _EmptyLottie()
                  : const SizedBox.shrink(),
          secondChild: SizedBox(
            height: constraints.maxHeight,
            child: ListView.builder(
              padding: const PagePadding.horizontalLowSymmetric() +
                  const PagePadding.onlyTop(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return PlaceCard(
                  item: items[index],
                  onTap: () {
                    context.route
                        .navigateToPage(HomeDetailView(model: items[index]));
                  },
                );
              },
            ),
          ),
          crossFadeState: crossFadeState,
        );
      },
    );
  }
}

class _EmptyLottie extends StatelessWidget {
  const _EmptyLottie();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.sized.height,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.sized.dynamicHeight(.2),
            ),
            child: Assets.lottie.notFound.lottie(),
          ),
        ),
      ),
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
