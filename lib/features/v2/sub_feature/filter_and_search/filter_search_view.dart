import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/button/general_button_v2.dart';
import 'package:vbaseproject/product/widget/button/multiple_select_button.dart';
import 'package:vbaseproject/product/widget/checkbox/product_checkbox.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';

final class FilterSearchView extends ConsumerWidget {
  const FilterSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.read(ProductProvider.provider).categoryItemsWithAll;

    final items = categories
        .map((e) => MultipleSelectItem(title: e.displayName, id: e.documentId))
        .toList();

    final towns = ref.read(ProductProvider.provider).townItemsWithAll;
    return GeneralScaffold(
      appBar: AppBar(
          // title: const GeneralBigTitle('Find your place'),
          ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.component_filter_categories.tr(),
                style: context.general.textTheme.titleSmall,
              ),
              const Spacer(),
              Text('${categories.length} items'),
            ],
          ),
          const Divider(),
          Expanded(
            flex: 2,
            child: MultipleSelectButton(
              items: items,
              onUpdatedSelectedItems: (items) {},
            ),
          ),
          const Divider(),
          Padding(
            padding: const PagePadding.onlyTop(),
            child: Row(
              children: [
                Text(
                  LocaleKeys.component_filter_districts.tr(),
                  style: context.general.textTheme.titleSmall,
                ),
                const Spacer(),
                Text('${towns.length} items'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: towns.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCheckbox(
                  title: Text(towns[index].displayName),
                  onSaved: (value) {},
                  validator: (value) {
                    return null;
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const PagePadding.onlyTop(),
            child: SafeArea(
              child: GeneralButtonV2.active(action: () {}, label: 'Filter'),
            ),
          ),
        ],
      ),
    );
  }
}
