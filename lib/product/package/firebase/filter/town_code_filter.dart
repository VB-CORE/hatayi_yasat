import 'package:cloud_firestore/cloud_firestore.dart';

final class TownCodeFilter extends Filter {
  TownCodeFilter(List<int> codeValues)
      : super(
          'townCode',
          whereIn: codeValues,
        );
}
