import 'package:equatable/equatable.dart';

final class GroupCategoryModel extends Equatable {
  const GroupCategoryModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];

  // TODO(community): Firestore groups_categories koleksiyonu hazır olunca kaldırılacak.
  static List<GroupCategoryModel> get mockItems => const [
    GroupCategoryModel(id: 'solidarity', name: 'Dayanışma'),
    GroupCategoryModel(id: 'tradesman', name: 'Esnaf'),
    GroupCategoryModel(id: 'neighborhood', name: 'Mahalle'),
    GroupCategoryModel(id: 'event', name: 'Etkinlik'),
    GroupCategoryModel(id: 'solidarityAid', name: 'Yardımlaşma'),
    GroupCategoryModel(id: 'culture', name: 'Kültür'),
  ];
}
