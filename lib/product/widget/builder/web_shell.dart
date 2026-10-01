import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/utility/constants/app_breakpoints.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';

@immutable
final class WebShell extends StatelessWidget {
  const WebShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isFramed = media.size.width > AppBreakpoints.webShell;

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
                )
              : const SizedBox.shrink(),
        ),
        Center(
          child: Padding(
            padding: isFramed
                ? const PagePadding.verticalNormalSymmetric()
                : EdgeInsets.zero,
            child: SizedBox(
              width: isFramed ? AppBreakpoints.webShell : double.infinity,
              child: DecoratedBox(
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
                child: ClipRRect(
                  borderRadius: isFramed
                      ? CustomRadius.extraLarge
                      : BorderRadius.zero,
                  child: LayoutBuilder(
                    builder: (context, constraints) => MediaQuery(
                      data: media.copyWith(size: constraints.biggest),
                      child: child,
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
