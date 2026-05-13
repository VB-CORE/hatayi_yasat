import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// V2 notification list tile — typed icon badge (color-coded per
/// notification kind) + title + body + date.
///
/// The `_NotificationLeadingTile` keeps notification-type colour coding
/// (store=teal, campaign=coral, news=navy, advertise=gold, link=olive)
/// since the V2 design defines those tints as part of the notification
/// type identity, not as generic UI colour.
class V2NotificationTile extends StatelessWidget {
  const V2NotificationTile({
    required this.model,
    required this.onTap,
    super.key,
  });

  final AppNotificationModel model;
  final VoidCallback onTap;

  String? get _bodyText =>
      model.type == AppNotificationType.link ? model.title : model.body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Material(
      color: colorScheme.secondary,
      borderRadius: CustomRadius.large,
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomRadius.large,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.onPrimaryContainer),
            borderRadius: CustomRadius.large,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationLeadingTile(type: model.type),
              const EmptyBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _typeTitle(model.type),
                            style: textTheme.titleSmall?.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        if (model.createdAt != null)
                          Text(
                            DateFormat.yMMMMd().format(model.createdAt!),
                            style: V2Typography.label(
                              fontSize: 11,
                              color: colorScheme.onSecondaryFixed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    const EmptyBox.xSmallHeight(),
                    if (_bodyText?.isNotEmpty ?? false)
                      Text(
                        _bodyText!,
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12.5,
                          height: 1.45,
                          color: colorScheme.onPrimaryFixedVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeTitle(AppNotificationType? type) {
    if (type == null) return '';
    return switch (type) {
      AppNotificationType.store => LocaleKeys.notifications_typeStore.tr(),
      AppNotificationType.campaign =>
        LocaleKeys.notifications_typeCampaign.tr(),
      AppNotificationType.news => LocaleKeys.notifications_typeNews.tr(),
      AppNotificationType.advertise =>
        LocaleKeys.notifications_typeAdvertise.tr(),
      AppNotificationType.link => LocaleKeys.notifications_typeLink.tr(),
    };
  }
}

class _NotificationLeadingTile extends StatelessWidget {
  const _NotificationLeadingTile({required this.type});

  final AppNotificationType? type;

  /// Notification-kind colour pair. The tinted bg + tint colour are
  /// part of the V2 design's notification-type identity, so we read
  /// raw brand tokens here rather than mapping to theme roles.
  ({Color bg, Color tint, IconData icon}) get _spec {
    switch (type) {
      case AppNotificationType.store:
        return (
          bg: ColorsCustom.teal50,
          tint: ColorsCustom.teal,
          icon: Icons.storefront_rounded,
        );
      case AppNotificationType.campaign:
        return (
          bg: ColorsCustom.coral.withValues(alpha: 0.12),
          tint: ColorsCustom.coral,
          icon: Icons.campaign_rounded,
        );
      case AppNotificationType.news:
        return (
          bg: ColorsCustom.navy50,
          tint: ColorsCustom.navy,
          icon: Icons.newspaper_rounded,
        );
      case AppNotificationType.advertise:
        return (
          bg: ColorsCustom.gold.withValues(alpha: 0.18),
          tint: ColorsCustom.gold,
          icon: Icons.notifications_active_rounded,
        );
      case AppNotificationType.link:
        return (
          bg: ColorsCustom.olive50,
          tint: ColorsCustom.olive600,
          icon: Icons.link_rounded,
        );
      case null:
        return (
          bg: ColorsCustom.ink50,
          tint: ColorsCustom.ink400,
          icon: Icons.notifications_none_rounded,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spec = _spec;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: spec.bg,
        borderRadius: CustomRadius.medium,
      ),
      child: Icon(spec.icon, color: spec.tint, size: 20),
    );
  }
}
