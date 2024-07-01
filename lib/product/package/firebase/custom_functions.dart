import 'package:cloud_functions/cloud_functions.dart';
import 'package:lifeclient/product/model/search_response_model.dart';

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

    if (response.data.isEmpty) {
      return [];
    }
    final results = response.data;

    return results.map((e) {
      final resultMap = Map<String, dynamic>.from(e as Map<dynamic, dynamic>);

      /// TODO: Change this to your model
      return SearchResponse.fromJson(resultMap);
    }).toList();
  }
}
