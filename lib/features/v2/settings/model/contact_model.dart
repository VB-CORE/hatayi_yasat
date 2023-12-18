final class ContactModel {
  ContactModel({
    required this.name,
    required this.imageUrl,
    required this.twitterUrl,
    required this.mail,
  });
  final String name;
  final String imageUrl;
  final String twitterUrl;
  final String mail;
  static final List<ContactModel> dummyModels = [
    ContactModel(
      imageUrl:
          'https://pbs.twimg.com/profile_images/1509340693956861953/8xDGlT75_400x400.jpg',
      mail: 'abc@gmail.com',
      name: 'Veli Bacık',
      twitterUrl: 'https://twitter.com/10VBacik',
    ),
    ContactModel(
      imageUrl:
          'https://pbs.twimg.com/profile_images/1643695427840098306/ugEFQ49l_400x400.jpg',
      mail: 'abc@gmail.com',
      name: 'Grafik Herif',
      twitterUrl: 'https://twitter.com/grafikherif',
    ),
  ];
}
