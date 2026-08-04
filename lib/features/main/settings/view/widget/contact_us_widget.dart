part of '../settings_view.dart';

@immutable
final class _ContactUsWidget extends StatelessWidget {
  const _ContactUsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.sm,
      children: [
        GeneralGroupSectionHeader(
          label: LocaleKeys.settings_contactTitle
              .tr(context: context)
              .toUpperCase(),
        ),
        const _ContactUsRow(),
      ],
    );
  }
}

@immutable
final class _ContactUsRow extends StatelessWidget {
  const _ContactUsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.navy50,
        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
      margin: const PagePadding.horizontalNormalSymmetric(),
      padding: const PagePadding.allLow(),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: AppSpacing.md,
        children: ContactModel.dummyModels
            .map((model) => _ContactUsCard(model: model))
            .toList(),
      ),
    );
  }
}

@immutable
final class _ContactUsCard extends StatelessWidget {
  const _ContactUsCard({required this.model});

  final ContactModel model;

  @override
  Widget build(BuildContext context) {
    final avatarSize = context.sized.dynamicWidth(.35);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xs,
      children: [
        SizedBox.square(
          dimension: avatarSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipOval(
                child: CustomNetworkImage(
                  imageUrl: model.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      context.appColors.navy900.withValues(alpha: .25),
                      context.appColors.navy900.withValues(alpha: .40),
                      context.appColors.navy900.withValues(alpha: .70),
                    ],
                    stops: const [0.28, 0.5, 0.72, 1],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          model.name,
          style: AppText.bodyLg.copyWith(
            color: context.appColors.navy900,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.xs,
          children: [
            _SocialButton(
              icon: FaIcon(
                AppIcons.twitter,
                size: AppIconSizes.xMedium,
                color: context.appColors.navy700,
              ),
              onTap: () => model.twitterUrl.ext.launchWebsite,
            ),
            _SocialButton(
              icon: Icon(
                AppIcons.mail,
                size: AppIconSizes.xMedium,
                color: context.appColors.navy700,
              ),
              onTap: () => model.mail.ext.launchEmail,
            ),
          ],
        ),
      ],
    );
  }
}

@immutable
final class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.onTap});

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.navy900.withValues(alpha: .1),
      shape: const CircleBorder(),
      child: CustomBounceable(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
