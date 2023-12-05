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
            ref.read(filterWithSearchProvider.notifier).filterSelected();
          },
          isEnabled: ref.watch(filterWithSearchProvider).isSelectedItems,
          label: LocaleKeys.button_showResult.tr(),
        ),
      ),
    );
  }
}
