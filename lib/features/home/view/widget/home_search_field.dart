part of '../home_view.dart';

final class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: SliverAppBar(
        floating: true,
        pinned: true,
        titleSpacing: kZero,
        actions: const [
          _ViewDesignButton(),
        ],
        title: InkWell(
          onTap: () async {
            final response = await showSearch<SearchResponse>(
              context: context,
              delegate: PlaceSearchDelegate(),
            );

            if (response == null) return;
            if (!context.mounted) return;
            PlaceDetailRoute(
              $extra: StoreModel.empty(),
              id: response.id,
            ).go(context);
          },
          child: IgnorePointer(
            child: CustomSearchField(
              hint: LocaleKeys.home_search.tr(),
              onChange: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}

final class _ViewDesignButton extends ConsumerStatefulWidget {
  const _ViewDesignButton();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewDesignButtonState();
}

class _ViewDesignButtonState extends ConsumerState<_ViewDesignButton>
    with SingleTickerProviderStateMixin, _ViewDesignMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.list_view,
        progress: animation,
      ),
      onPressed: () async {
        final isGridDesign = ref.read(homeViewModelProvider).isGridView;
        isGridDesign ? await controller.reverse() : await controller.forward();
        ref.read(homeViewModelProvider.notifier).changeHomeViewCardType();
      },
    );
  }
}

mixin _ViewDesignMixin
    on
        ConsumerState<_ViewDesignButton>,
        SingleTickerProviderStateMixin<_ViewDesignButton> {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Durations.short4,
    );
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
