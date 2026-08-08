class RegexTypes {
  RegexTypes._();

  static RegExp get firstAndLastName => RegExp(
    r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)",
  );

  static RegExp phoneNumberRegex = RegExp('[^0-9]');

  static RegExp studentMailRegex = RegExp(
    r'[\w.-]+@[a-zA-Z0-9.-]+\.(edu|edu\.[a-zA-Z]{2,})',
  );

  static final RegExp whitespace = RegExp(r'\s+');

  static final RegExp multipleSpaces = RegExp(r'[ \t]+');

  static final RegExp aroundLineBreaks = RegExp(r'[ \t]*\n[ \t]*');

  static final RegExp excessiveLineBreaks = RegExp(r'\n{3,}');

  /// `:id` style path parameters in a go_router route pattern.
  static final RegExp routePathParameter = RegExp(r':\w+');

  static final RegExp pathSeparators = RegExp('[/-]');

  /// Boundary between a lowercase/digit and the uppercase that starts the next
  /// word, e.g. the `eD` in `placeDetail`.
  static final RegExp camelCaseBoundary = RegExp('([a-z0-9])([A-Z])');
}
