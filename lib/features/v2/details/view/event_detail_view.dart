import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/mixin/event_detail_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lenghts.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/extension/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithBackButtonStack(
                image: eventModel.photo ?? '',
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.all(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CircleAvatarWithText(
                      publisherName: eventModel.publisher ?? '',
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    GeneralSubTitle(
                      value: eventModel.name ?? '',
                      fontWeight: FontWeight.w900,
                      maxLine: TextFieldMaxLengths.maxLineForText,
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    _DateAndAddressRow(projectModel: eventModel),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    _TitleDescription.topic(topic: eventModel.topic ?? ''),
                    context.sized.emptySizedHeightBoxNormal,
                    _TitleDescription.description(
                      description: eventModel.description ?? '',
                    ),
                    context.sized.emptySizedHeightBoxNormal,
                    _JoinNowButton(onPressed: joinNowAction),
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
