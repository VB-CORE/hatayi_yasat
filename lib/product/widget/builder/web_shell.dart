import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/router_notifier.dart';
import 'package:lifeclient/product/utility/constants/app_breakpoints.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/builder/web_layout_scope.dart';
import 'package:lifeclient/product/widget/builder/web_sidebar/web_sidebar.dart';
import 'package:lifeclient/product/widget/builder/web_sidebar_transition.dart';

@immutable
final class WebShell extends ConsumerStatefulWidget {
  const WebShell({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<WebShell> createState() => _WebShellState();
}

final class _WebShellState extends ConsumerState<WebShell>
    with SingleTickerProviderStateMixin {
  /// Splash, onboarding and login paint the same mosaic inside the card; the
  /// backdrop stays a faint watermark so the two never blend.
  static const double _backdropTileOpacity = .06;

  /// Outlines the dark screens (splash, onboarding) against the dark backdrop.
  static const double _cardOutlineOpacity = .12;

  late final GoRouterDelegate _routerDelegate;
  late final AnimationController _sidebarController = AnimationController(
    vsync: this,
    duration: Durations.extralong4,
    reverseDuration: Durations.long4,
  );
  String _location = '';
  bool _isSidebarVisible = false;

  @override
  void initState() {
    super.initState();
    _routerDelegate = ref.read(goRouterProvider).routerDelegate
      ..addListener(_onRouteChanged);
    _location = _routerDelegate.currentConfiguration.uri.path;
  }

  @override
  void dispose() {
    _routerDelegate.removeListener(_onRouteChanged);
    _sidebarController.dispose();
    super.dispose();
  }

  /// The delegate also notifies while the router is mounting inside this
  /// widget's subtree, where a rebuild is not allowed yet.
  void _onRouteChanged() {
    WidgetsBinding.instance
      ..addPostFrameCallback((_) {
        final location = _routerDelegate.currentConfiguration.uri.path;
        if (!mounted || location == _location) return;
        setState(() => _location = location);
      })
      ..ensureVisualUpdate();
  }

  /// Runs after the frame: starting the controller notifies its builders,
  /// which cannot be marked dirty while this widget is building.
  void _syncSidebar({required bool isVisible}) {
    if (isVisible == _isSidebarVisible) return;
    _isSidebarVisible = isVisible;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || isVisible != _isSidebarVisible) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _sidebarController.value = isVisible ? 1 : 0;
        return;
      }
      unawaited(
        isVisible ? _sidebarController.forward() : _sidebarController.reverse(),
      );
    });
  }

  /// Every branch below only swaps parameters, never the shape of the tree:
  /// a reparented router re-parses the route and pages that need `$extra`
  /// crash with null.
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isFramed = media.size.width > AppBreakpoints.webShell;
    final hasSidebar =
        media.size.width > AppBreakpoints.webSidebar &&
        _location.startsWith(const MainTabRoute().location);
    _syncSidebar(isVisible: hasSidebar);

    return Stack(
      children: [
        Positioned.fill(
          child: isFramed
              ? MosaicBackground(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [context.appColors.navy, context.appColors.navy900],
                  ),
                  tileOpacity: _backdropTileOpacity,
                )
              : const SizedBox.shrink(),
        ),
        Center(
          child: Padding(
            padding: isFramed
                ? const PagePadding.verticalNormalSymmetric()
                : EdgeInsets.zero,
            child: WebSidebarTransition(
              animation: _sidebarController,
              cardWidth: isFramed ? AppBreakpoints.webShell : null,
              surfaceColor: context.general.appTheme.scaffoldBackgroundColor,
              isSidebarRequested: hasSidebar,
              sidebar: WebSidebar(location: _location),
              card: DecoratedBox(
                decoration: isFramed
                    ? BoxDecoration(
                        color: context.general.appTheme.scaffoldBackgroundColor,
                        borderRadius: CustomRadius.extraLarge,
                        boxShadow: [
                          BoxShadow(
                            color: context.general.colorScheme.shadow
                                .withValues(alpha: .35),
                            blurRadius: WidgetSizes.spacingXxl2,
                            offset: const Offset(kZero, WidgetSizes.spacingS),
                          ),
                        ],
                      )
                    : const BoxDecoration(),
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: isFramed
                      ? BoxDecoration(
                          borderRadius: CustomRadius.extraLarge,
                          border: Border.all(
                            color: context.appColors.white.withValues(
                              alpha: _cardOutlineOpacity,
                            ),
                          ),
                        )
                      : const BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: isFramed
                        ? CustomRadius.extraLarge
                        : BorderRadius.zero,
                    child: LayoutBuilder(
                      builder: (context, constraints) => MediaQuery(
                        data: media.copyWith(size: constraints.biggest),
                        child: WebLayoutScope(
                          isSidebarVisible: hasSidebar,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
