import 'package:cloud_firestore/cloud_firestore.dart';

final class CategoryCodeFilter extends Filter {
  CategoryCodeFilter(List<int> categoryValues)
      : super(
          'category.value',
          whereIn: categoryValues,
        );
}
