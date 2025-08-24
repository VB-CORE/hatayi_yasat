part of '../favorite_view.dart';

final class _FavoriteClearAllButton extends StatelessWidget {
  const _FavoriteClearAllButton({required this.onPressed});

  final ValueChanged<bool> onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => _showApproveDialog(context),
        child: GeneralContentSubTitle(
          value: LocaleKeys.favorite_clearAllButton.tr(context: context),
        ),
      ),
    );
  }

  Future<void> _showApproveDialog(BuildContext context) async =>
      GeneralTextDialog.show(
        context,
        LocaleKeys.favorite_clearAllButton.tr(),
        LocaleKeys.favorite_clearAllDialog_content.tr(),
        [
          GeneralDialogButton(
            title: LocaleKeys.button_cancel,
            onPressed: () => _popAndOnPressed(context, false),
          ),
          GeneralDialogButton(
            title: LocaleKeys.button_iAmSure,
            onPressed: () => _popAndOnPressed(context, true),
          ),
        ],
      );

  void _popAndOnPressed(BuildContext context, bool value) {
    Navigator.pop(context);
    onPressed(value);
  }
}
