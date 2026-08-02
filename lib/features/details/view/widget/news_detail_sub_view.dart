part of '../news_detail_view.dart';

@immutable
final class _NewsMetaRow extends StatelessWidget {
  const _NewsMetaRow({required this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final dateText = date?.shortDate;
    if (dateText == null) return const SizedBox.shrink();

    return Text(
      dateText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.bodySmall?.copyWith(
        color: context.general.colorScheme.onSurfaceVariant,
      ),
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
      style: context.general.textTheme.bodyLarge,
    );
  }
}
