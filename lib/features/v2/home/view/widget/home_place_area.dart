part of '../home_view.dart';

final class _HomePlacesArea extends ConsumerWidget {
  const _HomePlacesArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Shimmer ismi GeneralPlaceShimmer.
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const PagePadding.onlyBottomMedium(),
          child: GeneralPlaceCard(onCardTap: () {}),
        );
      },
    );
  }
}
