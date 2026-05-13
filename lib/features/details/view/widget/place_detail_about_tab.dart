part of '../place_detail_view.dart';

/// Hakkında tab — description paragraph, info rows (phone / hours /
/// address / owner), and the transit grid with placeholder estimates.
final class _PlaceDetailAboutTab extends StatelessWidget {
  const _PlaceDetailAboutTab({
    required this.model,
    required this.onCall,
  });

  final StoreModel model;
  final Future<void> Function() onCall;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(LocaleKeys.placeDetailV2_aboutEyebrow.tr()),
                const EmptyBox.smallHeight(),
                Text(
                  model.description ?? '—',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryFixedVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const EmptyBox.smallHeight(),
          _Section(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _InfoRows(model: model, onCall: onCall),
          ),
          const EmptyBox.smallHeight(),
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(LocaleKeys.placeDetailV2_transitEyebrow.tr()),
                const EmptyBox.middleHeight(),
                Row(
                  children: [
                    Expanded(
                      child: _TransitOption(
                        icon: Icons.directions_walk_rounded,
                        label: LocaleKeys.placeDetailV2_transitWalk.tr(),
                        value: '6 dk',
                      ),
                    ),
                    const EmptyBox(width: 6),
                    Expanded(
                      child: _TransitOption(
                        icon: Icons.directions_car_rounded,
                        label: LocaleKeys.placeDetailV2_transitCar.tr(),
                        value: '2 dk',
                      ),
                    ),
                    const EmptyBox(width: 6),
                    Expanded(
                      child: _TransitOption(
                        icon: Icons.directions_bus_rounded,
                        label: LocaleKeys.placeDetailV2_transitBus.tr(),
                        value: '12 dk',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _Section extends StatelessWidget {
  const _Section({required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        border: Border.all(color: colorScheme.onPrimaryContainer, width: 0.5),
      ),
      child: child,
    );
  }
}

final class _InfoRows extends StatelessWidget {
  const _InfoRows({required this.model, required this.onCall});

  final StoreModel model;
  final Future<void> Function() onCall;

  @override
  Widget build(BuildContext context) {
    final phone = model.phone.isEmpty ? '+90 ___ ___ __ __' : model.phone;
    final hours = model.hoursLabel.isEmpty ? '—' : model.hoursLabel;
    final address = model.address ?? '—';
    return Column(
      children: [
        V2InfoRow(
          icon: Icons.phone_outlined,
          label: LocaleKeys.placeDetailV2_infoPhoneLabel.tr(),
          value: phone,
          actionLabel: LocaleKeys.placeDetailV2_actionCall.tr(),
          onAction: () => onCall(),
        ),
        V2InfoRow(
          icon: Icons.schedule_rounded,
          label: LocaleKeys.placeDetailV2_infoHoursLabel.tr(),
          value: hours,
        ),
        V2InfoRow(
          icon: Icons.location_on_outlined,
          label: LocaleKeys.placeDetailV2_infoAddressLabel.tr(),
          value: address,
          multiline: true,
          actionLabel: LocaleKeys.placeDetailV2_actionCopy.tr(),
          onAction: () => _copyAddress(context, address),
        ),
        if (model.owner.isNotEmpty)
          V2InfoRow(
            icon: Icons.badge_outlined,
            label: LocaleKeys.placeDetailV2_infoOwnerLabel.tr(),
            value: model.owner,
          ),
      ],
    );
  }

  Future<void> _copyAddress(BuildContext context, String address) async {
    await Clipboard.setData(ClipboardData(text: address));
    if (!context.mounted) return;
    final colorScheme = context.general.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primaryContainer,
        content: Text(LocaleKeys.placeDetailV2_addressCopied.tr()),
      ),
    );
  }
}
