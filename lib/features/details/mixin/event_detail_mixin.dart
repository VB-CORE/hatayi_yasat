import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifeclient/features/details/view/event_detail_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/calendar/calendar_model.dart';
import 'package:lifeclient/product/package/calendar/calendar_utility.dart';
import 'package:lifeclient/product/utility/formatter/phone_formatter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

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

  String get _phoneNumber => PhoneFormatter.format(eventModel.phone);

  void callUser() {
    if (_phoneNumber.isEmpty) return;

    _phoneNumber.ext.launchPhone;
  }

  void sendAMessageWithPhone() {
    if (_phoneNumber.isEmpty) return;
    launchUrl(
      WhatsAppUnilink(
        phoneNumber: _phoneNumber,
        text: LocaleKeys.advertise_openEventDetailPhone
            .tr(args: [eventModel.name ?? '']),
      ).asUri(),
      mode: LaunchMode.externalApplication,
    );
  }
}
