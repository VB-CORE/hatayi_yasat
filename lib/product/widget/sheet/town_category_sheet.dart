import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/divider/sheet_gap_divider.dart';
import 'package:lifeclient/product/widget/popup/category_popup.dart';
import 'package:lifeclient/product/widget/popup/town_popup.dart';
import 'package:lifeclient/product/widget/sheet/operation/town_category_operation.dart';

class TownCategorySelectSheet extends ConsumerStatefulWidget {
  const TownCategorySelectSheet({
    super.key,
    this.initialItem,
  });
  final TownCategoryModel? initialItem;

  static Future<TownCategoryModel?> show(
    BuildContext context, {
    TownCategoryModel? model,
  }) async {
    return showModalBottomSheet<TownCategoryModel>(
      context: context,
      builder: (context) {
        return TownCategorySelectSheet(initialItem: model);
      },
    );
  }

  @override
  ConsumerState<TownCategorySelectSheet> createState() =>
      _TownSelectSheetState();
}

class _TownSelectSheetState extends ConsumerState<TownCategorySelectSheet>
    with TownCategoryOperation {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SheetGapDivider(),
        _FilterSheetHeader(),
        Column(
          children: [
            ListTile(
              dense: true,
              title: const Text(LocaleKeys.component_filter_districts).tr(),
              subtitle: const Text(
                LocaleKeys.component_filter_districtDescription,
              ).tr(),
              trailing: SizedBox(
                width: context.sized.dynamicWidth(0.4),
                child: TownPopup(
                  initialItem: selectedTownCategory.town,
                  onSelected: updateTown,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              dense: true,
              title: const Text(LocaleKeys.component_filter_categories).tr(),
              subtitle: const Text(
                LocaleKeys.component_filter_categoryDescription,
              ).tr(),
              trailing: SizedBox(
                width: context.sized.dynamicWidth(0.4),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CategoryPopup(
                    initialItem: selectedTownCategory.category,
                    onSelected: updateCategory,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const PagePadding.onlyTopNormal(),
          child: SafeArea(
            child: _SelectListButton(
              onResetWithComplete: clear,
              validationNotifier: validationOperate,
              onComplete: () {
                context.route.pop<TownCategoryModel>(
                  selectedTownCategory,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectListButton extends StatelessWidget {
  const _SelectListButton({
    required ValueNotifier<bool> validationNotifier,
    required this.onComplete,
    required this.onResetWithComplete,
  }) : _validationNotifier = validationNotifier;

  final ValueNotifier<bool> _validationNotifier;
  final VoidCallback onComplete;
  final VoidCallback onResetWithComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric() +
          const PagePadding.onlyBottom(),
      child: ValueListenableBuilder<bool>(
        valueListenable: _validationNotifier,
        builder: (BuildContext context, bool value, Widget? child) {
          return Column(
            children: [
              TextButton(
                onPressed: value ? onResetWithComplete : null,
                child: const Text(
                  LocaleKeys.button_withoutFilter,
                ).tr(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.general.colorScheme.inversePrimary,
                  foregroundColor: context.general.colorScheme.onPrimary,
                ),
                onPressed: !value ? null : onComplete.call,
                child: Center(
                  child: Text(
                    LocaleKeys.button_selectedList,
                    style: context.general.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorCommon(context).whiteAndBlackForTheme,
                    ),
                  ).tr(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterSheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const PagePadding.onlyRight(),
        child: InkWell(
          onTap: () {
            context.route.pop();
          },
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}
