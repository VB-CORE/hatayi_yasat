import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/details/view/event_detail_view.dart';
import 'package:vbaseproject/product/package/calendar/calendar_model.dart';
import 'package:vbaseproject/product/package/calendar/calendar_utility.dart';
import 'package:vbaseproject/product/utility/constants/string_constants.dart';

mixin EventDetailMixin on ConsumerState<EventDetailView> {
  late final CampaignModel eventModel;

  late final bool _phoneIsAvailable;

  bool get phoneIsAvailable => _phoneIsAvailable;

  @override
  void initState() {
    super.initState();
    eventModel = widget.event;
    checkPhoneIsAvailable();
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

  void checkPhoneIsAvailable() {
    final phoneNumber = eventModel.phone;
    if (phoneNumber.ext.isNullOrEmpty ||
        phoneNumber.ext.phoneFormatValue ==
            StringConstants.tenDigitZeroPhoneNumber) {
      _phoneIsAvailable = false;
      return;
    }
    _phoneIsAvailable = true;
  }

  Future<void> redirectWhatsapp() async {
    final formattedPhoneNumber = eventModel.phone.ext.phoneFormatValue;
    await formattedPhoneNumber.ext.shareWhatsApp();
  }
}
