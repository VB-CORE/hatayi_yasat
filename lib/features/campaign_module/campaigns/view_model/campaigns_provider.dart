import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
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

  Future<void> fetchNonExpiredtemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);
    final allItems = await _customService.getList<CampaignModel>(
      model: CampaignModel.empty(),
      path: CollectionPaths.approvedCampaigns,
    );

    final nonExpiredItems = allItems.where((campaing) {
      return campaing.endDate?.isNotExpired ?? false;
    }).toList();

    _productProvider.saveCampaigns(nonExpiredItems);
    state = state.copyWith(
      isServiceRequestSending: false,
      items: nonExpiredItems,
    );
  }
}

@immutable
class CampaignsState extends Equatable {
  const CampaignsState({
    this.isServiceRequestSending = false,
    this.projectItems = const [],
  });
  final bool isServiceRequestSending;
  final List<CampaignModel> projectItems;

  bool get isEnabled => !isServiceRequestSending && projectItems.isNotEmpty;

  @override
  List<Object> get props => [isServiceRequestSending, projectItems];

  CampaignsState copyWith({
    bool? isServiceRequestSending,
    List<CampaignModel>? items,
  }) {
    return CampaignsState(
      isServiceRequestSending:
          isServiceRequestSending ?? this.isServiceRequestSending,
      projectItems: items ?? projectItems,
    );
  }
}
