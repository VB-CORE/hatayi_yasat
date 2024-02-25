import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/divider/sheet_gap_divider.dart';

class TownSelectSheet extends StatefulWidget {
  const TownSelectSheet({required this.items, super.key, this.initialItem});
  final List<TownModel> items;
  final TownModel? initialItem;

  static Future<TownModel?> show(
    BuildContext context, {
    required List<TownModel> items,
    TownModel? initialItem,
  }) async {
    return showModalBottomSheet<TownModel>(
      context: context,
      builder: (context) {
        return TownSelectSheet(items: items, initialItem: initialItem);
      },
    );
  }

  @override
  State<TownSelectSheet> createState() => _TownSelectSheetState();
}

class _TownSelectSheetState extends State<TownSelectSheet> {
  late final List<TownModel> _townItems;
  final ValueNotifier<TownModel?> _selectedTownNotifier = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    _townItems = widget.items;
    _selectedTownNotifier.value = widget.initialItem;
  }

  bool _isSelectedTown(int index) =>
      _selectedTownNotifier.value?.documentId == _townItems[index].documentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Stack(
          children: [
            SheetGapDivider(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: PagePadding.horizontal16Symmetric(),
                child: _FilterSheetHeader(),
              ),
            ),
          ],
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _selectedTownNotifier,
            builder: (context, value, child) {
              return ListView.separated(
                itemCount: widget.items.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0,
                    color: context.general.colorScheme.onTertiaryContainer
                        .withOpacity(0.2),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return _FilterCard(
                    item: _townItems[index],
                    isSelected: _isSelectedTown(index),
                    onSelected: (value) {
                      _selectedTownNotifier.value = value;
                    },
                  );
                },
              );
            },
          ),
        ),
        SafeArea(
          child: _SelectListButton(selectedTownNotifier: _selectedTownNotifier),
        ),
      ],
    );
  }
}

class _SelectListButton extends StatelessWidget {
  const _SelectListButton({
    required ValueNotifier<TownModel?> selectedTownNotifier,
  }) : _selectedTownNotifier = selectedTownNotifier;

  final ValueNotifier<TownModel?> _selectedTownNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: ValueListenableBuilder<TownModel?>(
        valueListenable: _selectedTownNotifier,
        builder: (BuildContext context, TownModel? value, Widget? child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.general.colorScheme.inversePrimary,
              foregroundColor: context.general.colorScheme.onPrimary,
            ),
            onPressed: value == null
                ? null
                : () {
                    context.route.pop<TownModel>(value);
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

class _FilterCard extends StatelessWidget {
  const _FilterCard({
    required this.item,
    required this.onSelected,
    required this.isSelected,
  });

  final TownModel item;
  final ValueChanged<TownModel?> onSelected;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () {
        onSelected.call(item);
      },
      title: Text(item.name ?? ''),
      trailing: Icon(
        Icons.check,
        color: isSelected
            ? context.general.colorScheme.onError
            : context.general.colorScheme.onError.withOpacity(0.2),
      ),
    );
  }
}

class _FilterSheetHeader extends StatelessWidget {
  const _FilterSheetHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.route.pop<TownModel>(
              TownModel(
                code: kErrorNumber.toInt(),
                name: LocaleKeys.button_allFilter.tr(),
              ),
            );
          },
          child: Padding(
            padding: const PagePadding.horizontalLowSymmetric(),
            child: const Text(LocaleKeys.button_clean).tr(),
          ),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.route.pop();
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
