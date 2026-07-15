import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/sub_feature/unauthorized/mixin/unauthorized_view_mixin.dart';

part 'sub_view/unauthorized_action_buttons.dart';
part 'sub_view/unauthorized_attempted_path_chip.dart';
part 'sub_view/unauthorized_lock_icon.dart';

@immutable
final class UnauthorizedView extends ConsumerStatefulWidget {
  const UnauthorizedView({this.attemptedPath, super.key});

  final String? attemptedPath;

  @override
  ConsumerState<UnauthorizedView> createState() => _UnauthorizedViewState();
}

final class _UnauthorizedViewState extends ConsumerState<UnauthorizedView>
    with AppProviderMixin<UnauthorizedView>, UnauthorizedViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: context.appColors.darkSurface,
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
                    color: colorScheme.tertiary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: WidgetSizes.spacingXSSs,
                  ),
                ),
                const EmptyBox.smallHeight(),
                Text(
                  LocaleKeys.unauthorized_title.tr(),
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const EmptyBox.middleHeight(),
                GeneralContentSubTitle(
                  value: LocaleKeys.unauthorized_description.tr(),
                  textAlign: TextAlign.center,
                  color: colorScheme.onTertiary.withValues(alpha: 0.7),
                ),
                if (widget.attemptedPath case final path?) ...[
                  const EmptyBox.middleHeight(),
                  _AttemptedPathChip(path: path),
                ],
                const EmptyBox.largeXHeight(),
                _BackToGroupsButton(onPressed: backToGroups),
                const EmptyBox.smallHeight(),
                _RequestAccessButton(onPressed: requestAccess),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
