import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/event/provider/event_state.dart';
import 'package:vbaseproject/product/model/campaign_empty_model.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';

part 'event_view_model.g.dart';

@riverpod
final class EventViewModel extends _$EventViewModel
    with ProjectDependencyMixin {
  @override
  EventState build() {
    return const EventState();
  }

  Query<CampaignModel?> fetchCampaignQuery() {
    return firebaseService
        .collectionReference(
          CollectionPaths.approvedCampaigns,
          CampaignEmptyModel.empty,
        )
        .where(
          StringConstants.expireDate,
          isGreaterThanOrEqualTo: DateTime.now(),
        );
  }
}
