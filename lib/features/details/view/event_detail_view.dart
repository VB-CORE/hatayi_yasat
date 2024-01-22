import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/details/mixin/event_detail_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/extension/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/general/title/general_content_small_title.dart';
import 'package:vbaseproject/product/widget/image/custom_image_with_view_dialog.dart';
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.general.colorScheme.primary,
        ),
        leading: const CloseButton(),
        actions: [
          IconButton(
            onPressed: callUser,
            icon: const Icon(AppIcons.phone),
          ),
          IconButton(
            onPressed: sendAMessageWithPhone,
            icon: const Icon(AppIcons.sendMessage),
          ),
          _ShareAddressButton(model: eventModel),
        ],
      ),
      bottomNavigationBar: _BottomButton(
        onAddedReminder: addReminderAction,
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

class _BottomButton extends StatelessWidget {
  const _BottomButton({required this.onAddedReminder});

  final VoidCallback onAddedReminder;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontalSymmetric() +
              const PagePadding.vertical6Symmetric(),
          child: GeneralButtonV2.async(
            label: LocaleKeys.campaignDetailsView_addReminderButton.tr(),
            action: () async {
              onAddedReminder.call();
            },
          ),
        ),
      ),
    );
  }
}

final class _ShareAddressButton extends StatelessWidget {
  const _ShareAddressButton({
    required this.model,
  });

  final CampaignModel model;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        '${model.name} ${model.description} ${model.expireDate}'.ext.share();
      },
      child: Icon(
        AppIcons.share,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
