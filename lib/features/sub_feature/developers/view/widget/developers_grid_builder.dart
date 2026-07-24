part of '../developers_view.dart';

@immutable
final class _DevelopersBubbleChart extends StatelessWidget {
  const _DevelopersBubbleChart({required this.developers});

  final List<DeveloperModel> developers;

  void _openProfile(DeveloperModel developer) {
    if (developer.githubUrl.ext.isNullOrEmpty) return;
    unawaited(developer.githubUrl.ext.launchWebsite);
  }

  List<BubbleData> get bubbles => developers
      .map(
        (e) => BubbleData(
          key: e.documentId,
          title: e.name?.shortDisplayName ?? '',
          imageUrl: e.image,
          onTap: () => _openProfile(e),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: .bottomCenter,
          child: SizedBox(
            height: context.sized.dynamicHeight(.25),
            child: const IgnorePointer(child: _SoftArcMosaic()),
          ),
        ),
        BubbleChart(data: bubbles),
        const Align(
          alignment: .topCenter,
          child: IgnorePointer(child: _DevelopersThanksHeader()),
        ),
      ],
    );
  }
}

final class _DevelopersThanksHeader extends StatelessWidget {
  const _DevelopersThanksHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.vertical12Symmetric(),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [AppColors.navy700, AppColors.coral600, AppColors.gold],
            stops: [0.0, 0.8, 1.0],
          ).createShader(bounds);
        },
        blendMode: .srcIn,
        child: Text(
          LocaleKeys.developers_thanksMessage.tr(),
          style: AppText.displayLg.copyWith(
            color: Colors.white,
            fontWeight: .w600,
          ),
          textAlign: .center,
        ),
      ),
    );
  }
}
