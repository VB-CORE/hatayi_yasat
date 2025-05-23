import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/widget/divider/sheet_gap_divider.dart';

part './widget/select_sheet/select_sheet_sub_card.dart';

final class SelectSheetModel extends Equatable {
  const SelectSheetModel({required this.title, required this.id});

  final String title;
  final String id;

  @override
  List<Object> get props => [id];
}

final class GeneralSelectSheet extends StatefulWidget {
  const GeneralSelectSheet({
    required this.items,
    super.key,
    this.initialItem,
    this.isDismissible = false,
    this.mainAxisSize = MainAxisSize.max,
  });
  final List<SelectSheetModel> items;
  final SelectSheetModel? initialItem;
  final bool isDismissible;
  final MainAxisSize mainAxisSize;

  static Future<SelectSheetModel?> show(
    BuildContext context, {
    required List<SelectSheetModel> items,
    SelectSheetModel? initialItem,
    bool isDismissible = false,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) async {
    return showModalBottomSheet<SelectSheetModel>(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        return GeneralSelectSheet(
          items: items,
          initialItem: initialItem,
          mainAxisSize: mainAxisSize,
        );
      },
    );
  }

  @override
  State<GeneralSelectSheet> createState() => _GeneralSelectSheetState();
}

class _GeneralSelectSheetState extends State<GeneralSelectSheet> {
  late final List<SelectSheetModel> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: widget.mainAxisSize,
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
        Flexible(
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: widget.mainAxisSize == MainAxisSize.min,
              itemCount: widget.items.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: context.general.colorScheme.primary,
                  thickness: .3,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return _SelectSheetSubCard(
                  isSelectedInitial: widget.initialItem == _items[index],
                  item: _items[index],
                  onSelected: (value) {
                    context.route.pop(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
