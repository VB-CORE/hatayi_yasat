// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_group_member_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Topluluk ekranlarının ortak "oturumdaki üye" kaynağı. Yetkilendirme bilgisi
/// modellerde taşınmaz; grup yöneticiliği bu üye ile grubun yönetici listesi
/// karşılaştırılarak türetilir.
// TODO(community): Firestore servis PR'ında mock fallback kaldırılacak.

@ProviderFor(currentGroupMember)
final currentGroupMemberProvider = CurrentGroupMemberProvider._();

/// Topluluk ekranlarının ortak "oturumdaki üye" kaynağı. Yetkilendirme bilgisi
/// modellerde taşınmaz; grup yöneticiliği bu üye ile grubun yönetici listesi
/// karşılaştırılarak türetilir.
// TODO(community): Firestore servis PR'ında mock fallback kaldırılacak.

final class CurrentGroupMemberProvider
    extends
        $FunctionalProvider<
          GroupMemberModel,
          GroupMemberModel,
          GroupMemberModel
        >
    with $Provider<GroupMemberModel> {
  /// Topluluk ekranlarının ortak "oturumdaki üye" kaynağı. Yetkilendirme bilgisi
  /// modellerde taşınmaz; grup yöneticiliği bu üye ile grubun yönetici listesi
  /// karşılaştırılarak türetilir.
  // TODO(community): Firestore servis PR'ında mock fallback kaldırılacak.
  CurrentGroupMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentGroupMemberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentGroupMemberHash();

  @$internal
  @override
  $ProviderElement<GroupMemberModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GroupMemberModel create(Ref ref) {
    return currentGroupMember(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupMemberModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupMemberModel>(value),
    );
  }
}

String _$currentGroupMemberHash() =>
    r'f06012a0ec7402be1c7cd61aa8730b9fdc12e8fc';
