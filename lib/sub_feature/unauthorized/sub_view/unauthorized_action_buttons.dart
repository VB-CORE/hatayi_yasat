part of '../unauthorized_view.dart';

final class _BackToGroupsButton extends StatelessWidget {
  const _BackToGroupsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final navy700 = context.appColors.navy700;
    return SizedBox(
      width: context.sized.width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.general.colorScheme.onTertiary,
          foregroundColor: navy700,
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.leftSelect),
        label: Text(
          LocaleKeys.unauthorized_backToGroups.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: navy700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

final class _RequestAccessButton extends StatelessWidget {
  const _RequestAccessButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: context.general.colorScheme.onTertiary.withValues(
              alpha: 0.3,
            ),
          ),
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        child: Text(
          LocaleKeys.unauthorized_requestAccess.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: context.general.colorScheme.onTertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
