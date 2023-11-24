part of '../filter_search_view.dart';

final class _FilterSearchCategoryHeader extends StatelessWidget {
  const _FilterSearchCategoryHeader({
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.component_filter_categories.tr(),
          style: context.general.textTheme.titleSmall,
        ),
        const Spacer(),
        Text('${categories.length} items'),
      ],
    );
  }
}
