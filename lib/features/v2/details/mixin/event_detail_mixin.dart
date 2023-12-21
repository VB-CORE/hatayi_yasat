import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/event_detail_view.dart';

mixin EventDetailMixin on ConsumerState<EventDetailView> {
  // TODO: replace with parameter from constructor
  late final CampaignModel eventModel;

  @override
  void initState() {
    super.initState();
    eventModel = widget.event;
  }

  Future<void> goBackAction() async {
    // TODO: implement goBackAction for click back button
  }

  Future<void> joinNowAction() async {
    // TODO: implement joinNowAction for click join now button
  }
}
