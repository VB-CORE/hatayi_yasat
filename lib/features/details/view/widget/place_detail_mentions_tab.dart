part of '../place_detail_view.dart';

/// Bahsedilenler tab — streams posts that reference this place from the
/// posts repository and renders each via `V2PostCard`. Empty state uses
/// `V2EmptyState.search()` as a generic neutral fallback.
final class _PlaceDetailMentionsTab extends ConsumerWidget {
  const _PlaceDetailMentionsTab({required this.placeId});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(postsRepositoryProvider);
    return StreamBuilder<List<PostModel>>(
      stream: repo.watchForPlace(placeId),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final posts = snap.data ?? const <PostModel>[];
        if (posts.isEmpty) {
          return SliverToBoxAdapter(
            child: _MentionsEmpty(),
          );
        }
        return SliverList.builder(
          itemCount: posts.length,
          itemBuilder: (_, i) => V2PostCard(post: V2Post.fromModel(posts[i])),
        );
      },
    );
  }
}

final class _MentionsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
      child: Column(
        children: [
          Icon(
            Icons.forum_outlined,
            size: 40,
            color: colorScheme.onSecondaryFixed,
          ),
          const EmptyBox.smallHeight(),
          Text(
            LocaleKeys.placeDetailV2_noMentions.tr(),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryFixedVariant,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
