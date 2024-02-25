import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/search_response_model.dart';
import 'package:lifeclient/product/package/firebase/custom_functions.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class PlaceSearchDelegate extends SearchDelegate<SearchResponse> {
  PlaceSearchDelegate();

  List<SearchResponse> _history = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(AppIcons.delete),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      const InputDecorationTheme();

  Widget _buildResultsOrSuggestions(BuildContext context) {
    if (query.trim().length < 3) {
      return Center(
        child: Assets.lottie.search.lottie(
          height: context.sized.dynamicHeight(.2),
        ),
      );
    }

    return FutureBuilder<List<SearchResponse>>(
      future: CustomFunctions().searchPlaces(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _history = snapshot.data!;
          return _BuildResult(
            query: query,
            items: snapshot.data!,
            onSelected: (value) {
              close(context, value);
            },
          );
        } else {
          return Center(
            child: Assets.lottie.search.lottie(
              height: context.sized.dynamicHeight(.2),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsOrSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty && _history.isNotEmpty) {
      return _BuildResult(
        query: query,
        items: _history,
        onSelected: (value) {
          close(context, value);
        },
      );
    }

    if (_history.isNotEmpty) _history.clear();
    return Center(
      child: Assets.lottie.search.lottie(
        height: context.sized.dynamicHeight(.2),
      ),
    );
  }
}

class _BuildResult extends StatelessWidget {
  const _BuildResult({
    required this.items,
    required this.onSelected,
    required this.query,
  });

  final List<SearchResponse> items;
  final ValueChanged<SearchResponse> onSelected;
  final String query;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _EmptyResult();

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          leading: FaIcon(
            FontAwesomeIcons.store,
            size: context.sized.normalValue,
          ),
          title: Text(items[index].name),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () {
            onSelected.call(items[index]);
          },
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
          Text(
            LocaleKeys.message_emptySearch,
            style: context.general.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorCommon(context).whiteAndBlackForTheme,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
