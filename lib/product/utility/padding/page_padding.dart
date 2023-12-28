import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

@immutable
class PagePadding extends EdgeInsets {
  const PagePadding.defaultPadding()
      : super.symmetric(
          horizontal: WidgetSizes.spacingM,
        );

  /// value is 20
  const PagePadding.horizontalSymmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingL);

  /// value is 18
  const PagePadding.horizontal18Symmetric()
      : super.symmetric(
          horizontal: WidgetSizes.spacingM + WidgetSizes.spacingXSS,
        );

  /// value is 12
  const PagePadding.horizontalNormalSymmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingS);

  /// value is 40
  const PagePadding.horizontalHighSymmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingXxl4);

  /// value is 10
  const PagePadding.horizontalLowSymmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingXsMid);

  /// value is 4
  const PagePadding.horizontalVeryLowSymmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingXxs);

  /// value is 6
  const PagePadding.horizontalLowXss()
      : super.symmetric(
          horizontal: WidgetSizes.spacingXxs + WidgetSizes.spacingXSS,
        );

  /// value is 16
  const PagePadding.horizontal16Symmetric()
      : super.symmetric(horizontal: WidgetSizes.spacingM);

  /// value is 20
  const PagePadding.verticalSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingL);

  /// value is 32
  const PagePadding.verticalMediumHighSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXxl2);

  /// value is 16
  const PagePadding.verticalMediumSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingM);

  /// value is 40
  const PagePadding.verticalHigh()
      : super.symmetric(vertical: WidgetSizes.spacingXxl4);

  /// value is 4
  const PagePadding.verticalVeryLowSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXxs);

  /// value is 24
  const PagePadding.verticalNormalSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXl);

  /// value is 10
  const PagePadding.verticalLowSymmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXsMid);

  /// value is 8
  const PagePadding.vertical8Symmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXs);

  /// value is 6
  const PagePadding.vertical6Symmetric()
      : super.symmetric(vertical: WidgetSizes.spacingXSs);

  /// value is 12
  const PagePadding.vertical12Symmetric()
      : super.symmetric(vertical: WidgetSizes.spacingS);

  /// vertical value 40 , horizontal value 10
  const PagePadding.highVerticalLowHorizontal()
      : super.symmetric(
          vertical: WidgetSizes.spacingXxl4,
          horizontal: WidgetSizes.spacingXsMid,
        );

  /// value is 24
  const PagePadding.allNormal() : super.all(WidgetSizes.spacingXl);

  /// value is 20
  const PagePadding.all() : super.all(WidgetSizes.spacingL);

  /// value is 10
  const PagePadding.allLow() : super.all(WidgetSizes.spacingXsMid);

  /// value is 8
  const PagePadding.allVeryLow() : super.all(WidgetSizes.spacingXs);

  /// value is 10
  const PagePadding.generalLowAll() : super.all(WidgetSizes.spacingXsMid);

  /// value is 16
  const PagePadding.generalAllNormal() : super.all(WidgetSizes.spacingM);

  /// value is 12
  const PagePadding.generalAllLow() : super.all(WidgetSizes.spacingS);

  /// value is 12
  const PagePadding.generalCardAll() : super.all(WidgetSizes.spacingS);

  /// value is 8
  const PagePadding.generalCardOnlyRight()
      : super.only(right: WidgetSizes.spacingXs);

  /// value is 4
  const PagePadding.generalIconAll() : super.all(WidgetSizes.spacingXxs);

  /// value is 2
  const PagePadding.generalIconLowAll() : super.all(WidgetSizes.spacingXSS);

  /// value is 8
  const PagePadding.generalCircleAll() : super.all(WidgetSizes.spacingXs);

  /// value is 24
  const PagePadding.onlyLeftIcon() : super.only(left: WidgetSizes.spacingXl);

  /// value is 10
  const PagePadding.onlyLeft10() : super.only(left: WidgetSizes.spacingXsMid);

  /// value is 16
  const PagePadding.onlyLeft() : super.only(left: WidgetSizes.spacingM);

  /// value is 32
  const PagePadding.onlyLeftHigh() : super.only(left: WidgetSizes.spacingXxl2);

  /// value is 12
  const PagePadding.onlyLeftLow() : super.only(left: WidgetSizes.spacingS);

  /// value is 8
  const PagePadding.onlyLeftVeryLow() : super.only(left: WidgetSizes.spacingXs);

  /// value is 12
  const PagePadding.onlyBottomMedium()
      : super.only(bottom: WidgetSizes.spacingS);

  /// value is 24
  const PagePadding.onlyBottomNormal()
      : super.only(bottom: WidgetSizes.spacingXl);

  /// value is 72
  const PagePadding.onlyBottomHigh()
      : super.only(bottom: WidgetSizes.spacingXxl9);

  /// value is 16
  const PagePadding.onlyBottom() : super.only(bottom: WidgetSizes.spacingM);

  /// value is 10
  const PagePadding.onlyBottomLow()
      : super.only(bottom: WidgetSizes.spacingXsMid);

  /// value is 4
  const PagePadding.onlyBottomVeryLow()
      : super.only(bottom: WidgetSizes.spacingXxs);

  /// value is 2
  const PagePadding.onlyTopVeryLow() : super.only(top: WidgetSizes.spacingXSS);

  /// value is 4
  const PagePadding.onlyTopLow() : super.only(top: WidgetSizes.spacingXxs);

  /// value is 10
  const PagePadding.onlyTop() : super.only(top: WidgetSizes.spacingXsMid);

  /// value is 12
  const PagePadding.onlyTopMedium() : super.only(top: WidgetSizes.spacingS);

  /// value is 18
  const PagePadding.onlyTopNormalMedium()
      : super.only(top: WidgetSizes.spacingXxl3 / 2);

  /// value is 24
  const PagePadding.onlyTopNormal() : super.only(top: WidgetSizes.spacingXl);

  /// value is 30
  const PagePadding.onlyTopNormalX()
      : super.only(top: WidgetSizes.spacingXxl2 - WidgetSizes.spacingXSS);

  /// value is 36
  const PagePadding.onlyTopHigh() : super.only(top: WidgetSizes.spacingXxl3);

  /// value is 6
  const PagePadding.onlyRightVeryLow()
      : super.only(right: WidgetSizes.spacingXSs);

  /// value is 10
  const PagePadding.onlyRightLow()
      : super.only(right: WidgetSizes.spacingXsMid);

  /// value is 16
  const PagePadding.onlyRight() : super.only(right: WidgetSizes.spacingM);

  /// value is 20
  const PagePadding.onlyRightMedium() : super.only(right: WidgetSizes.spacingL);

  /// value is 24
  const PagePadding.onlyRightNormal()
      : super.only(right: WidgetSizes.spacingXl);

  /// value is 40
  const PagePadding.onlyRightHigh()
      : super.only(right: WidgetSizes.spacingXl + WidgetSizes.spacingM);

  /// horizontal value 10, vertical value 4
  const PagePadding.horizontalLowVerticalVeryLowSymmetric()
      : super.symmetric(
          horizontal: WidgetSizes.spacingXsMid,
          vertical: WidgetSizes.spacingXxs,
        );

  /// Left and right value 12, Top and bottom value 6
  const PagePadding.boxDesignLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingS,
          WidgetSizes.spacingXSs,
          WidgetSizes.spacingS,
          WidgetSizes.spacingXSs,
        );

  /// Left and Right = 20, Top = 18, Bottom = 2
  const PagePadding.boxWidgetDesignLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingL,
          WidgetSizes.spacingMx,
          WidgetSizes.spacingL,
          WidgetSizes.spacingXSS,
        );

  /// Left and right value 16, Top and bottom value 18
  const PagePadding.boxWidgetDesignVeryLowHorizontal()
      : super.fromLTRB(
          WidgetSizes.spacingM,
          WidgetSizes.spacingMx,
          WidgetSizes.spacingM,
          WidgetSizes.spacingMx,
        );

  /// Left = 20, Top = 18
  const PagePadding.boxPaddingLT()
      : super.only(
          left: WidgetSizes.spacingL,
          top: WidgetSizes.spacingMx,
        );
}

class PageMargin extends EdgeInsets {
  /// Left = 12, Top = 18
  const PageMargin.leftTopLow()
      : super.only(
          left: WidgetSizes.spacingS,
          top: WidgetSizes.spacingXxl3 / 2,
        );
}
