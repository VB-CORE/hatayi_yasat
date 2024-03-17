import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/style/button_rectangle_border.dart';
import 'package:lifeclient/product/utility/uri/uri_utility.dart';
import 'package:lifeclient/product/widget/scrollbar/product_scroll_bar.dart';

final class LinkDetailView extends StatelessWidget {
  const LinkDetailView({required this.model, super.key});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorCommon.sameWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Title(model: model),
          const _Divider(),
          _Body(model: model),
          const _Divider(),
          _LinkAndShare(model: model),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required AppNotificationModel model,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: ColorCommon.sameWhiteColor,
      constraints: BoxConstraints(
        maxHeight: context.sized.dynamicHeight(.8),
      ),
      shape: const CustomBottomSheetBorder(),
      builder: (context) => LinkDetailView(model: model),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: AppConstants.kOne.toDouble());
  }
}

final class _Title extends StatelessWidget {
  const _Title({required this.model});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalAllNormal(),
      child: Text(
        model.title ?? '',
        style: context.general.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

final class _Body extends StatelessWidget {
  const _Body({required this.model});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const PagePadding.onlyRightLow(),
        child: ProductScrollBar(
          child: SingleChildScrollView(
            padding: const PagePadding.all(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.body ?? '',
                  style: context.general.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _LinkAndShare extends StatelessWidget {
  const _LinkAndShare({required this.model});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.general.colorScheme.secondary,
      contentPadding: const PagePadding.horizontalSymmetric() +
          const PagePadding.verticalLowSymmetric() +
          const PagePadding.onlyBottomLow(),
      onTap: () => model.id.ext.launchWebsite,
      title: _Link(model: model),
      trailing: _Share(model: model),
    );
  }
}

final class _Share extends StatelessWidget {
  const _Share({required this.model});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => model.id.ext.share(),
      child: Icon(
        AppIcons.share,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}

final class _Link extends StatelessWidget {
  const _Link({required this.model});

  final AppNotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Text(
      model.id,
      maxLines: AppConstants.kOne,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        color: context.general.colorScheme.onSecondaryContainer,
      ),
    );
  }
}
