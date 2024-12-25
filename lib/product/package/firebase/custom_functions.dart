import 'package:cloud_functions/cloud_functions.dart';
import 'package:lifeclient/product/model/search/search_request_model.dart';
import 'package:lifeclient/product/model/search_response_model.dart';

final class CustomFunctions {
  static const String _search = 'search';
  final _searchCallable = FirebaseFunctions.instance.httpsCallable(
    _search,
  );

  Future<List<SearchResponse>> searchPlaces(String key) async {
    final response = await _searchCallable.call<List<dynamic>>(
      SearchRequestModel(term: key).toJson(),
    );

    final items = response.data;
    if (items.isEmpty) return [];

    return items.map((e) {
      assert(
        e is Map<dynamic, dynamic>,
        '$e is not Map<dynamic, dynamic> $this',
      );
      final resultMap = Map<String, dynamic>.from(e as Map<dynamic, dynamic>);

      return SearchResponse.fromJson(resultMap);
    }).toList();
  }
}
