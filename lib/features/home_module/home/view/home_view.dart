import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_notification_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_state.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_view_model.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/index.dart';
import 'package:vbaseproject/product/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/mixin/notification_type_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/card/place_card.dart';
import 'package:vbaseproject/product/widget/dialog/index.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/widget/sheet/town_category_sheet.dart';
import 'package:vbaseproject/product/widget/text_field/search_field_disabled.dart';

final NotifierProvider<HomeViewModel, HomeState> _homeViewModel =
    NotifierProvider<HomeViewModel, HomeState>(
  HomeViewModel.new,
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
        NotificationTypeMixin,
        HomeNotificationMixin {
  @override
  void initState() {
    super.initState();
    ref.read(_homeViewModel.notifier).init();
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
          controller: customScrollController,
          child: CustomScrollView(
            controller: customScrollController,
            slivers: [
              _SearchField(() {
                searchPressed(ref.read(_homeViewModel));
              }),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const _RepublicDayButton(),
                    Expanded(child: _FilterButton()),
                  ],
                ),
              ),
              _PageBody(
                onRefresh: () async =>
                    fetchNewItemsWithRefresh(ref.read(_homeViewModel.notifier)),
              ),
              SizedBox(height: context.sized.dynamicHeight(0.2)).ext.sliver,
            ],
          ),
        ),
      ),
    );
  }
}

class _RepublicDayButton extends StatelessWidget {
  const _RepublicDayButton();

  @override
  Widget build(BuildContext context) {
    if (!FirebaseRemoteEnums.specialDay.valueBool) {
      return const SizedBox.shrink();
    }
    return ElevatedButton.icon(
      onPressed: () {
        VideoDialogRepublic.show(
          context: context,
        );
      },
      icon: const Icon(Icons.videocam_outlined),
      label: const Text(LocaleKeys.message_republicDay).tr(),
    );
  }
}

class _FilterButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRequestSending = ref.watch(_homeViewModel).isServiceRequestSending;
    final townCategoryModel = ref.watch(_homeViewModel).townCategoryModel;
    if (isRequestSending) return const SizedBox.shrink();
    final isAvailableItem = ref.watch(_homeViewModel).items.isEmpty;

    if (isAvailableItem && townCategoryModel == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () async {
          final selectedItem = await TownCategorySelectSheet.show(
            context,
            model: townCategoryModel,
          );
          ref.read(_homeViewModel.notifier).filter(selectedItem);
        },
        child: Text(ref.watch(_homeViewModel).filterTitle),
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
  const _PageBody({required this.onRefresh});
  final VoidCallback onRefresh;

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
      return SliverFillRemaining(
        child: NotFoundLottie(
          title: LocaleKeys.notFound_towns.tr(),
          onRefresh: onRefresh,
        ),
      );
    }

    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const PagePadding.onlyTop() + const PagePadding.allVeryLow(),
            child: PlaceCard(
              item: items[index],
              onTap: () {
                context.route
                    .navigateToPage(HomeDetailView(model: items[index]));
              },
            ),
          );
        },
      ),
    );
  }
}
