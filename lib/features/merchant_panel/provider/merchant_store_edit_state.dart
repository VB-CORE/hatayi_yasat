import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_photo.dart';

final class MerchantStoreEditState extends Equatable {
  const MerchantStoreEditState({
    this.photos = const [],
    this.category,
    this.openTime,
    this.closeTime,
    this.isCommentEnabled = true,
    this.isSaving = false,
    this.isError = false,
    this.isDirty = false,
  });

  final List<MerchantPhoto> photos;
  final CategoryModel? category;
  final String? openTime;
  final String? closeTime;
  final bool isCommentEnabled;
  final bool isSaving;
  final bool isError;
  final bool isDirty;

  bool get hasPhoto => photos.isNotEmpty;

  MerchantStoreEditState copyWith({
    List<MerchantPhoto>? photos,
    CategoryModel? category,
    String? openTime,
    String? closeTime,
    bool? isCommentEnabled,
    bool? isSaving,
    bool? isError,
    bool? isDirty,
    bool clearOpenTime = false,
    bool clearCloseTime = false,
  }) {
    return MerchantStoreEditState(
      photos: photos ?? this.photos,
      category: category ?? this.category,
      openTime: clearOpenTime ? null : openTime ?? this.openTime,
      closeTime: clearCloseTime ? null : closeTime ?? this.closeTime,
      isCommentEnabled: isCommentEnabled ?? this.isCommentEnabled,
      isSaving: isSaving ?? this.isSaving,
      isError: isError ?? this.isError,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  @override
  List<Object?> get props => [
    photos,
    category,
    openTime,
    closeTime,
    isCommentEnabled,
    isSaving,
    isError,
    isDirty,
  ];
}
