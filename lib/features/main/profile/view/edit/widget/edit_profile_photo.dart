import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/model/auth/user/avatar_types.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

final class EditProfilePhoto extends StatelessWidget {
  const EditProfilePhoto({
    required this.avatarType,
    required this.onSelect,
    super.key,
  });

  final String avatarType;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final radius = context.sized.dynamicWidth(0.09);
    final types = AvatarTypes.all;

    return SizedBox(
      height: radius * 2 + WidgetSizes.spacingM,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (context, index) => const EmptyBox.smallWidth(),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = type.name == avatarType;
          return GestureDetector(
            onTap: () => onSelect(type.name),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.coral : AppColors.navy200,
                  width: isSelected
                      ? WidgetSizes.spacingXSs
                      : WidgetSizes.spacingXSS,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(WidgetSizes.spacingXSs),
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: AssetImage(type.path),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
