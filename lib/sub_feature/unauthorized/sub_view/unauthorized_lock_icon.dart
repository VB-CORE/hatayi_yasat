part of '../unauthorized_view.dart';

final class _LockIcon extends StatelessWidget {
  const _LockIcon();

  @override
  Widget build(BuildContext context) {
    final tertiary = context.general.colorScheme.tertiary;
    return Container(
      padding: const PagePadding.generalAllNormal(),
      decoration: BoxDecoration(
        color: tertiary.withValues(alpha: 0.15),
        borderRadius: CustomRadius.extraLarge,
        border: Border.all(
          color: tertiary.withValues(alpha: 0.4),
        ),
      ),
      child: Icon(
        AppIcons.lockPerson,
        color: tertiary,
        size: AppIconSizes.xLarge,
      ),
    );
  }
}
