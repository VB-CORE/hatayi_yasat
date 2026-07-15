part of '../groups_view.dart';

final class _GroupsHeader extends StatelessWidget {
  const _GroupsHeader({required this.state});

  final GroupsState state;

  @override
  Widget build(BuildContext context) {
    final hasGroups =
        !state.isFetching && !state.isError && state.groups.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentSmallTitle(
          value: LocaleKeys.community_tagline.tr(),
          color: context.general.colorScheme.tertiary,
          fontWeight: FontWeight.w700,
        ),
        const EmptyBox.xSmallHeight(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: GeneralBigTitle(LocaleKeys.community_groups_title.tr()),
            ),
            if (hasGroups)
              GeneralContentSmallTitle(
                value: LocaleKeys.community_groups_groupCount.tr(
                  args: [state.groups.length.toString()],
                ),
                color: context.appColors.mutedText,
              ),
          ],
        ),
      ],
    );
  }
}
