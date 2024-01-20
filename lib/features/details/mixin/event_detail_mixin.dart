import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/details/view/event_detail_view.dart';
import 'package:vbaseproject/product/package/calendar/calendar_model.dart';
import 'package:vbaseproject/product/package/calendar/calendar_utility.dart';

mixin EventDetailMixin on ConsumerState<EventDetailView> {
  late final CampaignModel eventModel;

  @override
  void initState() {
    super.initState();
    eventModel = widget.event;
  }

  Future<void> goBackAction() async {
    context.pop();
  }

  Future<void> addReminderAction() async {
    CalendarUtility.saveCalendar(
      model: CalendarModel.fromCampaignModel(
        campaignModel: eventModel,
      ),
    );
  }

  void sendAMessageWithPhone() {
    final phoneNumber = eventModel.phone ?? '';
    if (phoneNumber.isEmpty) return;
    phoneNumber.ext.shareWhatsApp();
  }
}
