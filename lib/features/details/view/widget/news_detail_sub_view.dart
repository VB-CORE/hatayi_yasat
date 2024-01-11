part of '../news_detail_view.dart';

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
        CustomImageWithViewDialog(image: image),
        SafeArea(
          child: _BackButtonContainer(
            onPressed: backButtonAction,
          ),
        ),
      ],
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

@immutable
final class _DateIconAndText extends StatelessWidget {
  const _DateIconAndText({
    required this.date,
  });

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    if (date == null) return const SizedBox.shrink();

    return IconWithText(
      icon: AppIcons.calendar,
      title: DateFormat.yMMMEd().format(
        date!,
      ),
      color: context.general.colorScheme.primary.withOpacity(0.7),
    );
  }
}

@immutable
final class _SelectableContentText extends StatelessWidget {
  const _SelectableContentText({
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      content,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
