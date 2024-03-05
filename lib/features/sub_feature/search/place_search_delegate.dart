import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/search_response_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/package/firebase/custom_functions.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part './view/place_build_response_result.dart';
part './view/place_search_empty_result.dart';

final class PlaceSearchDelegate extends SearchDelegate<SearchResponse>
    with _PlaceSearchMixin {
  PlaceSearchDelegate();

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

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsOrSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty && _history.isNotEmpty) {
      return _PlaceSearchResponseResult(
        query: query,
        items: _history,
        onSelected: (value) {
          _navigateDetail(value, context);
        },
      );
    }

    return _PlaceSearchEmptyResult(
      onSelected: (value) {
        query = value;
        showResults(context);
      },
    );
  }

  Widget _buildResultsOrSuggestions(BuildContext context) {
    if (!query.isNotEmptyAndLength) {
      if (_history.isNotEmpty) _history.clear();
      return _PlaceSearchEmptyResult(
        onSelected: (value) {
          query = value;
          showResults(context);
        },
      );
    }

    return FutureBuilder<List<SearchResponse>>(
      future: CustomFunctions().searchPlaces(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _history = snapshot.data ?? [];
          return _PlaceSearchResponseResult(
            query: query,
            items: snapshot.data!,
            onSelected: (value) {
              _navigateDetail(value, context);
            },
          );
        }

        return Center(
          child: Assets.lottie.searchingPlaceLottie.lottie(
            height: context.sized.dynamicHeight(.2),
          ),
        );
      },
    );
  }
}

extension _QueryCheckExtension on String {
  bool get isNotEmptyAndLength => isNotEmpty && trim().length > 2;
}

mixin _PlaceSearchMixin on SearchDelegate<SearchResponse> {
  List<SearchResponse> _history = [];

  Future<void> _navigateDetail(
    SearchResponse response,
    BuildContext context,
  ) async {
    ProjectDependencyItems.productProvider.saveLastSearch(query);
    await PlaceDetailRoute(
      $extra: StoreModel.empty(),
      id: response.id,
    ).push<void>(context);
  }
}
