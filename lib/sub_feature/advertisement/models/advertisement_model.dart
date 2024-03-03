final class AdvertisementModel {
  const AdvertisementModel({this.link, this.imageUrl});

  //TODO: delete mocks later
  const AdvertisementModel.mock1()
      : this(
          link: 'https://www.vecteezy.com/free-vector/advertising-banner',
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c.appspot.com/o/WhatsApp%20Image%202024-02-27%20at%202.47.30%E2%80%AFAM.jpeg?alt=media&token=6c74afde-2fbe-4595-8532-f8042a81a398',
        );

  const AdvertisementModel.mock2()
      : this(
          link: 'https://www.fotor.com/blog/banner-ads-design/',
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c.appspot.com/o/WhatsApp%20Image%202024-02-27%20at%202.47.31%E2%80%AFAM.jpeg?alt=media&token=dc08396a-2818-49a2-8ae8-7d7b20d76c32',
        );

  const AdvertisementModel.mock3()
      : this(
          link: 'https://www.fotor.com/blog/banner-ads-design/',
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c.appspot.com/o/WhatsApp%20Image%202024-02-27%20at%202.47.32%E2%80%AFAM.jpeg?alt=media&token=3832424f-5865-46be-96a9-670497facfc6',
        );

  final String? link;
  final String? imageUrl;
}
