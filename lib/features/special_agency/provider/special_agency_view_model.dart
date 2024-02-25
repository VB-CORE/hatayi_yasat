import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/special_agency/provider/special_agency_state.dart';

part 'special_agency_view_model.g.dart';

@riverpod
final class SpecialAgencyViewModel extends _$SpecialAgencyViewModel
    with ProjectDependencyMixin {
  @override
  SpecialAgencyState build() {
    return const SpecialAgencyState();
  }

  CollectionReference<SpecialAgencyModel?> fetchAgencyCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.specialAgency,
      SpecialAgencyModel(),
    );
  }
}
