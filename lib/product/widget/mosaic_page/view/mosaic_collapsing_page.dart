import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/mosaic_page/mixin/mosaic_collapsing_page_mixin.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

part 'widget/mosaic_collapsing_header.dart';
part 'widget/mosaic_header_card.dart';

final class MosaicCollapsingHeaderStyle {
  const MosaicCollapsingHeaderStyle({
    this.heightFactor = .25,
    this.gradient,
    this.padding = const PagePadding.generalAllLow(),
  });

  final double heightFactor;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
}

final class MosaicCollapsingPage extends StatefulWidget {
  const MosaicCollapsingPage({
    required this.header,
    required this.content,
    this.headerStyle = const MosaicCollapsingHeaderStyle(),
    this.leading,
    this.pinnedHeader,
    this.contentPadding = const PagePadding.horizontalNormalSymmetric(),
    super.key,
  });

  final Widget header;
  final Widget content;
  final MosaicCollapsingHeaderStyle headerStyle;
  final Widget? leading;
  final Widget? pinnedHeader;
  final EdgeInsetsGeometry contentPadding;

  @override
  State<MosaicCollapsingPage> createState() => _MosaicCollapsingPageState();
}

final class _MosaicCollapsingPageState extends State<MosaicCollapsingPage>
    with MosaicCollapsingPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          _MosaicCollapsingHeader(
            scrollController: scrollController,
            header: widget.header,
            style: widget.headerStyle,
            leading: widget.leading,
          ),
          if (widget.pinnedHeader case final pinnedHeader?)
            PinnedHeaderSliver(child: pinnedHeader),
          SliverPadding(
            padding: widget.contentPadding.add(
              const EdgeInsets.only(bottom: AppSpacing.xxl),
            ),
            sliver: SliverToBoxAdapter(child: widget.content),
          ),
        ],
      ),
    );
  }
}
