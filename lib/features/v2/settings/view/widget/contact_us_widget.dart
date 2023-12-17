// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../settings_view.dart';

final class _ContactUsWidget extends StatelessWidget {
  const _ContactUsWidget();

  @override
  Widget build(BuildContext context) {
    return const GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_contactTitle,
      children: [
        _ContactUsGridView(),
      ],
    );
  }
}

final class _ContactUsGridView extends StatelessWidget {
  const _ContactUsGridView();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyContactModel.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: WidgetSizes.spacingXxlL13,
      ),
      itemBuilder: (context, i) => _ContactUsCard(model: dummyContactModel[i]),
    );
  }
}

final class _ContactUsCard extends StatelessWidget {
  const _ContactUsCard({required this.model});
  final ContactModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const EmptyBox.smallHeight(),
          _UserImage(imageUrl: model.imageUrl),
          const EmptyBox.smallHeight(),
          GeneralBodyTitle(model.name, fontWeight: FontWeight.bold),
          const EmptyBox.smallHeight(),
          _ContactTile(
            title: 'Twitter',
            icon: FontAwesomeIcons.xTwitter,
            onTap: () => model.twitterUrl.ext.launchWebsite,
          ),
          _ContactTile(
            title: 'Mail',
            icon: Icons.mail_outline,
            onTap: () => model.mail.ext.launchEmail,
          ),
        ],
      ),
    );
  }
}

final class _UserImage extends StatelessWidget {
  const _UserImage({required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: CustomCircleRadius.large + CustomCircleRadius.small,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}

final class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GeneralBodyTitle(title),
      trailing: Icon(icon),
      onTap: onTap,
    );
  }
}
