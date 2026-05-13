import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/social/post_model.dart';
import 'package:lifeclient/product/model/social/store_display_x.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// V2 sample/static data — mirrors `data.jsx` and `data-v2.jsx` from the
/// design bundle. Acts as a stand-in until the real data layer is wired
/// in.
class V2User {
  const V2User({
    required this.id,
    required this.name,
    required this.handle,
    required this.avatarColor,
    required this.district,
    this.isMe = false,
  });

  final String id;
  final String name;
  final String handle;
  final Color avatarColor;
  final String district;
  final bool isMe;

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts[0].characters.first + parts[1].characters.first)
        .toUpperCase();
  }
}

class V2PlaceRef {
  const V2PlaceRef({
    required this.id,
    required this.name,
    required this.district,
  });

  final String id;
  final String name;
  final String district;
}

class V2Post {
  const V2Post({
    required this.id,
    required this.userId,
    required this.text,
    required this.timeAgo,
    required this.likes,
    required this.photos,
    required this.accent,
    this.place,
    this.isOwner = false,
    this.isMemory = false,
    this.year,
  });

  /// Adapt a real [PostModel] from Firestore into the V2 display surface
  /// used by [V2PostCard]. Photos count is derived from the URL list;
  /// accent colours cycle deterministically off the post id.
  factory V2Post.fromModel(PostModel model) {
    final accents = <List<Color>>[
      [ColorsCustom.coral, ColorsCustom.gold],
      [ColorsCustom.teal, ColorsCustom.navy],
      [ColorsCustom.olive400, ColorsCustom.coral],
      [ColorsCustom.gold, ColorsCustom.teal],
    ];
    final hash = model.id.codeUnits.fold<int>(0, (a, b) => a + b);
    return V2Post(
      id: model.id,
      userId: model.authorUid,
      text: model.text,
      timeAgo: _relativeTime(model.createdAt),
      likes: model.likeCount,
      photos: model.photos.length,
      accent: accents[hash % accents.length],
      place: model.placeId == null
          ? null
          : V2PlaceRef(
              id: model.placeId!,
              name: model.placeName ?? '',
              district: model.placeDistrict ?? '',
            ),
      isMemory: model.isMemory,
      year: model.year?.toString(),
    );
  }

  final String id;
  final String userId;
  final String text;
  final String timeAgo;
  final int likes;
  final int photos;
  final List<Color> accent;
  final V2PlaceRef? place;
  final bool isOwner;
  final bool isMemory;
  final String? year;
}

String _relativeTime(DateTime when) {
  final delta = DateTime.now().difference(when);
  if (delta.inMinutes < 1) return 'şimdi';
  if (delta.inMinutes < 60) return '${delta.inMinutes} dk';
  if (delta.inHours < 24) return '${delta.inHours} saat';
  if (delta.inDays < 7) return '${delta.inDays} gün';
  return '${(delta.inDays / 7).floor()} hafta';
}

class V2Place {
  const V2Place({
    required this.id,
    required this.name,
    required this.owner,
    required this.district,
    required this.neighborhood,
    required this.category,
    required this.categoryLabel,
    required this.isOpen,
    required this.hours,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.desc,
    required this.accent,
    required this.tags,
    this.address,
    this.phone,
  });

  /// Adapt a real [StoreModel] from `life_shared` into the V2 display
  /// surface used by [V2PlaceCard]. Pulls fallbacks from
  /// [StoreModelDisplay] for fields the schema doesn't carry yet
  /// (rating, distance, accent palette).
  factory V2Place.fromStore(StoreModel store) {
    return V2Place(
      id: store.documentId,
      name: store.name,
      owner: store.owner,
      district: store.districtLabel,
      neighborhood: store.districtLabel,
      category: '${store.category?.value ?? 0}',
      categoryLabel: store.categoryLabel,
      isOpen: store.isOpenNow,
      hours: store.hoursLabel,
      distance: store.distanceFallback,
      rating: store.ratingFallback,
      reviewCount: store.reviewCountFallback,
      desc: store.description ?? '',
      accent: store.displayAccent,
      tags: const <String>[],
      address: store.address,
      phone: store.phone,
    );
  }

  final String id;
  final String name;
  final String owner;
  final String district;
  final String neighborhood;
  final String category;
  final String categoryLabel;
  final bool isOpen;
  final String hours;
  final String distance;
  final double rating;
  final int reviewCount;
  final String desc;
  final List<Color> accent;
  final List<String> tags;
  final String? address;
  final String? phone;
}

class V2Memory {
  const V2Memory({
    required this.id,
    required this.title,
    required this.neighborhood,
    required this.desc,
    required this.contributor,
    required this.year,
    required this.era,
    required this.loves,
    required this.accent,
  });

  final String id;
  final String title;
  final String neighborhood;
  final String desc;
  final String contributor;
  final String year;
  final String era;
  final int loves;
  final Color accent;
}

class V2NewsItem {
  const V2NewsItem({
    required this.id,
    required this.title,
    required this.authorName,
    required this.timeAgo,
    required this.tag,
    required this.excerpt,
    required this.accent,
  });

  final String id;
  final String title;
  final String authorName;
  final String timeAgo;
  final String tag;
  final String excerpt;
  final Color accent;
}

class V2Event {
  const V2Event({
    required this.id,
    required this.title,
    required this.day,
    required this.month,
    required this.weekday,
    required this.time,
    required this.place,
    required this.district,
    required this.going,
    required this.category,
    required this.desc,
    required this.accent,
  });

  final String id;
  final String title;
  final String day;
  final String month;
  final String weekday;
  final String time;
  final String place;
  final String district;
  final int going;
  final String category;
  final String desc;
  final Color accent;
}

enum V2NotifKind { place, event, memory, system, mention }

class V2Notification {
  const V2Notification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.date,
    required this.read,
  });

  final String id;
  final V2NotifKind kind;
  final String title;
  final String body;
  final String date;
  final bool read;
}

class V2Category {
  const V2Category({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class V2City {
  const V2City({
    required this.id,
    required this.name,
    required this.fullName,
    required this.tag,
    required this.districts,
    required this.accent,
  });

  final String id;
  final String name;
  final String fullName;
  final String tag;
  final List<String> districts;
  final Color accent;
}

class V2SampleData {
  const V2SampleData._();

  static const cityHatay = V2City(
    id: 'hatay',
    name: 'Hatay',
    fullName: "Hatay'ı Yaşat",
    tag: 'Antakya · Defne · İskenderun',
    districts: [
      'Antakya',
      'Defne',
      'İskenderun',
      'Samandağ',
      'Belen',
      'Arsuz',
      'Kırıkhan',
      'Reyhanlı',
      'Altınözü',
    ],
    accent: ColorsCustom.coral,
  );

  static const cityMersin = V2City(
    id: 'mersin',
    name: 'Mersin',
    fullName: "Mersin'i Yaşat",
    tag: 'Akdeniz · Tarsus · Mezitli',
    districts: [
      'Akdeniz',
      'Tarsus',
      'Mezitli',
      'Yenişehir',
      'Toroslar',
      'Erdemli',
      'Silifke',
      'Anamur',
    ],
    accent: ColorsCustom.teal,
  );

  static V2City cityById(String id) => id == 'mersin' ? cityMersin : cityHatay;

  static const users = <V2User>[
    V2User(
      id: 'u1',
      name: 'Eylem Akdeniz',
      handle: 'eylemak',
      avatarColor: ColorsCustom.coral,
      district: 'Antakya',
    ),
    V2User(
      id: 'u2',
      name: 'Mehmet Yıldız',
      handle: 'mehmety',
      avatarColor: ColorsCustom.teal,
      district: 'Defne',
    ),
    V2User(
      id: 'u3',
      name: 'Ahmet Altınöz',
      handle: 'altinoz',
      avatarColor: ColorsCustom.navy,
      district: 'Antakya',
    ),
    V2User(
      id: 'u4',
      name: 'Saim Yıldırım',
      handle: 'saimusta',
      avatarColor: ColorsCustom.coral,
      district: 'Antakya',
    ),
    V2User(
      id: 'u5',
      name: 'Yusuf Erkmen',
      handle: 'yoes',
      avatarColor: ColorsCustom.olive500,
      district: 'Antakya',
    ),
    V2User(
      id: 'u6',
      name: 'Daren Belli',
      handle: 'darenb',
      avatarColor: ColorsCustom.teal,
      district: 'Samandağ',
    ),
    V2User(
      id: 'u7',
      name: 'Ben',
      handle: 'ben',
      avatarColor: ColorsCustom.navy,
      district: 'Antakya',
      isMe: true,
    ),
  ];

  static V2User userById(String id) =>
      users.firstWhere((u) => u.id == id, orElse: () => users.first);

  static V2User get me => users.last;

  static const places = <V2Place>[
    V2Place(
      id: 'kunefe',
      name: 'Künefeci Saim Usta',
      owner: 'Saim Yıldırım',
      district: 'Antakya',
      neighborhood: 'Uzun Çarşı',
      category: 'rest',
      categoryLabel: 'Tatlıcı',
      isOpen: true,
      hours: '09:00 – 23:00',
      distance: '0.5 km',
      rating: 4.9,
      reviewCount: 312,
      desc:
          "1964'ten beri Antakya'nın gerçek künefesi. Üçüncü kuşak aile işletmesi.",
      accent: [ColorsCustom.coral, ColorsCustom.gold],
      tags: ['Künefe', 'Tatlı'],
      address: 'Uzun Çarşı No:14 Antakya/Hatay',
      phone: '+90 326 215 22 14',
    ),
    V2Place(
      id: 'dobby',
      name: 'Dobby Pet Market',
      owner: 'Eylem Akdeniz',
      district: 'Antakya',
      neighborhood: 'Akasya Mah.',
      category: 'pet',
      categoryLabel: 'Pet & Bakım',
      isOpen: true,
      hours: '10:00 – 20:30',
      distance: '1.2 km',
      rating: 4.7,
      reviewCount: 23,
      desc:
          'Kedi köpek mama, ödül, oyuncak, tasma, aksesuar. Kuş ve balık yemleri.',
      accent: [ColorsCustom.coral, ColorsCustom.gold],
      tags: ['Mama', 'Aksesuar', 'Bakım'],
      address: 'Akasya Mah. Atatürk Cad. No:42 Antakya/Hatay',
      phone: '+90 533 123 45 67',
    ),
    V2Place(
      id: 'yoes',
      name: 'YOES Çiçekçilik',
      owner: 'Yusuf Erkmen',
      district: 'Antakya',
      neighborhood: 'Güzelburç',
      category: 'flower',
      categoryLabel: 'Çiçekçi',
      isOpen: false,
      hours: '10:30 – 20:00',
      distance: '2.4 km',
      rating: 4.8,
      reviewCount: 56,
      desc:
          'Buket, kişiye özel aranjman, saksı çiçekleri. Düğün ve özel gün organizasyonları.',
      accent: [ColorsCustom.olive400, ColorsCustom.coral],
      tags: ['Buket', 'Aranjman', 'Düğün'],
      phone: '+90 541 935 53 31',
    ),
    V2Place(
      id: 'altinoz',
      name: 'Altınöz Kuyumculuk',
      owner: 'Ahmet Altınöz',
      district: 'Antakya',
      neighborhood: 'Uzun Çarşı',
      category: 'jewel',
      categoryLabel: 'Kuyumcu',
      isOpen: false,
      hours: "08:30'da açılır",
      distance: '0.6 km',
      rating: 4.6,
      reviewCount: 41,
      desc:
          "Üç kuşaktır Uzun Çarşı'da. Geleneksel Hatay işçiliğiyle altın ve gümüş.",
      accent: [ColorsCustom.gold, ColorsCustom.coral],
      tags: ['El işi', 'Tasarım'],
    ),
    V2Place(
      id: 'body',
      name: 'Body Architect',
      owner: 'Mehmet Yıldız',
      district: 'Defne',
      neighborhood: 'Sümerler Mah.',
      category: 'sport',
      categoryLabel: 'Spor Salonu',
      isOpen: true,
      hours: '06:00 – 23:00',
      distance: '4.8 km',
      rating: 4.9,
      reviewCount: 87,
      desc: 'PT, grup dersleri, beslenme danışmanlığı.',
      accent: [ColorsCustom.teal, ColorsCustom.olive400],
      tags: ['PT', 'Grup'],
    ),
    V2Place(
      id: 'goldart',
      name: 'Gold Art Photography',
      owner: 'Daren Belli',
      district: 'Samandağ',
      neighborhood: 'Sahil',
      category: 'craft',
      categoryLabel: 'Fotoğrafçı',
      isOpen: true,
      hours: '10:00 – 22:00',
      distance: '18 km',
      rating: 4.8,
      reviewCount: 92,
      desc: 'Düğün, nişan, ürün çekimi. Drone ve video.',
      accent: [ColorsCustom.gold, ColorsCustom.teal],
      tags: ['Düğün', 'Drone'],
    ),
  ];

  static V2Place placeById(String id) =>
      places.firstWhere((p) => p.id == id, orElse: () => places.first);

  static const posts = <V2Post>[
    V2Post(
      id: 'v1',
      userId: 'u4',
      isOwner: true,
      place: V2PlaceRef(
        id: 'kunefe',
        name: 'Künefeci Saim Usta',
        district: 'Antakya',
      ),
      text:
          "Bugün ilk künefemizi 6:30'da çıkardık. 60 yıllık fırın hâlâ aynı tat. Sabah erken gelen ilk 10 kişiye ikramımız.",
      photos: 2,
      likes: 247,
      timeAgo: '32 dk',
      accent: [ColorsCustom.coral, ColorsCustom.gold],
    ),
    V2Post(
      id: 'v2',
      userId: 'u1',
      place: V2PlaceRef(
        id: 'dobby',
        name: 'Dobby Pet Market',
        district: 'Antakya',
      ),
      text:
          "Akasya'daki Dobby'de yeni gelen mama kedimin uzun zamandır en sevdiği. Eylem Hanım sağolsun, mama önerisi de yaptı.",
      photos: 1,
      likes: 89,
      timeAgo: '2 saat',
      accent: [ColorsCustom.teal, ColorsCustom.coral],
    ),
    V2Post(
      id: 'v3',
      userId: 'u2',
      text:
          "Defne'de yeni açılan kafe önerisi var mı? 6 ay sonra geldim, bayağı şey değişmiş.",
      photos: 0,
      likes: 34,
      timeAgo: '4 saat',
      accent: [ColorsCustom.navy, ColorsCustom.teal],
    ),
    V2Post(
      id: 'v4',
      userId: 'u5',
      isOwner: true,
      place: V2PlaceRef(
        id: 'yoes',
        name: 'YOES Çiçekçilik',
        district: 'Antakya',
      ),
      text:
          "Anneler Günü siparişlerini almaya başladık. Bu yıl Hatay'a özel mozaik buket konseptimizi denedik — çok beğenildi.",
      photos: 3,
      likes: 156,
      timeAgo: '1 gün',
      accent: [ColorsCustom.olive400, ColorsCustom.coral],
    ),
    V2Post(
      id: 'v5',
      userId: 'u6',
      isMemory: true,
      year: '1995',
      text:
          "Samandağ'da çocukken her cumartesi balık pazarına dedem götürürdü. Karagöz, levrek ve mırmır… Şimdi öyle pazar kaldı mı acaba?",
      photos: 1,
      likes: 312,
      timeAgo: '2 gün',
      accent: [ColorsCustom.teal, ColorsCustom.gold],
    ),
  ];

  static const memories = <V2Memory>[
    V2Memory(
      id: 'm1',
      title: 'Affan Kahvesi',
      neighborhood: 'Affan Mah.',
      desc:
          'Kurtuluş Caddesi üzerinde, Affan Mahallesi\'nde. Affan kelimesi Arapça "yiğit" anlamına gelir.',
      contributor: 'Kadir Bekar',
      year: '1930',
      era: 'Cumhuriyet öncesi',
      loves: 142,
      accent: ColorsCustom.coral,
    ),
    V2Memory(
      id: 'm2',
      title: 'Habib-i Neccar Camii',
      neighborhood: 'Habib-i Neccar',
      desc:
          "Anadolu'nun ilk camisi. MS 638'de kurulmuş, defalarca yeniden inşa edilmiştir.",
      contributor: 'Yasin Şenocak',
      year: '1268',
      era: 'Memluk',
      loves: 387,
      accent: ColorsCustom.gold,
    ),
    V2Memory(
      id: 'm3',
      title: 'Vakıflı Köyü Kilisesi',
      neighborhood: 'Vakıflı',
      desc:
          "Türkiye'nin son Ermeni köyü Vakıflı'daki Surp Asdvadzadzin Kilisesi.",
      contributor: 'Berk Sartık',
      year: '1895',
      era: 'Geç Osmanlı',
      loves: 234,
      accent: ColorsCustom.teal,
    ),
    V2Memory(
      id: 'm4',
      title: 'Saint Pierre Kilisesi',
      neighborhood: 'Küçükdalyan',
      desc: 'Hristiyanlığın ilk kiliselerinden biri.',
      contributor: 'Sudenaz Metin',
      year: '40',
      era: 'Roma',
      loves: 521,
      accent: ColorsCustom.gold,
    ),
    V2Memory(
      id: 'm5',
      title: 'Uzun Çarşı',
      neighborhood: 'Antakya Merkez',
      desc: 'Şehrin kalbi, 600 yıllık ticaret damarı.',
      contributor: 'Emre Gültekir',
      year: '1500',
      era: 'Osmanlı',
      loves: 298,
      accent: ColorsCustom.coral,
    ),
  ];

  static const news = <V2NewsItem>[
    V2NewsItem(
      id: 'n1',
      title: "Doğu Akdeniz'de Kuvvetli Yağış Uyarısı!",
      authorName: 'Hatay Haber',
      timeAgo: '2 saat önce',
      tag: 'GÜNDEM',
      excerpt:
          'Meteoroloji, Hatay genelinde önümüzdeki 48 saat içinde sağanak yağış bekliyor.',
      accent: ColorsCustom.teal,
    ),
    V2NewsItem(
      id: 'n2',
      title: "Hatay'da Üretici Zor Durumda",
      authorName: 'Mehmet Karanlık',
      timeAgo: '5 saat önce',
      tag: 'TARIM',
      excerpt:
          'Narenciye üreticileri, soğuk havalardan etkilenen mahsul için destek talep ediyor.',
      accent: ColorsCustom.olive,
    ),
    V2NewsItem(
      id: 'n3',
      title: "Habib-i Neccar Camii'nde Restorasyon Tamamlandı",
      authorName: 'Hatay Haber',
      timeAgo: '1 gün önce',
      tag: 'TARİH',
      excerpt:
          "Anadolu'nun ilk camisinin restorasyonu üç yılın ardından tamamlandı.",
      accent: ColorsCustom.gold,
    ),
  ];

  static const events = <V2Event>[
    V2Event(
      id: 'e1',
      title: 'Künefe Festivali',
      day: '04',
      month: 'MAY',
      weekday: 'Cmt',
      time: '18:00',
      place: 'Uzun Çarşı',
      district: 'Antakya',
      going: 234,
      category: 'Festival',
      desc: "Hatay'ın 12 ustasından geleneksel künefe yarışması.",
      accent: ColorsCustom.coral,
    ),
    V2Event(
      id: 'e2',
      title: 'Habib-i Neccar Anma Töreni',
      day: '06',
      month: 'ŞUB',
      weekday: 'Sal',
      time: '14:30',
      place: 'Cami Avlusu',
      district: 'Antakya',
      going: 89,
      category: 'Anma',
      desc: '2023 depreminde kaybettiklerimizi anıyoruz.',
      accent: ColorsCustom.gold,
    ),
    V2Event(
      id: 'e3',
      title: 'Hatay Kitap Günleri',
      day: '22',
      month: 'NİS',
      weekday: 'Sal',
      time: '10:00',
      place: 'Expo Center',
      district: 'Antakya',
      going: 412,
      category: 'Kültür',
      desc: '40 yayınevi, söyleşiler, çocuk atölyeleri.',
      accent: ColorsCustom.teal,
    ),
    V2Event(
      id: 'e4',
      title: 'Samandağ Plajı Temizlik',
      day: '11',
      month: 'MAY',
      weekday: 'Cmt',
      time: '09:00',
      place: 'Çevlik Plajı',
      district: 'Samandağ',
      going: 67,
      category: 'Gönüllü',
      desc: 'Kıyıyı temizliyoruz.',
      accent: ColorsCustom.olive400,
    ),
  ];

  static const notifications = <V2Notification>[
    V2Notification(
      id: 'nt1',
      kind: V2NotifKind.place,
      title: 'Yeni mekan eklendi',
      body: 'ALTINÖZ KUYUMCULUK, Antakya ilçesinde hizmet vermeye başladı.',
      date: '15 Nisan 2026',
      read: false,
    ),
    V2Notification(
      id: 'nt2',
      kind: V2NotifKind.event,
      title: 'Yaklaşan etkinlik',
      body: "Künefe Festivali yarın 18:00'de başlıyor.",
      date: '14 Nisan 2026',
      read: false,
    ),
    V2Notification(
      id: 'nt3',
      kind: V2NotifKind.memory,
      title: 'Hatıraya beğeni geldi',
      body:
          "Yasin Şenocak senin paylaştığın 'Affan Kahvesi' hatırasını beğendi.",
      date: '13 Nisan 2026',
      read: true,
    ),
    V2Notification(
      id: 'nt4',
      kind: V2NotifKind.place,
      title: 'Yeni mekan eklendi',
      body: 'DOBBY PET MARKET, Antakya ilçesinde hizmet vermeye başladı.',
      date: '13 Nisan 2026',
      read: true,
    ),
    V2Notification(
      id: 'nt5',
      kind: V2NotifKind.system,
      title: "Topluluk milestone'u",
      body: "500 mekan sınırını aştık! Hatay'ı birlikte yaşatıyoruz.",
      date: '30 Mart 2026',
      read: true,
    ),
  ];

  static const categories = <V2Category>[
    V2Category(id: 'all', label: 'Tümü', icon: Icons.apps_rounded),
    V2Category(
      id: 'rest',
      label: 'Yemek',
      icon: Icons.restaurant_rounded,
    ),
    V2Category(id: 'cafe', label: 'Kafe', icon: Icons.local_cafe_rounded),
    V2Category(
      id: 'hist',
      label: 'Tarihî',
      icon: Icons.account_balance_rounded,
    ),
    V2Category(id: 'shop', label: 'Esnaf', icon: Icons.storefront_rounded),
    V2Category(
      id: 'sport',
      label: 'Spor',
      icon: Icons.sports_gymnastics_rounded,
    ),
    V2Category(id: 'edu', label: 'Eğitim', icon: Icons.school_rounded),
    V2Category(
      id: 'health',
      label: 'Sağlık',
      icon: Icons.medical_services_rounded,
    ),
    V2Category(id: 'beauty', label: 'Güzellik', icon: Icons.spa_rounded),
    V2Category(id: 'pet', label: 'Pet', icon: Icons.pets_rounded),
    V2Category(
      id: 'craft',
      label: 'El sanatı',
      icon: Icons.palette_rounded,
    ),
    V2Category(
      id: 'flower',
      label: 'Çiçekçi',
      icon: Icons.local_florist_rounded,
    ),
  ];

  static IconData iconForCategory(String categoryId) {
    return categories
        .firstWhere(
          (c) => c.id == categoryId,
          orElse: () => categories.first,
        )
        .icon;
  }
}
