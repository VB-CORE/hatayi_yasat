part of '../web_sidebar.dart';

final class _WebSidebarSection extends StatelessWidget {
  const _WebSidebarSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.xxs,
        children: [
          Padding(
            padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
            child: Text(
              title,
              style: AppText.eyebrow.copyWith(
                color: context.general.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
