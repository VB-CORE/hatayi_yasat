part of '../home_view.dart';

final class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: InkWell(
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
      ).ext.sliver,
    );
  }
}
