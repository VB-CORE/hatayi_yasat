final class AdvertisementModel {
  const AdvertisementModel({this.link, this.imageUrl});

  //TODO: delete mocks later
  const AdvertisementModel.mock1()
      : this(
          link: 'https://www.vecteezy.com/free-vector/advertising-banner',
          imageUrl:
              'https://static.vecteezy.com/system/resources/thumbnails/005/009/008/small/printend-of-year-sale-banner-with-copy-space-background-for-product-promotion-and-advertising-free-vector.jpg',
        );

  const AdvertisementModel.mock2()
      : this(
          link: 'https://www.fotor.com/blog/banner-ads-design/',
          imageUrl:
              'https://www.fotor.com/blog/wp-content/uploads/2019/07/3-solid-background.png',
        );

  final String? link;
  final String? imageUrl;
}
