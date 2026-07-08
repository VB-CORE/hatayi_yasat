import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_member_role.dart';
import 'package:lifeclient/features/community/model/group_type.dart';

final class GroupModel extends Equatable {
  const GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    this.coverImageUrl,
    this.type = GroupType.open,
    this.createdAt,
    this.admins = const [],
    this.isCurrentUserAdmin = false,
  });

  final String id;
  final String name;
  final String description;
  final int memberCount;
  final String? coverImageUrl;
  final GroupType type;
  final DateTime? createdAt;
  final List<GroupMemberModel> admins;

  // TODO(community): Gerçek backend'de üyelik verisinden türeyecek.
  final bool isCurrentUserAdmin;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    memberCount,
    coverImageUrl,
    type,
    createdAt,
    admins,
    isCurrentUserAdmin,
  ];

  GroupModel copyWith({
    String? id,
    String? name,
    String? description,
    int? memberCount,
    String? coverImageUrl,
    GroupType? type,
    DateTime? createdAt,
    List<GroupMemberModel>? admins,
    bool? isCurrentUserAdmin,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      memberCount: memberCount ?? this.memberCount,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      admins: admins ?? this.admins,
      isCurrentUserAdmin: isCurrentUserAdmin ?? this.isCurrentUserAdmin,
    );
  }

  // TODO(community): Firestore groups koleksiyonu hazır olunca kaldırılacak.
  static List<GroupModel> get mockItems => [
    GroupModel(
      id: 'mock-group-1',
      name: 'Antakya Esnaf Dayanışması',
      description: 'Uzun Çarşı ve çevresi esnafının dayanışma ağı.',
      memberCount: 248,
      coverImageUrl: 'https://picsum.photos/seed/antakya-esnaf/400',
      createdAt: DateTime(2025, 1, 12),
      admins: const [
        GroupMemberModel(
          id: 'mock-member-1',
          displayName: 'Saim Yıldırım',
          username: 'saimusta',
          role: GroupMemberRole.admin,
        ),
        GroupMemberModel(
          id: 'mock-member-2',
          displayName: 'Ahmet Altınöz',
          username: 'altinoz',
          role: GroupMemberRole.admin,
        ),
      ],
    ),
    const GroupModel(
      id: 'mock-group-2',
      name: 'Defne Mahalle Komitesi',
      description: 'Defne mahalleleri için yardımlaşma ve iletişim.',
      memberCount: 96,
      coverImageUrl: 'https://picsum.photos/seed/defne-mahalle/400',
    ),
    const GroupModel(
      id: 'mock-group-3',
      name: 'Künefeciler Birliği',
      description: 'Antakya künefe ustaları — tarif ve usul paylaşımı.',
      memberCount: 42,
      coverImageUrl: 'https://picsum.photos/seed/kunefe/400',
    ),
    const GroupModel(
      id: 'mock-group-4',
      name: 'Samandağ Gönüllüleri',
      description: 'Bölge için gönüllülük ve yardımlaşma çalışmaları.',
      memberCount: 131,
      coverImageUrl: 'https://picsum.photos/seed/samandag/400',
      isCurrentUserAdmin: true,
    ),
    const GroupModel(
      id: 'mock-group-5',
      name: 'Samandağ Gönüllüleri',
      description: 'Bölge için gönüllülük ve yardımlaşma çalışmaları.',
      memberCount: 131,
      coverImageUrl: 'https://picsum.photos/seed/samandag/400',
      isCurrentUserAdmin: true,
    ),
  ];
}
