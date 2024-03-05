part of '../place_search_delegate.dart';

class _PlaceSearchEmptyResult extends StatelessWidget {
  const _PlaceSearchEmptyResult({required this.onSelected});
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final lastSearchItems =
        ProjectDependencyItems.productProvider.lastSearchItems;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (lastSearchItems.isNotEmpty)
            Padding(
              padding: const PagePadding.horizontal16Symmetric() +
                  const PagePadding.onlyTopLow(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralBodyTitle(LocaleKeys.search_latestSearch.tr()),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: lastSearchItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton.icon(
                        onPressed: () {
                          onSelected.call(lastSearchItems[index]);
                        },
                        icon: const Icon(Icons.done_all_outlined),
                        label: Text(lastSearchItems[index]),
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          const Spacer(),
          Assets.lottie.infoPlaceLottie.lottie(
            height: context.sized.dynamicHeight(.2),
          ),
          Text(
            LocaleKeys.search_minumumSearch.tr(args: ['3']),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

final class _EmptyResponseResult extends StatelessWidget {
  const _EmptyResponseResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(AppIcons.clear),
          Text(
            LocaleKeys.message_emptySearch,
            style: context.general.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorCommon(context).whiteAndBlackForTheme,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
