import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/features/main/feed/widget/feed_events_list.dart';
import 'package:lifeclient/features/main/feed/widget/feed_news_list.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/post_model.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/repository/posts/posts_repository_provider.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/card/v2_post_card.dart';
import 'package:lifeclient/product/widget/general/v2_compose_prompt.dart';
import 'package:lifeclient/product/widget/general/v2_empty_state.dart';
import 'package:lifeclient/product/widget/general/v2_segment.dart';

enum FeedSegment { community, news, events }

/// Ana akış (Akış sekmesi). Topluluk segmenti gerçek `posts` koleksiyonunu
/// dinler; Haberler/Etkinlikler mevcut Firestore feedlerini kullanır.
class FeedView extends ConsumerStatefulWidget {
  const FeedView({
    super.key,
    this.cityId = 'hatay',
    this.initialSegment = FeedSegment.community,
    this.onCompose,
  });

  final String cityId;
  final FeedSegment initialSegment;
  final VoidCallback? onCompose;

  @override
  ConsumerState<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends ConsumerState<FeedView> {
  late FeedSegment _segment = widget.initialSegment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final city = V2SampleData.cityById(widget.cityId);
    return ColoredBox(
      color: colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: V2ComposePrompt(
              user: V2SampleData.me,
              placeholder: LocaleKeys.compose_placeholder.tr(),
              onTap: widget.onCompose,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(
                    LocaleKeys.feedV2_eyebrowWeekly.tr(
                      namedArgs: {'city': city.name},
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocaleKeys.feedV2_communityTitle.tr(),
                    style: V2Typography.display(
                      fontSize: 22,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  V2Segment<FeedSegment>(
                    items: [
                      V2SegmentItem(
                        value: FeedSegment.community,
                        label: LocaleKeys.feed_segmentTopluluk.tr(),
                        icon: Icons.diversity_3_rounded,
                      ),
                      V2SegmentItem(
                        value: FeedSegment.news,
                        label: LocaleKeys.feed_segmentHaberler.tr(),
                        icon: Icons.newspaper_rounded,
                      ),
                      V2SegmentItem(
                        value: FeedSegment.events,
                        label: LocaleKeys.feed_segmentEtkinlikler.tr(),
                        icon: Icons.event_rounded,
                      ),
                    ],
                    value: _segment,
                    onChanged: (v) => setState(() => _segment = v),
                  ),
                ],
              ),
            ),
          ),
          ..._buildSegmentSlivers(),
        ],
      ),
    );
  }

  List<Widget> _buildSegmentSlivers() {
    switch (_segment) {
      case FeedSegment.community:
        return [_CommunityFeedSliver(cityId: widget.cityId)];
      case FeedSegment.news:
        return [
          const SliverToBoxAdapter(child: FeedNewsList()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ];
      case FeedSegment.events:
        return [
          const SliverToBoxAdapter(child: FeedEventsList()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ];
    }
  }
}

class _CommunityFeedSliver extends ConsumerWidget {
  const _CommunityFeedSliver({required this.cityId});

  final String cityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(postsRepositoryProvider);
    return StreamBuilder<List<PostModel>>(
      stream: repo.watchFeed(cityId: cityId),
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
          return const SliverToBoxAdapter(child: V2EmptyState.feed());
        }
        return SliverList.builder(
          itemCount: posts.length,
          itemBuilder: (_, i) {
            final model = posts[i];
            return InkWell(
              onTap: () => PostDetailRoute(
                id: model.id,
                $extra: model,
              ).push<void>(context),
              child: V2PostCard(post: V2Post.fromModel(model)),
            );
          },
        );
      },
    );
  }
}
