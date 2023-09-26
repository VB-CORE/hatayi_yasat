import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class HomeSearchDelegate extends SearchDelegate<StoreModel> {
  HomeSearchDelegate({required this.items});
  final int _maxLength = 3;
  final List<StoreModel> items;
  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

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

    final suggestions = items
        .where(
          (element) =>
              (element.name.toLowerCase().ext.withoutSpecialCharacters ?? '')
                  .contains(
                      query.ext.withoutSpecialCharacters?.toLowerCase() ?? ''),
        )
        .toList();

    if (suggestions.isEmpty) {
      return const _EmptyResult();
    }

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
              close(context, suggestions[index]);
            },
          ),
        );
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
