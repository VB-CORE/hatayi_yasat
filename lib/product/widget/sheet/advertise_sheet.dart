import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';
import 'package:vbaseproject/product/widget/spacer/dynamic_horizontal_spacer.dart';

class AdvertiseSheet extends StatelessWidget {
  const AdvertiseSheet({required this.item, super.key});

  final AdvertiseModel item;
  static Future<AdvertiseModel?> show(
    BuildContext context, {
    required AdvertiseModel item,
  }) async {
    return showModalBottomSheet<AdvertiseModel>(
      context: context,
      useSafeArea: true,
      isScrollControlled: (item.description?.length ?? 0) > 100,
      builder: (context) {
        return AdvertiseSheet(item: item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.general.colorScheme.onInverseSurface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(
            WidgetSizes.spacingXl,
          ),
        ),
      ),
      padding: const PagePadding.all(),
      child: Column(
        children: [
          if (item.title.ext.isNotNullOrNoEmpty)
            Text(
              item.title!,
              style: context.general.textTheme.titleLarge?.copyWith(
                color: context.general.colorScheme.onBackground,
              ),
            ),
          const Divider(),
          _TextArea(
            header: LocaleKeys.advertise_description.tr(),
            content: item.description,
          ),
          const Divider(),
          _TextArea(
            header: LocaleKeys.advertise_gender.tr(),
            content: LocaleKeys.genders.tr(gender: item.gender.name),
          ),
          const Divider(),
          _TextArea(
            header: LocaleKeys.advertise_owner.tr(),
            content: item.owner,
          ),
          const Divider(),
          _TextArea(
            header: LocaleKeys.advertise_phone.tr(),
            content: item.phoneNumber,
          ),
          const Divider(),
          const Spacer(),
          _ActionButtons(item: item),
        ],
      ),
    );
  }
}

class _TextArea extends StatelessWidget {
  const _TextArea({required this.header, required this.content});
  final String header;
  final String? content;
  @override
  Widget build(BuildContext context) {
    if (content.ext.isNullOrEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: context.general.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.general.colorScheme.onBackground,
          ),
        ),
        const HorizontalSpace.standard(),
        Expanded(
          child: Text(
            content!,
            style: context.general.textTheme.bodyLarge?.copyWith(
              color: context.general.colorScheme.onBackground,
            ),
            textAlign: content!.length > 100 ? TextAlign.start : TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.item});
  final AdvertiseModel item;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ElevatedIconButton(
          onPressed: () async => _onPhoneCall(context),
          title: LocaleKeys.advertise_callPhone.tr(),
          icon: Icons.phone_outlined,
        ),
        _ElevatedIconButton(
          onPressed: () async => _onShare(context),
          title: LocaleKeys.advertise_share.tr(),
          icon: Icons.share_outlined,
        ),
      ],
    );
  }

  Future<void> _onPhoneCall(BuildContext context) async {
    if (item.phoneNumber.ext.isNullOrEmpty) return;
    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: item.phoneNumber!,
    );
  }

  Future<void> _onShare(BuildContext context) async {
    if (item.title.ext.isNullOrEmpty) return;
    await Share.share(
      '${LocaleKeys.advertise_message.tr()}'
      ' ${item.title}',
    );
  }
}

class _ElevatedIconButton extends StatelessWidget {
  const _ElevatedIconButton({
    required this.onPressed,
    required this.title,
    required this.icon,
  });
  final void Function() onPressed;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        title,
        style: TextStyle(
          color: context.general.colorScheme.onBackground,
        ),
      ),
      icon: Icon(
        icon,
        color: context.general.colorScheme.onBackground,
      ),
    );
  }
}
