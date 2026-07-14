import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/constants/string_constants.dart';

/// Form alanı başlığı; [isRequired] ise yanına zorunluluk yıldızı ekler.
final class CustomTextFieldLabel extends StatelessWidget {
  const CustomTextFieldLabel({
    required this.labelText,
    this.isRequired = true,
    super.key,
  });

  final String labelText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$labelText ',
        style: context.general.textTheme.labelLarge?.copyWith(
          color: context.general.colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: isRequired ? StringConstants.asteriks : '',
            style: context.general.textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
