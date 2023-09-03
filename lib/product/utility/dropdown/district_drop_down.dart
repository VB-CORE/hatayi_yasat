import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/firebase/town_model.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

class DistrictDropDownView extends ConsumerStatefulWidget {
  const DistrictDropDownView({
    required this.onSelected,
    super.key,
  });
  final ValueChanged<TownModel> onSelected;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DistrictDropDownViewState();
}

class _DistrictDropDownViewState extends ConsumerState<DistrictDropDownView> {
  ProductProvider get appProvider =>
      ref.read(ProductProvider.provider.notifier);
  ProductProviderState get appState => ref.read(ProductProvider.provider);
  late final List<TownModel> items;
  TownModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    items = appState.townItems;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: DropdownButtonFormField<TownModel>(
        validator: _check,
        isExpanded: true,
        items: items
            .map(
              (e) => DropdownMenuItem<TownModel>(
                value: e,
                child: _DropdownTitle(e.name ?? ''),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: LocaleKeys.requestCompany_district.tr(),
        ),
        onChanged: _onChanged,
        value: _selectedItem,
      ),
    );
  }

  String? _check(TownModel? value) {
    if (value == null) {
      return LocaleKeys.requestCompany_district.tr();
    }
    return null;
  }

  void _onChanged(TownModel? value) {
    if (value == null) return;
    setState(() {
      _selectedItem = value;
    });
    widget.onSelected(value);
  }
}

class _DropdownTitle extends StatelessWidget {
  const _DropdownTitle(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
    );
  }
}
