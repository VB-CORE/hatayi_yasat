import 'package:flutter/material.dart';
import 'package:vbaseproject/product/model/enum/text_field/index.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';

mixin CustomTextFieldModel {
  String get hint;
  TextEditingController get controller;
  TextInputType get textInputType;
  TextFieldMaxLengths get maxLength;
  TextFieldFormatters get formatters;
  ValidatorField get validator;
  TextFieldAutoFills get autoFills;
  TextInputAction get textInputAction;
}
