part of '../news_detail_view.dart';

@immutable
final class _NewsMetaRow extends StatelessWidget {
  const _NewsMetaRow({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Text(
      date.shortDate,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.bodySmall?.copyWith(
        color: context.general.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

@immutable
final class _NewsContentText extends StatelessWidget {
  const _NewsContentText({
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: context.general.textTheme.bodyLarge,
    );
  }
}
