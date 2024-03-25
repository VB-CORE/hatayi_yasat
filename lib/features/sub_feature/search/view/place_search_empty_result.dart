part of '../place_search_delegate.dart';

final class _PlaceSearchEmptyResult extends StatefulWidget {
  const _PlaceSearchEmptyResult({required this.onSelected});
  final ValueChanged<String> onSelected;

  @override
  State<_PlaceSearchEmptyResult> createState() =>
      _PlaceSearchEmptyResultState();
}

class _PlaceSearchEmptyResultState extends State<_PlaceSearchEmptyResult> {
  final ValueNotifier<List<String>> _lastSearchItemsNotifier =
      ValueNotifier(ProjectDependencyItems.productProvider.lastSearchItems);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _lastSearchItemsNotifier,
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (value.isNotEmpty)
                _LastSearchItemBody(
                  lastSearchItems: value,
                  onSelected: widget.onSelected,
                  onClear: () => _lastSearchItemsNotifier.value = [],
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
          );
        },
      ),
    );
  }
}

final class _LastSearchItemBody extends StatelessWidget {
  const _LastSearchItemBody({
    required this.lastSearchItems,
    required this.onSelected,
    required this.onClear,
  });

  final List<String> lastSearchItems;
  final ValueChanged<String> onSelected;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontal16Symmetric() +
          const PagePadding.onlyTopLow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralBodyTitle(LocaleKeys.search_latestSearch.tr()),
              TextButton(
                onPressed: () {
                  ProjectDependencyItems.productProvider.clearLastSearch();
                  onClear.call();
                },
                child: Text(
                  LocaleKeys.button_clean.tr(),
                  style: context.general.textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
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
