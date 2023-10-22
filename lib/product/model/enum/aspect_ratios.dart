enum AspectRatios {
  /// aspect ratio value: 1
  square(value: 1),

  /// aspect ratio value: 4 / 3
  standart(value: 4 / 3),

  /// aspect ratio value: 16 / 9
  wide(value: 16 / 9),

  /// aspect ratio value: 5 / 2
  horizontalLow(value: 5 / 2),

  /// aspect ratio value: 3 / 4
  verticalLow(value: 3 / 4),
  ;

  const AspectRatios({required this.value});
  final double value;
}
