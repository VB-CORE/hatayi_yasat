import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/circle_avatar/v2_avatar.dart';
import 'package:lifeclient/product/widget/image/v2_photo_block.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// V2 post card. Carries an optional `MEKAN SAHİBİ` badge for places
/// posted by their owner (auto-applied when [V2Post.isOwner] is true)
/// and an `HATIRA · YYYY` badge when [V2Post.isMemory] is true.
class V2PostCard extends StatefulWidget {
  const V2PostCard({
    required this.post,
    super.key,
    this.onUserTap,
    this.onPlaceTap,
    this.onOpen,
  });

  final V2Post post;
  final ValueChanged<V2User>? onUserTap;
  final ValueChanged<V2PlaceRef>? onPlaceTap;
  final VoidCallback? onOpen;

  @override
  State<V2PostCard> createState() => _V2PostCardState();
}

class _V2PostCardState extends State<V2PostCard> {
  bool _liked = false;
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final user = V2SampleData.userById(post.userId);
    return Container(
      color: ColorsCustom.white,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            user: user,
            post: post,
            saved: _saved,
            onUser: widget.onUserTap,
            onSavedToggle: () => setState(() => _saved = !_saved),
          ),
          if (post.place != null) ...[
            const SizedBox(height: 10),
            _PlaceChip(
              place: post.place!,
              onTap: () => widget.onPlaceTap?.call(post.place!),
            ),
          ],
          const SizedBox(height: 8),
          GestureDetector(
            onTap: widget.onOpen,
            child: Text(
              post.text,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.55,
                color: ColorsCustom.ink800,
              ),
            ),
          ),
          if (post.photos > 0) ...[
            const SizedBox(height: 10),
            V2PhotoBlock(count: post.photos, accent: post.accent),
          ],
          const SizedBox(height: 12),
          _Actions(
            liked: _liked,
            count: post.likes + (_liked ? 1 : 0),
            onLike: () => setState(() => _liked = !_liked),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.user,
    required this.post,
    required this.saved,
    required this.onUser,
    required this.onSavedToggle,
  });

  final V2User user;
  final V2Post post;
  final bool saved;
  final ValueChanged<V2User>? onUser;
  final VoidCallback onSavedToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        V2Avatar(user: user, size: 40),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onUser?.call(user),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColorsCustom.ink900,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                  if (post.isOwner) const _OwnerBadge(),
                  if (post.isMemory) _MemoryBadge(year: post.year ?? ''),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                '@${user.handle} · ${post.timeAgo}',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: ColorsCustom.ink500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSavedToggle,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 20,
            color: saved ? ColorsCustom.navy : ColorsCustom.ink400,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.more_horiz_rounded,
          size: 18,
          color: ColorsCustom.ink400,
        ),
      ],
    );
  }
}

class _OwnerBadge extends StatelessWidget {
  const _OwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: ColorsCustom.navy50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 10, color: ColorsCustom.navy),
          SizedBox(width: 3),
          Text(
            'MEKAN SAHİBİ',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: ColorsCustom.navy,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoryBadge extends StatelessWidget {
  const _MemoryBadge({required this.year});

  final String year;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: ColorsCustom.gold50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'HATIRA · $year',
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          color: ColorsCustom.gold,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _PlaceChip extends StatelessWidget {
  const _PlaceChip({required this.place, required this.onTap});

  final V2PlaceRef place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: ColorsCustom.coral50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.storefront_rounded,
              size: 12,
              color: ColorsCustom.coral,
            ),
            const SizedBox(width: 6),
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: ColorsCustom.coral600,
              ),
            ),
            Text(
              ' · ${place.district}',
              style: const TextStyle(
                fontSize: 11.5,
                color: ColorsCustom.coral400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.liked,
    required this.count,
    required this.onLike,
  });

  final bool liked;
  final int count;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onLike,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: liked ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    liked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 20,
                    color: liked ? ColorsCustom.coral : ColorsCustom.ink500,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: liked ? ColorsCustom.coral : ColorsCustom.ink500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 18),
        const Icon(
          Icons.share_outlined,
          size: 18,
          color: ColorsCustom.ink500,
        ),
      ],
    );
  }
}
