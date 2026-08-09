import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/widget/general/index.dart';

/// Kenarlıklı bir kart içinde açılır-kapanır grup başlığı: solda isteğe bağlı
/// ikon, iki satırlık başlık ve dönen chevron.
@immutable
final class GeneralExpansionTile extends StatelessWidget {
  const GeneralExpansionTile({
    required this.title,
    required this.children,
    this.subtitle,
    this.leadingIcon,
    this.initiallyExpanded = false,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final String? subtitle;
  final IconData? leadingIcon;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final icon = leadingIcon;
    final secondary = subtitle;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: BorderSide(color: context.appColors.ink100),
    );

    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        shape: shape,
        collapsedShape: shape,
        backgroundColor: context.appColors.surface,
        collapsedBackgroundColor: context.appColors.surface,
        tilePadding: const PagePadding.generalAllLow(),
        childrenPadding: EdgeInsets.zero,
        minTileHeight: WidgetSizes.zero,
        iconColor: context.appColors.ink300,
        collapsedIconColor: context.appColors.ink300,
        leading: icon == null
            ? null
            : Icon(icon, color: context.appColors.navy),
        title: GeneralBodyTitle(title, textAlign: TextAlign.start),
        subtitle: secondary == null
            ? null
            : GeneralContentSmallTitle(value: secondary),
        children: children,
      ),
    );
  }
}
