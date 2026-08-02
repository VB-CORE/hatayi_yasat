part of '../news_detail_view.dart';

@immutable
final class _NewsMetaRow extends StatelessWidget {
  const _NewsMetaRow({
    required this.author,
    required this.date,
  });

  final NewsAuthorModel? author;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final hasAuthor = author != null && author!.handle.isNotEmpty;
    final dateText = date?.shortDate;

    if (!hasAuthor && dateText == null) return const SizedBox.shrink();

    final metaText = [
      if (hasAuthor) author!.handle,
      if (dateText != null) dateText,
    ].join(' · ');

    return Row(
      children: [
        if (hasAuthor) ...[
          CustomUserAvatar(
            userName: author!.name,
            imageUrl: author!.avatarUrl,
            radius: WidgetSizes.spacingS,
          ),
          const EmptyBox.smallWidth(),
        ],
        Flexible(
          child: Text(
            metaText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.general.textTheme.bodySmall?.copyWith(
              color: context.general.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
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
