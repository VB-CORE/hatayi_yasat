import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_horizontal_spacer.dart';

part 'widget/user_qr_info_row.dart';

final class UserQrView extends StatefulWidget {
  const UserQrView({super.key});

  @override
  State<UserQrView> createState() => _UserQrViewState();
}

class _UserQrViewState extends State<UserQrView>
    with ProjectDependencyMixin, UserQrViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;

    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.userQr_title,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const PagePadding.all(),
          child: Column(
            children: [
              const GeneralQrImage(data: UserQrViewMixin.userQrUrl),
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
                      onPressed: copyQrUrl,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.tertiary,
                        foregroundColor: colorScheme.onTertiary,
                      ),
                      icon: const Icon(AppIcons.copy),
                      label: Text(LocaleKeys.button_copy.tr()),
                    ),
                  ),
                  const HorizontalSpace.xSmall(),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: shareQrUrl,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colorScheme.surface,
                        foregroundColor: colorScheme.primary,
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
