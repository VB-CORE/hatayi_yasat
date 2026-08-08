import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/hero_tags.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/qr_image/qr_image_constants.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_horizontal_spacer.dart';

part 'widget/user_qr_info_row.dart';

final class UserQrView extends ConsumerStatefulWidget {
  const UserQrView({super.key});

  @override
  ConsumerState<UserQrView> createState() => _UserQrViewState();
}

class _UserQrViewState extends ConsumerState<UserQrView>
    with ProjectDependencyMixin, UserQrViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final qrUrl = userQrUrl;

    if (qrUrl == null) {
      return GeneralScaffold(
        appBar: const PageAppBar(pageTitle: LocaleKeys.userQr_title),
        body: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
        ),
      );
    }

    final placeHolderSize =
        context.sized.dynamicWidth(QrImageConstants.sizeFactor) *
        QrImageConstants.embeddedSizeRatio;

    return GeneralScaffold(
      appBar: const PageAppBar(
        pageTitle: LocaleKeys.userQr_title,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const PagePadding.all(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isQrVisibleNotifier,
                    builder: (context, isVisible, child) {
                      return AnimatedOpacity(
                        opacity: isVisible ? 1 : 0,
                        duration: DurationConstant.durationLow,
                        child: child,
                      );
                    },
                    child: GeneralQrImage(data: qrUrl),
                  ),
                  Hero(
                    tag: HeroTags.userQrFab.name,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Assets.icons.icApp.image(
                        width: placeHolderSize,
                        height: placeHolderSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              const EmptyBox.middleHeight(),
              Container(
                width: double.infinity,
                padding: const PagePadding.allVeryLow(),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: CustomRadius.large,
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    _UserQrInfoRow(
                      icon: AppIcons.verifiedUser,
                      title: LocaleKeys.userQr_personalTitle.tr(),
                      description: LocaleKeys.userQr_personalDescription.tr(),
                    ),
                    Divider(
                      height: WidgetSizes.spacingXxl,
                      color: colorScheme.outline,
                    ),
                    _UserQrInfoRow(
                      icon: AppIcons.discount,
                      title: LocaleKeys.userQr_campaignTitle.tr(),
                      description: LocaleKeys.userQr_campaignDescription.tr(),
                    ),
                  ],
                ),
              ),
              const EmptyBox.middleHeight(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: qrUrl.isEmpty ? null : shareQrUrl,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.tertiary,
                        foregroundColor: colorScheme.onTertiary,
                      ),
                      icon: const Icon(AppIcons.share),
                      label: Text(LocaleKeys.button_share.tr()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
