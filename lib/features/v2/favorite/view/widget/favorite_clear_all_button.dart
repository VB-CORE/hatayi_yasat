part of '../favorite_view.dart';

final class _FavoriteClearAllButton extends StatelessWidget {
  const _FavoriteClearAllButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed.call,
      child: GeneralContentSubTitle(
        value: LocaleKeys.favorite_clearAllButton.tr(),
      ),
    );
  }
}
