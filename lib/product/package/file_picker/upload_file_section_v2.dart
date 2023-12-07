import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/file_picker/file_extension_enum.dart';
import 'package:vbaseproject/product/package/file_picker/upload_file_v2_mixin.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

/// UploadFileSectionV2 is a widget used for
///  - uploading a file
///  - showing the name of the uploaded file
///
/// Params:
///  - [hintText] is the text that will be shown when no file is uploaded
///  - [onFilePicked] is the callback that will be called when a file is uploaded
///  - [allowedExtension] is the list of allowed extensions
final class UploadFileSectionV2 extends StatefulWidget {
  const UploadFileSectionV2({
    required this.hintText,
    required this.onFilePicked,
    this.allowedExtension,
    super.key,
  });

  final String hintText;
  final ValueSetter<File> onFilePicked;
  final List<FileExtensionEnum>? allowedExtension;

  @override
  State<UploadFileSectionV2> createState() => UploadFileSectionV2State();
}

class UploadFileSectionV2State extends State<UploadFileSectionV2>
    with UploadFileV2Mixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EmptyBox.smallWidth(),
        ValueListenableBuilder<File?>(
          valueListenable: documentFileNotifier,
          builder: (BuildContext context, File? file, Widget? _) => Expanded(
            child: isFilePicked(file)
                ? _UploadedFileText(
                    fileName: getNameOfFile(file!)!,
                    onPressed: () => showPdfFilePreview(file),
                  )
                : _HintText(hintText: widget.hintText),
          ),
        ),
        const EmptyBox.smallWidth(),
        ValueListenableBuilder(
          valueListenable: documentFileNotifier,
          builder: (BuildContext context, File? value, Widget? child) {
            return _UploadButton(
              isFileNotNull: isFilePicked(value),
              uploadPressed: pickFile,
            );
          },
        ),
      ],
    );
  }
}

@immutable
final class _UploadButton extends StatelessWidget {
  const _UploadButton({
    required this.isFileNotNull,
    required this.uploadPressed,
  });
  final bool isFileNotNull;
  final AsyncCallback uploadPressed;

  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.async(
      action: uploadPressed,
      label: isFileNotNull
          ? LocaleKeys.fileUpload_update.tr()
          : LocaleKeys.fileUpload_upload.tr(),
    );
  }
}

@immutable
final class _HintText extends StatelessWidget {
  const _HintText({
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Text(
      '*${hintText.tr()}',
      maxLines: AppConstants.kOne,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}

@immutable
final class _UploadedFileText extends StatelessWidget {
  const _UploadedFileText({
    required this.onPressed,
    required this.fileName,
  });

  final String fileName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        fileName,
        maxLines: AppConstants.kOne,
        overflow: TextOverflow.ellipsis,
        style: context.general.textTheme.titleMedium?.copyWith(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ),
    );
  }
}
