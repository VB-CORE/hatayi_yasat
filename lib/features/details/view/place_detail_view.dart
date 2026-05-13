import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/details/mixin/place_detail_view_mixin.dart';
import 'package:lifeclient/features/details/view/widget/review_composer_sheet.dart';
import 'package:lifeclient/features/details/view_model/place_detail_view_model.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/post_model.dart';
import 'package:lifeclient/product/model/social/review_model.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/model/social/store_display_x.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/repository/posts/posts_repository_provider.dart';
import 'package:lifeclient/product/repository/reviews/reviews_repository_provider.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
import 'package:lifeclient/product/widget/brand/status_pill.dart';
import 'package:lifeclient/product/widget/card/v2_post_card.dart';
import 'package:lifeclient/product/widget/card/v2_review_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/v2_segment.dart';
import 'package:lifeclient/product/widget/list_tile/v2_info_row.dart';

part 'widget/place_detail_action_buttons.dart';
part 'widget/place_detail_hero.dart';
part 'widget/place_detail_header_card.dart';
part 'widget/place_detail_about_tab.dart';
part 'widget/place_detail_mentions_tab.dart';
part 'widget/place_detail_reviews_tab.dart';
part 'widget/place_detail_transit_option.dart';

enum _PlaceDetailTab { about, mentions, reviews }

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({required this.model, required this.id, super.key});
  final StoreModel model;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with AppProviderMixin<PlaceDetailView>, PlaceDetailViewMixin {
  _PlaceDetailTab _tab = _PlaceDetailTab.about;

  void _onTabChanged(_PlaceDetailTab value) {
    setState(() => _tab = value);
  }

  Future<void> _onWriteReview() async {
    await showV2ReviewComposerSheet(context, placeId: model.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeDetailViewModelProvider);
    final colorScheme = context.general.colorScheme;

    if (state.isError) {
      return Scaffold(
        appBar: AppBar(),
        body: GeneralNotFoundWidget(
          title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
        ),
      );
    }

    if (model.documentId.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final placeId = model.documentId;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          key: const Key('placeDetailScrollView'),
          slivers: [
            SliverToBoxAdapter(
              child: _PlaceDetailHero(model: model),
            ),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -32),
                child: _PlaceDetailHeaderCard(
                  model: model,
                  onCall: callAction,
                  onDirections: findThePlaceAction,
                  onWriteReview: _onWriteReview,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _TabsSection(
                tab: _tab,
                placeId: placeId,
                onChanged: _onTabChanged,
              ),
            ),
            if (_tab == _PlaceDetailTab.about)
              SliverToBoxAdapter(
                child: _PlaceDetailAboutTab(
                  model: model,
                  onCall: callAction,
                ),
              )
            else if (_tab == _PlaceDetailTab.mentions)
              _PlaceDetailMentionsTab(placeId: placeId)
            else
              _PlaceDetailReviewsTab(
                placeId: placeId,
                onWriteReview: _onWriteReview,
              ),
            const SliverToBoxAdapter(child: EmptyBox.largeXxHeight()),
          ],
        ),
      ),
      floatingActionButton: _tab == _PlaceDetailTab.reviews
          ? FloatingActionButton.extended(
              key: const Key('placeDetailWriteReviewFab'),
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onPrimary,
              icon: const Icon(Icons.rate_review_rounded, size: 18),
              label: Text(
                LocaleKeys.placeDetailV2_writeReview.tr(),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              onPressed: _onWriteReview,
            )
          : null,
    );
  }
}

final class _TabsSection extends ConsumerWidget {
  const _TabsSection({
    required this.tab,
    required this.placeId,
    required this.onChanged,
  });

  final _PlaceDetailTab tab;
  final String placeId;
  final ValueChanged<_PlaceDetailTab> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentionsStream = ref
        .watch(postsRepositoryProvider)
        .watchForPlace(placeId);
    final reviewsStream = ref
        .watch(reviewsRepositoryProvider)
        .watchForPlace(placeId);

    return StreamBuilder<List<PostModel>>(
      stream: mentionsStream,
      builder: (context, postsSnap) {
        return StreamBuilder<List<ReviewModel>>(
          stream: reviewsStream,
          builder: (context, reviewsSnap) {
            final postCount = postsSnap.data?.length ?? 0;
            final reviewCount = reviewsSnap.data?.length ?? 0;
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: V2Segment<_PlaceDetailTab>(
                value: tab,
                onChanged: onChanged,
                items: [
                  V2SegmentItem(
                    value: _PlaceDetailTab.about,
                    label: LocaleKeys.placeDetailV2_tabAbout.tr(),
                  ),
                  V2SegmentItem(
                    value: _PlaceDetailTab.mentions,
                    label:
                        '${LocaleKeys.placeDetailV2_tabMentions.tr()} ($postCount)',
                  ),
                  V2SegmentItem(
                    value: _PlaceDetailTab.reviews,
                    label:
                        '${LocaleKeys.placeDetailV2_tabReviews.tr()} ($reviewCount)',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
