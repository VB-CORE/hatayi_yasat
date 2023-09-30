import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/campaign_module/campaigns/model/campaing_empty_model.dart';
import 'package:vbaseproject/product/utility/extension/date_time_extension.dart';

import 'package:vbaseproject/product/utility/state/product_provider.dart';

class CampaignsViewModel extends StateNotifier<CampaignsState> {
  CampaignsViewModel({
    required ProductProvider productProvider,
    required CustomService customService,
  })  : _productProvider = productProvider,
        _customService = customService,
        super(const CampaignsState());
  final ProductProvider _productProvider;
  final CustomService _customService;

  Future<void> fetchNonExpiredItemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);

    final allItems = await _customService.getList<CampaignModel>(
      model: CampaignEmptyModel.empty,
      path: CollectionPaths.approvedCampaigns,
    );

    final nonExpiredItems = allItems.where((CampaignModel campaign) {
      return campaign.expireDate?.isNotExpired ?? false;
    }).toList();
    _productProvider.saveCampaigns(nonExpiredItems);
    state = state.copyWith(
      isServiceRequestSending: false,
      campaignsItems: nonExpiredItems,
    );
  }
}

@immutable
class CampaignsState extends Equatable {
  const CampaignsState({
    this.isServiceRequestSending = false,
    this.campaignsItems = const [],
  });
  final bool isServiceRequestSending;
  final List<CampaignModel> campaignsItems;

  bool get isEnabled => !isServiceRequestSending && campaignsItems.isNotEmpty;

  @override
  List<Object> get props => [isServiceRequestSending, campaignsItems];

  CampaignsState copyWith({
    bool? isServiceRequestSending,
    List<CampaignModel>? campaignsItems,
  }) {
    return CampaignsState(
      isServiceRequestSending:
          isServiceRequestSending ?? this.isServiceRequestSending,
      campaignsItems: campaignsItems ?? this.campaignsItems,
    );
  }
}
