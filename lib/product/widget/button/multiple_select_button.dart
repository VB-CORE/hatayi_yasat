import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/mixin/multiple_select_button_mixin.dart';

final class MultipleSelectItem extends Equatable {
  const MultipleSelectItem({required this.title, required this.id});

  final String title;
  final String id;

  @override
  List<Object?> get props => [title, id];
}

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
    return ValueListenableBuilder(
      valueListenable: selectedItemsNotifier,
      builder: (context, selectedItems, child) {
        return SingleChildScrollView(
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
                    padding: EdgeInsets.zero,
                    backgroundColor: isSelected
                        ? context.general.colorScheme.primary
                        : Colors.transparent,
                    label: _Title(item: items[index], isSelected: isSelected),
                  ),
                ),
              );
            }),
          ),
        );
      },
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
    return Text(
      item.title,
      style: context.general.textTheme.titleSmall?.copyWith(
        color: isSelected
            ? context.general.colorScheme.secondary
            : context.general.colorScheme.primary,
      ),
    );
  }
}
