/// Enum for text field max lengths
enum TextFieldMaxLengths {
  none(null),

  /// 20
  small(20),

  /// 50
  medium(50),

  /// 100
  large(100),

  /// 200
  veryLarge(200);

  const TextFieldMaxLengths(this.value);

  final int? value;

  /// 5: For line length in text field
  static const int maxLine = 5;

  /// 2: For line length in text field
  static const int maxLineForText = 2;

  /// 1: For line length in text field
  static const int minLine = 1;
}
