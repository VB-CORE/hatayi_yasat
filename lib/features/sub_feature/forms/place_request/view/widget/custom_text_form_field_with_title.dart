part of '../place_request_form.dart';

final class CustomTextFormFieldWithTitle extends StatelessWidget {
  const CustomTextFormFieldWithTitle({
    required this.title,
    required this.controller,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength = TextFieldMaxLengths.none,
    this.formatters = TextFieldFormatters.none,
    this.autoFills = TextFieldAutoFills.normal,
    super.key,
  }) : _isMultiLine = false;

  const CustomTextFormFieldWithTitle.multiLine({
    required this.title,
    required this.controller,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength = TextFieldMaxLengths.none,
    this.formatters = TextFieldFormatters.none,
    this.autoFills = TextFieldAutoFills.normal,
    super.key,
  }) : _isMultiLine = true;

  final String title;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextFieldMaxLengths maxLength;
  final TextFieldFormatters formatters;
  final ValidatorField validator;
  final TextFieldAutoFills autoFills;
  final bool _isMultiLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralBodySmallTitle(
          title,
          fontWeight: FontWeight.w500,
          color: context.general.colorScheme.onPrimaryFixedVariant,
        ),
        const EmptyBox.smallHeight(),
        if (_isMultiLine)
          CustomTextFormMultiField(
            hint: '',
            maxLength: maxLength,
            controller: controller,
            textInputType: textInputType,
            validator: validator,
            formatters: formatters,
            autoFills: autoFills,
          )
        else
          CustomTextFormField(
            hint: '',
            controller: controller,
            textInputType: textInputType,
            validator: validator,
            formatters: formatters,
          ),
      ],
    );
  }
}
