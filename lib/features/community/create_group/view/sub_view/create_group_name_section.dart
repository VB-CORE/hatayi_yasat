part of '../create_group_view.dart';

final class _NameSection extends StatelessWidget {
  const _NameSection({required this.controller});

  final TextEditingController controller;

  static const TextFieldMaxLengths _maxLength = TextFieldMaxLengths.medium;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldLabel(
          labelText: LocaleKeys.community_createGroup_nameLabel.tr(),
        ),
        const EmptyBox.smallHeight(),
        CustomTextFormField(
          hint: LocaleKeys.community_createGroup_nameHint.tr(),
          controller: controller,
          maxLength: _maxLength,
          validator: ValidatorNormalTextField(),
        ),
        const EmptyBox.xSmallHeight(),
        Row(
          children: [
            Expanded(
              child: GeneralContentSmallTitle(
                value: LocaleKeys.community_createGroup_nameHelper.tr(),
                color: AppColors.navy300,
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                return GeneralContentSmallTitle(
                  value: '${value.text.length}/${_maxLength.value}',
                  color: AppColors.navy300,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
