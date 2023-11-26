part of '../filter_search_view.dart';

final class _FilterSearchTownsHeader extends ConsumerWidget {
  const _FilterSearchTownsHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = ref.read(ProductProvider.provider).townItemsWithAll;
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: Row(
        children: [
          Text(
            LocaleKeys.component_filter_districts.tr(),
            style: context.general.textTheme.titleSmall,
          ),
          const Spacer(),
          Text(LocaleKeys.utils_options.tr(args: ['${towns.length}'])),
        ],
      ),
    );
  }
}
