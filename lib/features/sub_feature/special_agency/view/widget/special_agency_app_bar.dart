part of '../special_agency_view.dart';

final class _SpecialAgencyAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const _SpecialAgencyAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (institutionCount, townCount) = ref.watch(
      specialAgencyViewModelProvider.select((state) {
        final groups = state.townNamesAndAgency;
        final institutions = groups.values.fold<int>(
          0,
          (total, agencies) => total + agencies.length,
        );

        return (institutions, groups.length);
      }),
    );

    return DiscoverSectionAppBar(
      title: LocaleKeys.specialAgency_title,
      subtitle: LocaleKeys.specialAgency_subtitle.tr(
        args: [institutionCount.toString(), townCount.toString()],
      ),
      accentColor: context.appColors.navy,
    );
  }

  @override
  Size get preferredSize => DiscoverSectionAppBar.preferredAppBarSize;
}
