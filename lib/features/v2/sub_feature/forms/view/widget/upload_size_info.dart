part of '../scholarship_request_form.dart';

@immutable
final class _UploadSizeInfo extends StatelessWidget {
  const _UploadSizeInfo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppConstants.kFour.toDouble(),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(AppIcons.info),
        GeneralLargeLabel(
          LocaleKeys.requestScholarship_error_fileSizeInfo.tr(
            args: ['${FileSizes.small.kbValue} ${AppConstants.kiloByte}'],
          ),
        ),
      ],
    );
  }
}
