import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/sheet/town_select_sheet.dart';

class FilterButton extends ConsumerStatefulWidget {
  const FilterButton({
    required this.onSelected,
    super.key,
  });
  final ValueChanged<TownModel?> onSelected;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterButtonState();
}

class _FilterButtonState extends ConsumerState<FilterButton> with _FilterMixin {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _openDialog,
      icon: const Icon(Icons.filter_alt_outlined),
      label: ValueListenableBuilder<TownModel?>(
        valueListenable: _selectedTownNotifier,
        builder: (context, value, child) {
          if (value == null) {
            return const Text(LocaleKeys.button_allFilter).tr();
          }
          final item = value.name;
          if (item == null || item.isEmpty) return const SizedBox.shrink();
          return Text(item);
        },
      ),
    );
  }
}

mixin _FilterMixin on ConsumerState<FilterButton> {
  late final List<TownModel> _townItems;
  final ValueNotifier<TownModel?> _selectedTownNotifier = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    _townItems = [];
  }

  Future<void> _openDialog() async {
    final response = await TownSelectSheet.show(
      context,
      items: _townItems,
      initialItem: _selectedTownNotifier.value,
    );

    if (response == null) return;
    widget.onSelected(response);
    _selectedTownNotifier.value = response;
  }
}
