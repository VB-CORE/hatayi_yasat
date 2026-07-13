import 'package:lifeclient/features/community/model/group_category_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_entry_model.dart';
import 'package:lifeclient/features/community/model/group_discussion_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/model/group_post_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';

/// Community feature'ının tek mock veri kaynağı.
// TODO(community): Firestore bağlanınca bu dosya silinecek.
final class CommunityMockData {
  const CommunityMockData._();

  static const saim = GroupMemberModel(
    id: 'mock-member-1',
    displayName: 'Saim Yıldırım',
    username: 'saimusta',
    role: GroupMemberRole.admin,
  );

  static const ahmet = GroupMemberModel(
    id: 'mock-member-2',
    displayName: 'Ahmet Altınöz',
    username: 'altinoz',
    role: GroupMemberRole.admin,
  );

  static const eylem = GroupMemberModel(
    id: 'mock-member-3',
    displayName: 'Eylem Akdeniz',
    username: 'eylemakdeniz',
  );

  static const zeynep = GroupMemberModel(
    id: 'mock-member-4',
    displayName: 'Zeynep Kara',
    username: 'zeynepkara',
    role: GroupMemberRole.admin,
  );

  static const mehmet = GroupMemberModel(
    id: 'mock-member-5',
    displayName: 'Mehmet Şanlı',
    username: 'mehmetusta',
    role: GroupMemberRole.admin,
  );

  static const deniz = GroupMemberModel(
    id: 'mock-member-6',
    displayName: 'Deniz Aydın',
    username: 'denizaydin',
    role: GroupMemberRole.admin,
  );

  static const hasan = GroupMemberModel(
    id: 'mock-member-7',
    displayName: 'Hasan Demir',
    username: 'hasandemir',
    role: GroupMemberRole.admin,
  );

  static const yasemin = GroupMemberModel(
    id: 'mock-member-8',
    displayName: 'Yasemin Ercan',
    username: 'yaseminercan',
  );

  static const currentMember = GroupMemberModel(
    id: 'mock-member-current',
    displayName: 'Hatay Gönüllüsü',
    username: 'hataygonullusu',
  );

  static const categories = [
    GroupCategoryModel(id: 'solidarity', name: 'Dayanışma'),
    GroupCategoryModel(id: 'tradesman', name: 'Esnaf'),
    GroupCategoryModel(id: 'neighborhood', name: 'Mahalle'),
    GroupCategoryModel(id: 'event', name: 'Etkinlik'),
    GroupCategoryModel(id: 'solidarityAid', name: 'Yardımlaşma'),
    GroupCategoryModel(id: 'culture', name: 'Kültür'),
  ];

  /// group-1: dolu, group-2: az içerik, group-3: boş, group-4: admin,
  /// group-5: kapalı.
  static List<GroupModel> get groups => [
    GroupModel(
      id: 'mock-group-1',
      name: 'Antakya Esnaf Dayanışması',
      description: 'Uzun Çarşı ve çevresi esnafının dayanışma ağı.',
      memberCount: 248,
      coverImageUrl: 'https://picsum.photos/seed/antakya-esnaf/400',
      createdAt: DateTime(2025, 1, 12),
      admins: const [saim, ahmet],
    ),
    GroupModel(
      id: 'mock-group-2',
      name: 'Defne Mahalle Komitesi',
      description: 'Defne mahalleleri için yardımlaşma ve iletişim.',
      memberCount: 96,
      coverImageUrl: 'https://picsum.photos/seed/defne-mahalle/400',
      createdAt: DateTime(2025, 2, 3),
      admins: const [zeynep],
    ),
    GroupModel(
      id: 'mock-group-3',
      name: 'Künefeciler Birliği',
      description: 'Antakya künefe ustaları — tarif ve usul paylaşımı.',
      memberCount: 42,
      createdAt: DateTime(2024, 11, 20),
      admins: const [mehmet],
    ),
    GroupModel(
      id: 'mock-group-4',
      name: 'Samandağ Gönüllüleri',
      description: 'Bölge için gönüllülük ve yardımlaşma çalışmaları.',
      memberCount: 131,
      coverImageUrl: 'https://picsum.photos/seed/samandag/400',
      createdAt: DateTime(2025, 3, 8),
      isCurrentUserAdmin: true,
      admins: const [deniz],
    ),
    GroupModel(
      id: 'mock-group-5',
      name: 'Harbiye Üreticileri',
      description: 'Yerel üreticiler arası kapalı iletişim ve sipariş ağı.',
      memberCount: 57,
      type: GroupType.closed,
      createdAt: DateTime(2025, 4, 15),
      admins: const [hasan],
    ),
  ];

  static List<GroupPostModel> postsOf(String groupId) => switch (groupId) {
    'mock-group-1' => [
      GroupPostModel(
        id: 'mock-post-1-1',
        author: saim,
        content:
            "Cumartesi sabahı çarşı temizliği için 08:00'de buluşuyoruz. "
            'Eldiven ve poşetleri dernek karşılıyor 🤍',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        imageUrl: 'https://picsum.photos/seed/carsi-temizlik/600/300',
        likeCount: 34,
        commentCount: 8,
      ),
      GroupPostModel(
        id: 'mock-post-1-2',
        author: eylem,
        content:
            'Yeni açtığımız stant için teşekkürler, ilk gün çok güzeldi. '
            'Destek olan herkese minnettarız.',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likeCount: 12,
        commentCount: 3,
      ),
    ],
    'mock-group-2' => [
      GroupPostModel(
        id: 'mock-post-2-1',
        author: zeynep,
        content:
            'Mahalle kahvaltısı bu pazar parkta — herkes bir şey getirsin.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likeCount: 21,
        commentCount: 5,
      ),
    ],
    'mock-group-4' => [
      GroupPostModel(
        id: 'mock-post-4-1',
        author: deniz,
        content:
            'Hafta sonu fidan dikimi için buluşma noktası belediye önü, '
            '09:30.',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        likeCount: 18,
        commentCount: 4,
      ),
    ],
    'mock-group-5' => [
      GroupPostModel(
        id: 'mock-post-5-1',
        author: hasan,
        content: 'Bu haftaki sipariş listesi güncellendi, kontrol edin.',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        likeCount: 7,
        commentCount: 2,
      ),
    ],
    _ => const [],
  };

  static List<GroupDiscussionModel> discussionsOf(String groupId) =>
      switch (groupId) {
        'mock-group-1' => [
          GroupDiscussionModel(
            id: 'mock-discussion-1-1',
            title: 'Cumartesi pazarı yeni yer düzeni',
            author: saim,
            createdAt: DateTime.now().subtract(const Duration(hours: 3)),
            entries: [
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-1-1',
                author: saim,
                content:
                    'Bu konuyu açtım çünkü mevcut yerleşim dar geliyor. '
                    'Köşe stantları ana giriş yerine yan sokağa alalım derim.',
                createdAt: DateTime.now().subtract(const Duration(hours: 3)),
              ),
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-1-2',
                author: ahmet,
                content:
                    'Katılıyorum. Yan sokak daha geniş ve gölge var, yazın '
                    'daha rahat olur.',
                createdAt: DateTime.now().subtract(const Duration(hours: 2)),
              ),
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-1-3',
                author: eylem,
                content:
                    'Ana girişe karşılama + bilgi standı koyalım, ziyaretçi '
                    'yönlendirmesi kolaylaşır.',
                createdAt: DateTime.now().subtract(const Duration(hours: 1)),
              ),
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-1-4',
                author: yasemin,
                content:
                    'Elektrik prizleri sadece duvar tarafında, o yüzden '
                    'elektrik gerektiren standları oraya yakın planlamalıyız.',
                createdAt: DateTime.now().subtract(
                  const Duration(minutes: 34),
                ),
              ),
            ],
          ),
          GroupDiscussionModel(
            id: 'mock-discussion-1-2',
            title: 'Ortak tedarikçi anlaşması',
            author: ahmet,
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            entries: [
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-2-1',
                author: ahmet,
                content:
                    'Toplu alımda indirim almak için tek tedarikçi üzerinden '
                    'anlaşalım mı?',
                createdAt: DateTime.now().subtract(const Duration(days: 1)),
              ),
            ],
          ),
          GroupDiscussionModel(
            id: 'mock-discussion-1-3',
            title: 'Festival hazırlık komitesi',
            author: saim,
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
            entries: [
              GroupDiscussionEntryModel(
                id: 'mock-entry-1-3-1',
                author: saim,
                content: 'Komiteye katılmak isteyenler buraya yazsın.',
                createdAt: DateTime.now().subtract(const Duration(days: 2)),
              ),
            ],
          ),
        ],
        'mock-group-4' => [
          GroupDiscussionModel(
            id: 'mock-discussion-4-1',
            title: 'Fidan dikimi malzeme listesi',
            author: deniz,
            createdAt: DateTime.now().subtract(const Duration(hours: 6)),
            entries: [
              GroupDiscussionEntryModel(
                id: 'mock-entry-4-1-1',
                author: deniz,
                content:
                    'Eldiven ve kürek dernekte var; su bidonunu kim '
                    'getirebilir?',
                createdAt: DateTime.now().subtract(const Duration(hours: 6)),
              ),
            ],
          ),
        ],
        _ => const [],
      };
}
