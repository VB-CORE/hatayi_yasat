part of './home_search_delegate.dart';

mixin _HomeSearchOperation on _ResultItems {
  List<StoreModel> searchByAlgorithm() {
    List<StoreModel> searchingItems;

    if (initialCategory.value == kErrorNumber.toInt()) {
      searchingItems = items;
    } else {
      searchingItems = items
          .where((element) => element.category == initialCategory)
          .toList();
    }

    final suggestions = searchingItems
        .where(
          (element) =>
              (element.name.toLowerCase().ext.withoutSpecialCharacters ?? '')
                  .contains(
            query.ext.withoutSpecialCharacters?.toLowerCase() ?? '',
          ),
        )
        .toList();

    return suggestions;
  }
}
