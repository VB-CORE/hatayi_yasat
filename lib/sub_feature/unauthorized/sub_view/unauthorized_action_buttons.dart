part of '../unauthorized_view.dart';

final class _BackToGroupsButton extends StatelessWidget {
  const _BackToGroupsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.navy700,
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.leftSelect),
        label: Text(
          LocaleKeys.unauthorized_backToGroups.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: AppColors.navy700,
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

  static const double _borderOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.white.withValues(alpha: _borderOpacity),
          ),
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        child: Text(
          LocaleKeys.unauthorized_requestAccess.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
