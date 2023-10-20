import 'package:flutter/material.dart';

class EmptyBox extends SizedBox {
  const EmptyBox({super.key, super.height, super.width});
  const EmptyBox.xxSmallHeight({super.key}) : super(height: 2);
  const EmptyBox.xSmallHeight({super.key}) : super(height: 4);
  const EmptyBox.smallHeight({super.key}) : super(height: 8);
  const EmptyBox.middleHeight({super.key}) : super(height: 16);
  const EmptyBox.largeHeight({super.key}) : super(height: 24);
  const EmptyBox.smallWidth({super.key}) : super(width: 8);
  const EmptyBox.middleWidth({super.key}) : super(width: 16);
  const EmptyBox.largeWidth({super.key}) : super(width: 24);
}
