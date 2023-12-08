part of '../scholarship_request_form.dart';

@immutable
final class _UploadSizeInfo extends StatelessWidget {
  const _UploadSizeInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppConstants.kFour.toDouble(),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(Icons.info_outline),
        Text(
          LocaleKeys.requestScholarship_error_fileSizeInfo.tr(
            args: ['${FileSizes.small.kbValue} ${AppConstants.kiloByte}'],
          ),
          style: context.general.textTheme.labelLarge,
        ),
      ],
    );
  }
}
