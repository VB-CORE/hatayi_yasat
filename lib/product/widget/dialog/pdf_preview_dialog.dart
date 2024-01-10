import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/dialog/force_update_dialog.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/general_dialog_button.dart';

/// PdfPreviewDialogV2 is a dialog used for
/// - showing a pdf file
/// Params:
/// - [file] is the file that will be shown
@immutable
final class PdfPreviewDialog extends StatelessWidget with CustomDialog {
  const PdfPreviewDialog({required this.file, super.key});
  final File file;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const PagePadding.allLow(),
      shape: RoundedRectangleBorder(
        borderRadius: context.border.lowBorderRadius,
      ),
      title: SizedBox(
        height: context.sized.height * 0.6,
        child: SfPdfViewer.file(file),
      ),
      actions: [
        GeneralDialogButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: LocaleKeys.button_close.tr(),
        ),
      ],
    );
  }

  @override
  Future<void> show(BuildContext context) {
    return showNormalDialog(context, barrierDismissible: true);
  }
}
