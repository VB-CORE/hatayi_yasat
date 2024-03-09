import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

class CustomRectangleBorder extends RoundedRectangleBorder {
  const CustomRectangleBorder({
    super.side = BorderSide.none,
    super.borderRadius = CustomRadius.medium,
  });
}

class CustomBottomSheetBorder extends RoundedRectangleBorder {
  const CustomBottomSheetBorder({
    super.side = BorderSide.none,
    super.borderRadius = CustomRadius.bottomSheetRadius,
  });
}
