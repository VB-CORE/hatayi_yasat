part of '../home_view.dart';

final class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField({required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: CustomSearchField(
        hint: LocaleKeys.home_search.tr(),
        onChange: (value) {
          onChanged.call();
        },
      ).ext.sliver,
    );
  }
}
