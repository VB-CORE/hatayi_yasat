import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/post_model.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/repository/posts/posts_repository_provider.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/card/v2_post_card.dart';

/// V2 post detail — like-only view, no comments yet (the V2 design ships
/// with a "Yorumlar çok yakında" notice). Reads the post from
/// [postsRepositoryProvider] so the like count stays live.
class PostDetailView extends ConsumerWidget {
  const PostDetailView({required this.id, this.initial, super.key});

  final String id;
  final PostModel? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final repo = ref.watch(postsRepositoryProvider);
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        title: Text(
          LocaleKeys.postDetail_title.tr(),
          style: V2Typography.display(fontSize: 20, color: colorScheme.primary),
        ),
      ),
      body: FutureBuilder<PostModel?>(
        future: initial != null ? Future.value(initial) : repo.get(id),
        builder: (context, snap) {
          if (!snap.hasData && initial == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final post = snap.data ?? initial!;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              V2PostCard(post: V2Post.fromModel(post)),
              const SizedBox(height: 12),
              _LikeRow(repo: repo, post: post, ref: ref),
              const EmptyBox.middleHeight(),
              const _CommentsSoonNotice(),
            ],
          );
        },
      ),
    );
  }
}

class _LikeRow extends StatelessWidget {
  const _LikeRow({required this.repo, required this.post, required this.ref});

  final dynamic repo;
  final PostModel post;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () async {
              final isLiked =
                  await (repo as dynamic).watchIsLiked(post.id).first as bool;
              if (isLiked) {
                await (repo as dynamic).unlike(post.id);
              } else {
                await (repo as dynamic).like(post.id);
              }
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: colorScheme.error,
              size: 18,
            ),
            label: Text(
              LocaleKeys.postDetail_like.tr(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: colorScheme.error,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              side: BorderSide(color: colorScheme.error),
              shape: const RoundedRectangleBorder(
                borderRadius: CustomRadius.medium,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '${post.likeCount}',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentsSoonNotice extends StatelessWidget {
  const _CommentsSoonNotice();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.onPrimaryFixed,
          borderRadius: CustomRadius.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('💬'),
            const SizedBox(height: 6),
            Text(
              LocaleKeys.postDetail_commentsSoon.tr(),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryFixedVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
