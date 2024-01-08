import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/model/campaign_empty_model.dart';
import 'package:vbaseproject/features/v2/event/provider/event_state.dart';

part 'event_view_model.g.dart';

@riverpod
final class EventViewModel extends _$EventViewModel
    with ProjectDependencyMixin {
  @override
  EventState build() {
    return const EventState();
  }

  CollectionReference<CampaignModel?> fetchCampaignCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.approvedCampaigns,
      CampaignEmptyModel.empty,
    );
  }
}
