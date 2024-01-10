part of '../filter_search_view.dart';

final class _FilterSearchButton extends ConsumerWidget {
  const _FilterSearchButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: SafeArea(
        child: GeneralButtonV2.active(
          action: () {
            final provider = ref.read(filterWithSearchProvider);
            context.pop(
              FilterSelected(
                selectedCategories: provider.selectedCategories,
                selectedTowns: provider.selectedTowns,
              ),
            );
          },
          isEnabled: ref.watch(filterWithSearchProvider).isSelectedItems,
          label: LocaleKeys.button_showResult.tr(),
        ),
      ),
    );
  }
}
