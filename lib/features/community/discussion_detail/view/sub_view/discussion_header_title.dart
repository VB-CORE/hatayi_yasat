part of '../discussion_detail_view.dart';

final class _DiscussionHeaderTitle extends StatelessWidget {
  const _DiscussionHeaderTitle({required this.args});

  final DiscussionDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentTitle(
          value: args.discussion.title,
          fontWeight: FontWeight.w700,
          maxLine: AppConstants.kTwo,
        ),
        GeneralContentSmallTitle(
          value: LocaleKeys.community_groupDetail_discussions_openedByGroup.tr(
            args: [args.discussion.author.maskedDisplayName, args.group.name],
          ),
          color: context.appColors.navy300,
          maxLine: AppConstants.kOne,
        ),
      ],
    );
  }
}
