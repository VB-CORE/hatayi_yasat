part of '../create_group_view.dart';

final class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralBodySmallTitle(
          LocaleKeys.community_createGroup_descriptionLabel.tr(),
        ),
        const EmptyBox.smallHeight(),
        CustomTextFormMultiField(
          hint: LocaleKeys.community_createGroup_descriptionHint.tr(),
          controller: controller,
          maxLength: TextFieldMaxLengths.veryLarge,
          validator: ValidatorOptionalTextField(),
        ),
      ],
    );
  }
}
