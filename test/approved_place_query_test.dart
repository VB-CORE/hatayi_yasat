import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/features/main/home/provider/approved_place_query.dart';
import 'package:lifeclient/product/model/enum/index.dart';

ApprovedPlaceQuery query({
  Set<int> categories = const {},
  Set<int> towns = const {},
}) {
  return ApprovedPlaceQuery(
    cityId: 'hatay',
    categoryValues: categories,
    townCodes: towns,
    sortingType: SortingTypes.newest,
  );
}

Set<int> range(int count) => {for (var i = 0; i < count; i++) i};

void main() {
  test('no selection is within the limit and allows a full axis', () {
    final subject = query();
    expect(subject.disjunctionCount, 1);
    expect(subject.isWithinLimit, isTrue);
    expect(subject.maxSelectableTowns, ApprovedPlaceQuery.maxDisjunctions);
    expect(subject.maxSelectableCategories, ApprovedPlaceQuery.maxDisjunctions);
  });

  test('a single axis may fill the whole limit', () {
    expect(query(towns: range(30)).isWithinLimit, isTrue);
    expect(query(towns: range(30)).isTownLimitExceeded, isFalse);
    expect(query(towns: range(31)).isWithinLimit, isFalse);
    expect(query(towns: range(31)).isTownLimitExceeded, isTrue);
  });

  test('axes multiply into the disjunction count', () {
    expect(query(categories: range(3), towns: range(10)).disjunctionCount, 30);
    expect(query(categories: range(3), towns: range(10)).isWithinLimit, isTrue);
    expect(query(categories: range(3), towns: range(11)).disjunctionCount, 33);
    expect(
      query(categories: range(3), towns: range(11)).isWithinLimit,
      isFalse,
    );
  });

  test('each axis limit is the budget left by the other one', () {
    final subject = query(categories: range(3), towns: range(11));
    expect(subject.maxSelectableTowns, 10);
    expect(subject.maxSelectableCategories, 2);
    expect(subject.isTownLimitExceeded, isTrue);
    expect(subject.isCategoryLimitExceeded, isTrue);
  });

  test('an empty axis does not shrink the other one', () {
    final subject = query(towns: range(11));
    expect(subject.maxSelectableTowns, 30);
    expect(subject.isTownLimitExceeded, isFalse);
    expect(subject.isCategoryLimitExceeded, isFalse);
  });
}
