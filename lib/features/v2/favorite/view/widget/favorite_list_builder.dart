part of '../favorite_view.dart';

final class _FavoriteListBuilder extends StatelessWidget {
  const _FavoriteListBuilder();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _FavoriteAuthorWidget(
          name: 'Test Author $index',
          image:
              'https://fastly.picsum.photos/id/64/200/200.jpg?hmac=lJVbDn4h2axxkM72s1w8X1nQxUS3y7li49cyg0tQBZU',
          onCardTapped: () {
            // navigate to details
          },
          onDeleteTapped: () {
            // remove from favorites
          },
        );
      },
    );
  }
}

final class _FavoriteAuthorWidget extends StatelessWidget {
  const _FavoriteAuthorWidget({
    required this.name,
    required this.image,
    required this.onCardTapped,
    required this.onDeleteTapped,
  });

  final String name;
  final String image;
  final VoidCallback onCardTapped;
  final VoidCallback onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTapped.call,
      child: Padding(
        padding: const PagePadding.vertical6Symmetric(),
        child: AuthorListTileWidget(
          image: image,
          text: name,
          trailingWidget: IconButton(
            onPressed: onDeleteTapped.call,
            icon: const Icon(AppIcons.delete),
          ),
        ),
      ),
    );
  }
}
