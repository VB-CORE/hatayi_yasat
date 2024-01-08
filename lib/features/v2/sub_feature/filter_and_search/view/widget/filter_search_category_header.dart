part of '../filter_search_view.dart';

final class _FilterSearchCategoryHeader extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchCategoryHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = productState(ref).categoryItems;

    return Row(
      children: [
        Text(
          LocaleKeys.component_filter_categories.tr(),
          style: context.general.textTheme.titleSmall,
        ),
        const Spacer(),
        Text(
          LocaleKeys.utils_options.tr(
            args: [categories.length.toString()],
          ),
        ),
      ],
    );
  }
}
