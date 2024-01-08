import 'package:cloud_functions/cloud_functions.dart';
import 'package:vbaseproject/product/model/search_response_model.dart';

final class CustomFunctions {
  static const String _search = 'search';
  final _searchCallable = FirebaseFunctions.instance.httpsCallable(
    _search,
  );

  Future<List<SearchResponse>> searchPlaces(String key) async {
    final response = await _searchCallable.call<List<dynamic>>({
      'term': key,
      'page': 1,
    });

    final results = response.data;
    if (results.isEmpty) {
      return [];
    }

    return results.map((e) {
      return SearchResponse.fromMap(e as Map<dynamic, dynamic>);
    }).toList();
  }
}
