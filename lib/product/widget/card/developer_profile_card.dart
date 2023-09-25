import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/size/index.dart';

class DeveloperProfileCard extends StatelessWidget {
  const DeveloperProfileCard({
    required this.model,
    super.key,
  });

  final DeveloperModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.padding.verticalLow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: WidgetSizes.spacingXxl5,
              backgroundImage: NetworkImage(
                model.image ?? '',
              ),
            ),
            Padding(
              padding: context.padding.onlyTopLow,
              child: Text(
                model.name ?? '',
                style: context.general.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => model.githubUrl.ext.launchWebsite,
              child: Text(LocaleKeys.developers_seeProfileButtonText.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
