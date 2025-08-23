import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum SortingTypes {
  newest(LocaleKeys.sorting_time_newest),
  oldest(LocaleKeys.sorting_time_oldest);

  final String detail;
  // ignore: sort_constructors_first
  // This constructor order is intentional for better readability
  const SortingTypes(this.detail);

  SortingTypes change() {
    return this == SortingTypes.newest
        ? SortingTypes.oldest
        : SortingTypes.newest;
  }
}
