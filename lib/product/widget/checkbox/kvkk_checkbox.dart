import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/checkbox/product_checkbox.dart';

class KvkkCheckBox extends StatelessWidget {
  const KvkkCheckBox({required this.onChanged, super.key});
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return ProductCheckbox(
      autovalidateMode: AutovalidateMode.always,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.general_kvkk.tr(),
              style: context.general.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorCommon(context).whiteAndBlackForTheme,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _navigate(context);
                },
            ),
            TextSpan(
              text: '  ${LocaleKeys.general_kvkkReadApproved.tr()}',
              style: context.general.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color:
                    ColorCommon(context).whiteAndBlackForTheme.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      onSaved: (value) {
        if (value == null) return;
        onChanged.call(value);
      },
      validator: (value) {
        return value != null && value == true
            ? null
            : LocaleKeys.validation_kvkk.tr();
      },
    );
  }

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: context.general.colorScheme.secondary,
              elevation: 1,
              iconTheme: IconThemeData(
                color: ColorCommon(context).whiteAndBlackForTheme,
              ),
            ),
            body: SfPdfViewer.asset(Assets.docs.kvkk),
          );
        },
      ),
    );
  }
}
