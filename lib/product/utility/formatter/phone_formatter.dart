/// it will help to convert phone number to a specific format for phone call
final class PhoneFormatter {
  const PhoneFormatter._();

  static String format(String? phoneNumber) {
    if (phoneNumber == null) return '';
    if (phoneNumber.isEmpty) return '';
    return phoneNumber.startsWith('0')
        ? phoneNumber.replaceFirst('0', '90')
        : '09$phoneNumber';
  }
}
