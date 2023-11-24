part of '../filter_search_view.dart';

final class _FilterSearchButton extends StatelessWidget {
  const _FilterSearchButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: SafeArea(
        child: GeneralButtonV2.active(action: () {}, label: 'Filter'),
      ),
    );
  }
}
