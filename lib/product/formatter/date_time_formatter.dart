import 'package:intl/intl.dart';

final class DateTimeFormatter {
  static String formatValue(DateTime value) {
    final formattedValue = DateFormat('yyyy-MM-dd').format(value);
    return formattedValue;
  }
}
