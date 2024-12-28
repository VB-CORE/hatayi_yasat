import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'regional_town_model.g.dart';

@JsonSerializable()
final class RegionalTownModel extends BaseFirebaseModel<RegionalTownModel>
    with EquatableMixin, BaseDropDownModel {
  const RegionalTownModel({
    this.documentId = '',
    this.cityId = '',
    this.towns = const [],
  });

  const RegionalTownModel.empty()
      : this(
          documentId: '',
          cityId: '',
          towns: const [],
        );

  @override
  final String documentId;
  final String cityId;
  final List<RegionalTownSubItem> towns;
  @override
  Map<String, dynamic> toJson() => _$RegionalTownModelToJson(this);

  @override
  List<Object?> get props => [
        towns,
        documentId,
        cityId,
      ];

  RegionalTownModel copyWith({
    List<RegionalTownSubItem>? towns,
    String? documentId,
    String? cityId,
  }) {
    return RegionalTownModel(
      towns: towns ?? this.towns,
      documentId: documentId ?? this.documentId,
      cityId: cityId ?? this.cityId,
    );
  }

  @override
  RegionalTownModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data();
    if (data == null) return const RegionalTownModel.empty();

    return _$RegionalTownModelFromJson(data).copyWith(
      documentId: json.id,
    );
  }

  @override
  RegionalTownModel fromJson(Map<String, dynamic> json) {
    return _$RegionalTownModelFromJson(json);
  }

  @override
  String get displayName => '';
}

@JsonSerializable()
final class RegionalTownSubItem extends Equatable with BaseDropDownModel {
  const RegionalTownSubItem({required this.code, required this.name});

  factory RegionalTownSubItem.fromJson(Map<String, dynamic> json) =>
      _$RegionalTownSubItemFromJson(json);

  final int code;
  final String name;

  TownModel get toTownModel => TownModel(
        code: code,
        name: name,
      );

  Map<String, dynamic> toJson() => _$RegionalTownSubItemToJson(this);

  @override
  List<Object?> get props => [code, name];

  @override
  String get displayName => name;
}
