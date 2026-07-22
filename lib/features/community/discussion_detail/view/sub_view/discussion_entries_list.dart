part of '../discussion_detail_view.dart';

final class _EntriesList extends StatelessWidget {
  const _EntriesList({required this.state, required this.scrollController});

  final DiscussionDetailState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      DiscussionDetailState(isFetching: true) => const SizedBox.shrink(),
      DiscussionDetailState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
        ),
      ),
      DiscussionDetailState(:final entries) => ListView.separated(
        controller: scrollController,
        padding: const PagePadding.horizontal16Symmetric(),
        itemCount: entries.length,
        separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
        itemBuilder: (context, index) =>
            DiscussionEntryTile(model: entries[index]),
      ),
    };
  }
}
