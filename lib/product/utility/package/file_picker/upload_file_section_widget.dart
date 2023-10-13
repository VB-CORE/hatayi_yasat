import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_mixin.dart';

class UploadFileSectionWidget extends StatefulWidget {
  const UploadFileSectionWidget({
    required this.hintText,
    required this.onFilePicked,
    super.key,
  });

  final String hintText;
  final ValueSetter<File> onFilePicked;

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
        Expanded(
          child: Text(
            getNameOfFile() ?? widget.hintText.tr(),
            maxLines: AppConstants.kOne,
            overflow: TextOverflow.ellipsis,
            style: context.general.textTheme.titleMedium,
          ),
        ),
        const EmptyBox.smallWidth(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: pickFile,
          label: Text(
            LocaleKeys.request_scholarship_upload.tr(),
          ),
          icon: const Icon(
            Icons.upload_file,
          ),
        ),
      ],
    );
  }
}
