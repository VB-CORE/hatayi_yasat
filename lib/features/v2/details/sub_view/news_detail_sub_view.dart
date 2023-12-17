part of '../view/news_detail_view.dart';

@immutable
final class _ImageWithButtonAndNameStack extends StatelessWidget {
  const _ImageWithButtonAndNameStack({
    required this.image,
    required this.backButtonAction,
  });

  final String image;
  final AsyncCallback backButtonAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _ImageSizedBox(image: image),
        _BackButtonContainer(
          onPressed: backButtonAction,
        ),
      ],
    );
  }
}

@immutable
final class _ImageSizedBox extends StatelessWidget {
  const _ImageSizedBox({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      height: context.sized.dynamicHeight(0.3),
      child: CustomNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      ),
    );
  }
}

@immutable
final class _BackButtonContainer extends StatelessWidget {
  const _BackButtonContainer({
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BackButtonWidget(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
    );
  }
}
