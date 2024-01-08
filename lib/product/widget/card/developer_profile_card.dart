import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/decorations/custom_border_side.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class DeveloperProfileCard extends StatelessWidget {
  const DeveloperProfileCard({
    required this.model,
    super.key,
  });

  final DeveloperModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.githubUrl.ext.launchWebsite;
      },
      child: Card(
        color: Colors.transparent,
        shape: context.border.roundedRectangleAllBorderNormal
            .copyWith(side: CustomBorderSides.maxThick),
        elevation: 0,
        child: Padding(
          padding: context.padding.verticalLow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: FittedBox(child: _ProfileUserCard(model: model)),
              ),
              Text(
                model.name ?? '',
                style: context.general.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorCommon(context).whiteAndBlackForTheme,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const PagePadding.horizontalNormalSymmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        LocaleKeys.developers_seeProfileButtonText.tr(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.general.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          color: ColorCommon(context).whiteAndBlackForTheme,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileUserCard extends StatelessWidget {
  const _ProfileUserCard({
    required this.model,
  });

  final DeveloperModel model;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: model.image.ext.isNotNullOrNoEmpty
          ? NetworkImage(
              model.image!,
            )
          : null,
      child: model.image.ext.isNotNullOrNoEmpty
          ? null
          : Text(
              model.name?[0] ?? '',
            ),
    );
  }
}
