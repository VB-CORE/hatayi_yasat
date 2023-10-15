import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_mixin.dart';

final class UploadFileSectionWidget extends StatefulWidget {
  const UploadFileSectionWidget({
    required this.hintText,
    required this.onFilePicked,
    this.allowedExtension,
    super.key,
  });

  final String hintText;
  final ValueSetter<File> onFilePicked;
  final List<FileExtension>? allowedExtension;

  @override
  State<UploadFileSectionWidget> createState() =>
      UploadFileSectionWidgetState();
}

class UploadFileSectionWidgetState extends State<UploadFileSectionWidget>
    with UploadFileMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EmptyBox.smallWidth(),
        ValueListenableBuilder<File?>(
          valueListenable: documentFile,
          builder: (BuildContext context, File? file, Widget? _) => Expanded(
            child: isFileNull(file) || isFileNameNull(file!)
                ? _HintText(hintText: widget.hintText)
                : _UploadedFileText(
                    fileName: getNameOfFile(file)!,
                    onPressed: () => showPdfFilePreview(file),
                  ),
          ),
        ),
        const EmptyBox.smallWidth(),
        ValueListenableBuilder(
          valueListenable: documentFile,
          builder: (BuildContext context, File? value, Widget? child) {
            return _UploadButton(
              isFileNull: isFileNull(value),
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
  const _UploadButton({required this.isFileNull, required this.uploadPressed});
  final bool isFileNull;
  final VoidCallback uploadPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: uploadPressed,
      label: Text(
        isFileNull
            ? LocaleKeys.file_upload_upload
            : LocaleKeys.file_upload_update,
      ).tr(),
      icon: const Icon(
        Icons.upload_file,
      ),
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
      hintText.tr(),
      maxLines: AppConstants.kOne,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleMedium,
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
        ),
      ),
    );
  }
}
