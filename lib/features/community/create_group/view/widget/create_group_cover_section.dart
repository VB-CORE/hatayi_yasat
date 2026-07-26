part of '../create_group_view.dart';

final class _CoverSection extends StatelessWidget {
  const _CoverSection({required this.imageFile, required this.onTap});

  final File? imageFile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralBodySmallTitle(
          LocaleKeys.community_createGroup_coverImageLabel.tr(),
        ),
        const EmptyBox.smallHeight(),
        CoverImagePicker(imageFile: imageFile, onTap: onTap),
        const EmptyBox.smallHeight(),
        GeneralContentSmallTitle(
          value: LocaleKeys.community_createGroup_coverImageHint.tr(),
          color: context.appColors.navy400,
        ),
      ],
    );
  }
}
