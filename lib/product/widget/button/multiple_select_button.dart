import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/widget/button/mixin/multiple_select_button_mixin.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';
import 'package:lifeclient/product/widget/scrollbar/product_scroll_bar.dart';

final class MultipleSelectButton extends StatefulWidget {
  const MultipleSelectButton({
    required this.items,
    required this.onUpdatedSelectedItems,
    this.selectedItems = const [],
    super.key,
  });

  final List<MultipleSelectItem> items;
  final ValueChanged<List<MultipleSelectItem>> onUpdatedSelectedItems;
  final List<MultipleSelectItem> selectedItems;

  @override
  State<MultipleSelectButton> createState() => _MultipleSelectButtonState();
}

class _MultipleSelectButtonState extends State<MultipleSelectButton>
    with MultipleSelectButtonMixin {
  @override
  Widget build(BuildContext context) {
    /// device width added to align ScrollBar at the right of the screen
    return SizedBox(
      width: context.general.mediaSize.width,
      child: ProductScrollBar(
        child: ValueListenableBuilder(
          valueListenable: selectedItemsNotifier,
          builder: (context, selectedItems, _) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Wrap(
                children: List.generate(items.length, (index) {
                  final isSelected = selectedItems.contains(items[index]);

                  return Padding(
                    padding: const PagePadding.onlyRight(),
                    child: InkWell(
                      onTap: () {
                        addOrRemoveItem(items[index]);
                      },
                      child: Chip(
                        elevation: kZero,
                        padding: EdgeInsets.zero,
                        backgroundColor: isSelected
                            ? context.general.colorScheme.primary
                            : context.general.colorScheme.secondary,
                        label:
                            _Title(item: items[index], isSelected: isSelected),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

final class _Title extends StatelessWidget {
  const _Title({
    required this.item,
    required this.isSelected,
  });

  final MultipleSelectItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSelected ? AppIcons.close : AppIcons.add,
          color: isSelected
              ? context.general.colorScheme.secondary
              : context.general.colorScheme.primary,
        ),
        Text(
          item.title,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: isSelected
                ? context.general.colorScheme.secondary
                : context.general.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
