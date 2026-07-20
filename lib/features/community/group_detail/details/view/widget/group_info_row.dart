import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupInfoRow extends StatelessWidget {
  const GroupInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final navy400 = context.appColors.navy400;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: AppIconSizes.xMedium, color: navy400),
        const EmptyBox(width: WidgetSizes.spacingS),
        GeneralContentSubTitle(value: label, color: navy400),
        const EmptyBox.smallWidth(),
        Expanded(
          child: GeneralContentSubTitle(
            value: value,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
