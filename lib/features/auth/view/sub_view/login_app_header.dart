part of '../login_view.dart';

final class _LoginAppHeader extends StatelessWidget {
  const _LoginAppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.general.colorScheme.surface,
            borderRadius: CustomRadius.large,
            boxShadow: [
              BoxShadow(
                color: context.general.colorScheme.shadow.withValues(
                  alpha: 0.12,
                ),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Assets.icons.icApp.image(),
        ),
        const EmptyBox.middleWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.project_name.tr(),
              style: context.general.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsCustom.sambacus,
              ),
            ),
            Text(
              LocaleKeys.auth_tagline.tr(),
              style: context.general.textTheme.labelSmall?.copyWith(
                color: ColorsCustom.royalPeacock,
                letterSpacing: 2,
                fontWeight: .w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
