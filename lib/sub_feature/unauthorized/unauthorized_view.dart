import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class UnauthorizedView extends ConsumerStatefulWidget {
  const UnauthorizedView({this.attemptedPath, super.key});

  final String? attemptedPath;

  @override
  ConsumerState<UnauthorizedView> createState() => _UnauthorizedViewState();
}

final class _UnauthorizedViewState extends ConsumerState<UnauthorizedView>
    with AppProviderMixin<UnauthorizedView> {
  static const double _descriptionOpacity = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy700,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const PagePadding.all(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _LockIcon(),
                const EmptyBox.largeHeight(),
                Text(
                  LocaleKeys.unauthorized_errorCode.tr(),
                  style: context.general.textTheme.labelMedium?.copyWith(
                    color: AppColors.coral,
                    fontWeight: FontWeight.w800,
                    letterSpacing: WidgetSizes.spacingXSSs,
                  ),
                ),
                const EmptyBox.smallHeight(),
                Text(
                  LocaleKeys.unauthorized_title.tr(),
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const EmptyBox.middleHeight(),
                GeneralContentSubTitle(
                  value: LocaleKeys.unauthorized_description.tr(),
                  textAlign: TextAlign.center,
                  color: AppColors.white.withValues(alpha: _descriptionOpacity),
                ),
                if (widget.attemptedPath case final path?) ...[
                  const EmptyBox.middleHeight(),
                  _AttemptedPathChip(path: path),
                ],
                const EmptyBox.largeXHeight(),
                _BackToGroupsButton(onPressed: _backToGroups),
                const EmptyBox.smallHeight(),
                _RequestAccessButton(onPressed: _requestAccess),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _backToGroups() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    const MainTabRoute().go(context);
  }

  // TODO(community): Yetki talep akışı tanımlanınca gerçek işlevle değişecek.
  void _requestAccess() {
    appProvider.showSnackbarMessage(
      LocaleKeys.unauthorized_requestAccessComingSoon.tr(),
    );
  }
}

final class _LockIcon extends StatelessWidget {
  const _LockIcon();

  static const double _backgroundOpacity = 0.15;
  static const double _borderOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllNormal(),
      decoration: BoxDecoration(
        color: AppColors.coral.withValues(alpha: _backgroundOpacity),
        borderRadius: CustomRadius.extraLarge,
        border: Border.all(
          color: AppColors.coral.withValues(alpha: _borderOpacity),
        ),
      ),
      child: const Icon(
        AppIcons.lockPerson,
        color: AppColors.coral,
        size: AppIconSizes.xLarge,
      ),
    );
  }
}

final class _AttemptedPathChip extends StatelessWidget {
  const _AttemptedPathChip({required this.path});

  final String path;

  static const double _borderOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: CustomRadius.xxLarge,
        border: Border.all(
          color: AppColors.navy300.withValues(alpha: _borderOpacity),
        ),
      ),
      child: Padding(
        padding: const PagePadding.boxDesignLowHorizontal(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              AppIcons.visibilityOff,
              size: AppIconSizes.xMedium,
              color: AppColors.navy300,
            ),
            const EmptyBox.smallWidth(),
            GeneralContentSmallTitle(
              value: path,
              color: AppColors.navy100,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

final class _BackToGroupsButton extends StatelessWidget {
  const _BackToGroupsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.navy700,
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.leftSelect),
        label: Text(
          LocaleKeys.unauthorized_backToGroups.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: AppColors.navy700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

final class _RequestAccessButton extends StatelessWidget {
  const _RequestAccessButton({required this.onPressed});

  final VoidCallback onPressed;

  static const double _borderOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.white.withValues(alpha: _borderOpacity),
          ),
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        child: Text(
          LocaleKeys.unauthorized_requestAccess.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
