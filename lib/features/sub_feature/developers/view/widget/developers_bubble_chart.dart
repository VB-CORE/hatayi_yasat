import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/sub_feature/developers/view/widget/soft_arc_mosaic.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/widget/bubble/bubble_chart.dart';
import 'package:lifeclient/product/widget/bubble/bubble_data.dart';

@immutable
final class DevelopersBubbleChart extends StatelessWidget {
  const DevelopersBubbleChart({
    required this.developers,
    required this.headerText,
    super.key,
  });

  final List<DeveloperModel> developers;
  final String headerText;

  void _openProfile(DeveloperModel developer) {
    if (developer.githubUrl.ext.isNullOrEmpty) return;
    unawaited(developer.githubUrl.ext.launchWebsite);
  }

  List<BubbleData> get bubbles => developers
      .map(
        (e) => BubbleData(
          key: e.documentId,
          title: e.name?.shortDisplayName ?? '',
          imageUrl: e.image,
          onTap: () => _openProfile(e),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: .bottomCenter,
          child: SizedBox(
            height: context.sized.dynamicHeight(.25),
            child: const IgnorePointer(child: SoftArcMosaic()),
          ),
        ),
        BubbleChart(data: bubbles),
        Align(
          alignment: .topCenter,
          child: IgnorePointer(
            child: _DevelopersThanksHeader(text: headerText),
          ),
        ),
      ],
    );
  }
}

@immutable
final class DevelopersLogoWatermark extends StatelessWidget {
  const DevelopersLogoWatermark({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.sized.dynamicWidth(0.55);
    return Opacity(
      opacity: 0.12,
      child: Assets.icons.icApp.image(
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}

final class _DevelopersThanksHeader extends StatelessWidget {
  const _DevelopersThanksHeader({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.vertical12Symmetric(),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [AppColors.navy700, AppColors.coral600, AppColors.gold],
            stops: [0.0, 0.8, 1.0],
          ).createShader(bounds);
        },
        blendMode: .srcIn,
        child: Text(
          text,
          style: AppText.displayMd.copyWith(
            color: Colors.white,
            fontWeight: .w600,
          ),
          textAlign: .center,
        ),
      ),
    );
  }
}
