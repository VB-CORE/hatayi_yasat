import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GroupMemberAvatar extends StatelessWidget {
  const GroupMemberAvatar({
    required this.displayName,
    this.backgroundColor = AppColors.coral,
    this.singleLetter = false,
    super.key,
  });

  final String displayName;
  final Color backgroundColor;

  /// Tartışmalar gibi anonimleştirilmiş bağlamlarda tek harf göstermek için.
  final bool singleLetter;

  String get _initials {
    final parts = displayName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(singleLetter ? 1 : 2);
    if (parts.isEmpty) return '?';
    return parts.map((part) => part[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppIconSizes.medium,
      backgroundColor: backgroundColor,
      child: GeneralContentSmallTitle(
        value: _initials,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
