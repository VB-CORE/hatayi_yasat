part of '../settings_view.dart';

@immutable
final class _ContactUsWidget extends StatelessWidget {
  const _ContactUsWidget();

  @override
  Widget build(BuildContext context) {
    return ContentMenu(
      items: [
        for (final model in ContactModel.dummyModels)
          ContentMenuItem(
            leading: ClipOval(
              child: SizedBox.square(
                dimension: AppIconSizes.xLarge,
                child: CustomNetworkImage(
                  imageUrl: model.imageUrl,
                  fit: .cover,
                ),
              ),
            ),
            label: model.name,
            subtitle: model.role,
            showChevron: false,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.sm,
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
          ),
      ],
    );
  }
}

@immutable
final class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomBounceable(
      onTap: onTap,
      child: Material(
        color: context.appColors.navy50,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
