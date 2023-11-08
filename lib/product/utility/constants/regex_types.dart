class RegexTypes {
  RegexTypes._();

  static RegExp get firstAndLastName => RegExp(
        r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)",
      );

  static RegExp phoneNumberRegex = RegExp('[^0-9]');

  static RegExp studentMailRegex = RegExp(
    r'[\w.-]+@[a-zA-Z0-9.-]+\.(edu|edu\.[a-zA-Z]{2,})',
  );
}
