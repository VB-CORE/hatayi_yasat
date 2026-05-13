part of '../place_detail_view.dart';

/// Hero (220h) — real place images in a swipeable PageView when
/// `model.images` is non-empty; falls back to the navy gradient + mozaik
/// overlay so the V2 mosaic identity is preserved for places without
/// photos yet. The navy gradient is intentionally brand-locked (kept on
/// `ColorsCustom.navy/navy600`) so the hero looks the same in dark mode.
final class _PlaceDetailHero extends StatefulWidget {
  const _PlaceDetailHero({required this.model});

  final StoreModel model;

  @override
  State<_PlaceDetailHero> createState() => _PlaceDetailHeroState();
}

class _PlaceDetailHeroState extends State<_PlaceDetailHero> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> get _images => widget.model.images
      .where((url) => url.isNotEmpty)
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final images = _images;
    final hasImages = images.isNotEmpty;
    return SizedBox(
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasImages)
            PageView.builder(
              controller: _controller,
              itemCount: images.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) => CustomNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                height: 220,
                placeholder: const _HeroGradientBackground(),
              ),
            )
          else
            const _HeroGradientBackground(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x40000000),
                  Color(0x00000000),
                  Color(0x66000000),
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  _HeroIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const Spacer(),
                  _HeroIconButton(
                    icon: Icons.bookmark_outline_rounded,
                    onTap: () {},
                  ),
                  const EmptyBox.smallWidth(),
                  _HeroIconButton(
                    icon: Icons.share_outlined,
                    onTap: () =>
                        '${widget.model.name} ${widget.model.address ?? ''}'.ext
                            .share(),
                  ),
                  const EmptyBox.smallWidth(),
                  _HeroIconButton(
                    icon: Icons.more_horiz_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          if (hasImages && images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: _HeroDotsIndicator(
                  count: images.length,
                  index: _index,
                ),
              ),
            ),
          if (hasImages)
            Positioned(
              right: 14,
              bottom: 12,
              child: _HeroPhotoCounter(
                current: _index + 1,
                total: images.length,
              ),
            ),
        ],
      ),
    );
  }
}

final class _HeroGradientBackground extends StatelessWidget {
  const _HeroGradientBackground();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          // Brand-lock: V2 mozaik navy hero is intentionally fixed.
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsCustom.navy,
                ColorsCustom.navy600,
              ],
            ),
          ),
        ),
        MosaicGrid(opacity: 0.22, tileSize: 16),
      ],
    );
  }
}

final class _HeroIconButton extends StatelessWidget {
  const _HeroIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x66000000),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

final class _HeroDotsIndicator extends StatelessWidget {
  const _HeroDotsIndicator({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFFFFFF) : const Color(0x80FFFFFF),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

final class _HeroPhotoCounter extends StatelessWidget {
  const _HeroPhotoCounter({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x8C000000),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.photo_library_rounded,
              size: 11,
              color: Color(0xFFFFFFFF),
            ),
            const EmptyBox(width: 4),
            Text(
              total > 1 ? '$current / $total' : '$total',
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
