import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/box_decorations.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_vertical_spacer.dart';

class UploadShelterButton extends StatelessWidget {
  const UploadShelterButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const PagePadding.allNormal(),
        decoration: _buildDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIcon(context),
            const VerticalSpace.xSmall(),
            _buildText(context),
          ],
        ),
      ),
    );
  }

  Text _buildText(BuildContext context) {
    return Text(
      LocaleKeys.uploadShelter_title.tr(),
      textAlign: TextAlign.center,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: context.general.colorScheme.outlineVariant,
      ),
    );
  }

  Icon _buildIcon(BuildContext context) {
    return Icon(
      Icons.upload_rounded,
      color: context.general.colorScheme.outlineVariant,
    );
  }

  BoxDecorations _buildDecoration(BuildContext context) {
    return BoxDecorations.circularMedium(
      borderColor: context.general.colorScheme.outlineVariant,
    );
  }
}
