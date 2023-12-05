import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/divider/sheet_gap_divider.dart';

part './widget/select_sheet/select_sheet_save_button.dart';
part './widget/select_sheet/select_sheet_sub_card.dart';

final class SelectSheetModel {
  const SelectSheetModel({required this.title, required this.id});

  final String title;
  final String id;
}

final class GeneralSelectSheet extends StatefulWidget {
  const GeneralSelectSheet({required this.items, super.key, this.initialItem});
  final List<SelectSheetModel> items;
  final SelectSheetModel? initialItem;

  static Future<SelectSheetModel?> show(
    BuildContext context, {
    required List<SelectSheetModel> items,
    SelectSheetModel? initialItem,
  }) async {
    return showModalBottomSheet<SelectSheetModel>(
      context: context,
      isDismissible: false,
      builder: (context) {
        return GeneralSelectSheet(items: items, initialItem: initialItem);
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
          child: Scrollbar(
            child: ListView.separated(
              itemCount: widget.items.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: context.general.colorScheme.onTertiaryContainer
                      .withOpacity(0.2),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return _SelectSheetSubCard(
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
