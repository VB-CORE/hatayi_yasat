part of '../../general_select_sheet.dart';

class _SelectListSaveButton extends StatelessWidget {
  const _SelectListSaveButton({
    required ValueNotifier<SelectSheetModel?> selectedTownNotifier,
  }) : _selectedTownNotifier = selectedTownNotifier;

  final ValueNotifier<SelectSheetModel?> _selectedTownNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: ValueListenableBuilder<SelectSheetModel?>(
        valueListenable: _selectedTownNotifier,
        builder:
            (BuildContext context, SelectSheetModel? value, Widget? child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.general.colorScheme.inversePrimary,
              foregroundColor: context.general.colorScheme.onPrimary,
            ),
            onPressed: value == null
                ? null
                : () {
                    context.route.pop<SelectSheetModel>(value);
                  },
            child: Center(
              child: const Text(LocaleKeys.button_selectedList).tr(),
            ),
          );
        },
      ),
    );
  }
}
