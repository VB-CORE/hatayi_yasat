import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/extension/category_extension.dart';
import 'package:vbaseproject/product/utility/popup/category_popup.dart';

part './home_search_operation.dart';

class HomeSearchDelegate extends SearchDelegate<StoreModel> {
  HomeSearchDelegate({required this.items});
  final int _maxLength = 1;
  final List<StoreModel> items;
  CategoryModel _categoryModel = CategoryExtension.emptyAll;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CategoryPopup(
        onSelected: (value) {
          _categoryModel = value;
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      const InputDecorationTheme();

  Widget _buildResultsOrSuggestions(BuildContext context) {
    if (query.length < _maxLength) {
      return Center(
        child: Assets.lottie.search.lottie(
          height: context.sized.dynamicHeight(.2),
        ),
      );
    }

    return _BuildResult(
      query: query,
      items: items,
      initialCategory: _categoryModel,
      onSelected: (value) {
        close(context, value);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsOrSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultsOrSuggestions(context);
  }
}

mixin _ResultItems {
  List<StoreModel> get items;
  ValueChanged<StoreModel> get onSelected;
  CategoryModel get initialCategory;
  String get query;
}

class _BuildResult extends StatelessWidget
    with _ResultItems, _HomeSearchOperation {
  const _BuildResult({
    required this.items,
    required this.onSelected,
    required this.initialCategory,
    required this.query,
  });

  @override
  final List<StoreModel> items;
  @override
  final ValueChanged<StoreModel> onSelected;
  @override
  final CategoryModel initialCategory;
  @override
  final String query;

  @override
  Widget build(BuildContext context) {
    final suggestions = searchByAlgorithm();
    if (suggestions.isEmpty) return const _EmptyResult();

    return ListView.separated(
      itemCount: suggestions.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return Card(
          margin: context.padding.horizontalNormal,
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.store,
              size: context.sized.normalValue,
            ),
            title: Text(suggestions[index].name),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () {
              onSelected.call(suggestions[index]);
            },
          ),
        );
      },
    );
  }
}

class _EmptyResult extends StatelessWidget {
  const _EmptyResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.clear),
          const Text(LocaleKeys.message_emptySearch).tr(),
        ],
      ),
    );
  }
}
