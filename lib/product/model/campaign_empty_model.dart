import 'package:life_shared/life_shared.dart';

final class CampaignEmptyModel {
  const CampaignEmptyModel._();
  static CampaignModel empty = CampaignModel(
    name: '',
    topic: '',
    description: '',
    publisher: '',
    expireDate: DateTime.now(),
    photo: '',
    coverPhoto: '',
    isApproved: true,
  );
}
