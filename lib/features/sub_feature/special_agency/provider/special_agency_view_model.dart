import 'package:collection/collection.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/special_agency/provider/special_agency_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'special_agency_view_model.g.dart';

@riverpod
final class SpecialAgencyViewModel extends _$SpecialAgencyViewModel
    with ProjectDependencyMixin {
  @override
  SpecialAgencyState build() {
    return const SpecialAgencyState();
  }

  Future<void> fetchAgencyCollectionReference(List<TownModel> townList) async {
    final townNamesAndAgency = <String, List<SpecialAgencyModel>>{};
    final specialAgencyList = await firebaseService.getList<SpecialAgencyModel>(
      model: SpecialAgencyModel(),
      path: CollectionPaths.specialAgency,
    );

    for (final model in specialAgencyList) {
      final townModel = townList.firstWhereOrNull(
        (element) => element.code == model.townCode,
      );

      townNamesAndAgency.putIfAbsent(
        townModel?.name ?? '',
        () => <SpecialAgencyModel>[],
      );
      townNamesAndAgency[townModel?.name ?? '']!.add(model);
    }
    state = state.copyWith(townNamesAndAgency: townNamesAndAgency);
  }
}
