import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/mosaic_page/mixin/mosaic_collapsing_page_mixin.dart';
import 'package:lifeclient/product/widget/mosaic_page/view/style/mosaic_header_style.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

export 'style/mosaic_header_style.dart';

part 'widget/mosaic_collapsing_header.dart';
part 'widget/mosaic_header_card.dart';

final class MosaicCollapsingPage extends StatefulWidget {
  const MosaicCollapsingPage({
    required this.header,
    required this.slivers,
    this.headerStyle = const MosaicCollapsingHeaderStyle(),
    this.showLoeading = false,
    this.title,
    this.pinnedHeader,
    this.bottomNavigationBar, 
    super.key,
  });

  final Widget header;
  final List<Widget> slivers;
  final MosaicCollapsingHeaderStyle headerStyle;
  final bool showLoeading;
  final Widget? title;
  final Widget? pinnedHeader;
  final Widget? bottomNavigationBar; 

  @override
  State<MosaicCollapsingPage> createState() => _MosaicCollapsingPageState();
}

final class _MosaicCollapsingPageState extends State<MosaicCollapsingPage>
    with MosaicCollapsingPageMixin {
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: AppColors.bg,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: CustomScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          _MosaicCollapsingHeader(
            scrollController: scrollController,
            header: widget.header,
            style: widget.headerStyle,
            leading: widget.showLoeading ? const _BackButton() : null,
            title: widget.title,
          ),
          if (widget.pinnedHeader case final pinnedHeader?)
            PinnedHeaderSliver(child: pinnedHeader),
          SliverMainAxisGroup(
            slivers: widget.slivers,
          ),
        ],
      ),
    );
  }
}

final class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.pop,
      style: IconButton.styleFrom(
        foregroundColor: context.appColors.surface,
        backgroundColor: context.appColors.navy.withValues(alpha: .7),
      ),
      icon: const Icon(AppIcons.arrowBack),
    );
  }
}
