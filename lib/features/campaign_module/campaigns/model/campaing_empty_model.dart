import 'package:life_shared/life_shared.dart';

final class CampaignEmptyModel {
  const CampaignEmptyModel._();
  static CampaignModel empty = CampaignModel(
    name: '',
    topic: '',
    description: '',
    publisher: '',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    photo: '',
    coverPhoto: '',
    isApproved: true,
  );
}
