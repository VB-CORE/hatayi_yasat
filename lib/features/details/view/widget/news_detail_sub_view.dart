part of '../news_detail_view.dart';

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
