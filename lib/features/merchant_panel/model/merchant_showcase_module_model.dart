import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type.dart';

part 'merchant_showcase_module_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class MerchantShowcaseModuleModel extends Equatable {
  const MerchantShowcaseModuleModel({
    required this.id,
    required this.type,
    required this.title,
    this.description = '',
    this.imageUrl,
    this.startAt,
    this.endAt,
    this.isActive = true,
    this.order = 0,
  });

  factory MerchantShowcaseModuleModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantShowcaseModuleModelFromJson(json);

  final String id;

  @JsonKey(
    fromJson: MerchantShowcaseType.fromValue,
    toJson: _typeToJson,
  )
  final MerchantShowcaseType type;

  final String title;
  final String description;
  final String? imageUrl;
  final bool isActive;
  final int order;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? startAt;

  @JsonKey(
    toJson: FirebaseTimeParse.dateTimeToTimestamp,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? endAt;

  bool get isPublished {
    if (!isActive) return false;
    final end = endAt;
    if (end == null) return true;
    final now = DateTime.now();
    return !end.isBefore(DateTime(now.year, now.month, now.day));
  }

  Map<String, dynamic> toJson() => _$MerchantShowcaseModuleModelToJson(this);

  MerchantShowcaseModuleModel copyWith({
    String? id,
    MerchantShowcaseType? type,
    String? title,
    String? description,
    String? imageUrl,
    DateTime? startAt,
    DateTime? endAt,
    bool? isActive,
    int? order,
    bool clearImageUrl = false,
    bool clearStartAt = false,
    bool clearEndAt = false,
  }) {
    return MerchantShowcaseModuleModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: clearImageUrl ? null : imageUrl ?? this.imageUrl,
      startAt: clearStartAt ? null : startAt ?? this.startAt,
      endAt: clearEndAt ? null : endAt ?? this.endAt,
      isActive: isActive ?? this.isActive,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    imageUrl,
    startAt,
    endAt,
    isActive,
    order,
  ];
}

String _typeToJson(MerchantShowcaseType type) => type.value;
