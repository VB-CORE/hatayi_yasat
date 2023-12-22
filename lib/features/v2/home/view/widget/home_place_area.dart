part of '../home_view.dart';

final class _HomePlacesArea extends ConsumerWidget {
  const _HomePlacesArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyModel = StoreModel(
      name: 'Harika Restoran',
      description:
          'Harika Restoran, lezzetli yemekleri ve sıcak atmosferiyle ünlü bir mekan. Her bir yemek, özenle seçilmiş malzemelerle hazırlanır ve şeflerimiz tarafından ustalıkla sunulur. Menümüzde dünya mutfağından lezzetler bulabilir, her damak zevkine hitap eden özel tatlar deneyebilirsiniz.',
      owner: 'Ahmet Yılmaz',
      address:
          'Güzel Sokak No: 123, Merkez Mahallesi, Şehir / Ülke Zemin Kat, Kapı No: 5',
      phone: '+90 123 456 7890',
      category: const CategoryModel(
        name: 'Restoran',
        value: 0,
      ),
      townCode: 0,
      images: const ['https://picsum.photos/seed/picsum/200/300'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isApproved: true,
    );
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const PagePadding.onlyBottomMedium(),
          child: GeneralPlaceCard(
            onCardTap: () {
              // TODO: Gerçek model yollanacak.
              PlaceDetailRoute($extra: dummyModel)
                  .push<PlaceDetailRoute>(context);
            },
          ),
        );
      },
    );
  }
}
