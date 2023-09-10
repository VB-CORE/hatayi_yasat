import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/firebase/developer_model.dart';

class DeveloperProfileCard extends StatelessWidget {
  const DeveloperProfileCard({
    required this.model,
    super.key,
  });

  final DeveloperModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(
              model.image ?? '',
            ),
          ),
          Padding(
            padding: context.padding.onlyTopNormal,
            child: Text(
              model.name ?? '',
              style: context.general.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () => model.githubUrl.ext.launchWebsite,
            child: Text(LocaleKeys.developers_seeProfileButtonText.tr()),
          ),
        ],
      ),
    );
  }
}
