import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/hero_tags.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
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
    with AppProviderMixin<UserQrView>, UserQrViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final qrSize = context.sized.dynamicWidth(QrImageConstants.sizeFactor);
    final embeddedSize = qrSize * QrImageConstants.embeddedSizeRatio;

    return GeneralScaffold(
      appBar: PageAppBar(
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
                    child: GeneralQrImage(data: qrData),
                  ),
                  Hero(
                    tag: HeroTags.userQrFab.name,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Assets.icons.icApp.image(
                        width: embeddedSize,
                        height: embeddedSize,
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
                      onPressed: qrData.isEmpty ? null : shareQrData,
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
