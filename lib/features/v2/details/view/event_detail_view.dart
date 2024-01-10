import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/mixin/event_detail_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/extension/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
import 'package:vbaseproject/product/widget/dialog/general_text_dialog.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/general/title/general_content_small_title.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';

part 'widget/event_detail_sub_view.dart';

final class EventDetailView extends ConsumerStatefulWidget {
  const EventDetailView({
    required this.event,
    super.key,
  });

  final CampaignModel event;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventDetailViewState();
}

class _EventDetailViewState extends ConsumerState<EventDetailView>
    with EventDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: SafeArea(
          child: Padding(
            padding: const PagePadding.horizontalSymmetric() +
                const PagePadding.vertical6Symmetric(),
            child: GeneralButtonV2.async(
              label: LocaleKeys.campaignDetailsView_seeOptionsButton.tr(),
              action: () => GeneralTextDialog.show(
                context,
                LocaleKeys.campaignDetailsView_optionsDialogTitle.tr(),
                LocaleKeys.campaignDetailsView_optionsDialogContent.tr(),
                [
                  GeneralDialogButton(
                    title: LocaleKeys.campaignDetailsView_addReminderButton,
                    onPressed: addReminderAction,
                  ),
                  GeneralDialogButton(
                    title:
                        LocaleKeys.campaignDetailsView_redirectWhatsappButton,
                    onPressed: redirectWhatsapp,
                  ).ext.toDisabled(disable: !phoneIsAvailable),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithBackButtonStack(
                image: eventModel.coverPhoto ?? '',
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.defaultPadding() +
                    const PagePadding.onlyTopMedium(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CircleAvatarWithText(
                      publisherName: eventModel.publisher ?? '',
                    ),
                    Padding(
                      padding: const PagePadding.onlyTop(),
                      child: GeneralSubTitle(
                        value: eventModel.name ?? '',
                        fontWeight: FontWeight.w900,
                        maxLine: TextFieldMaxLengths.maxLine,
                      ),
                    ),
                    Padding(
                      padding: const PagePadding.onlyTopMedium(),
                      child: _DateAndAddressRow(projectModel: eventModel),
                    ),
                    _TitleDescription.topic(topic: eventModel.topic ?? ''),
                    _TitleDescription.description(
                      description: eventModel.description ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
