import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';
import 'package:vbaseproject/features/v2/details/mixin/project_detail_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/extension/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/general/title/general_content_small_title.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';

part '../sub_view/project_detail_sub_view.dart';

final class ProjectDetailView extends ConsumerStatefulWidget {
  const ProjectDetailView({
    required this.project,
    super.key,
  });

  final RequestProjectModel project;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectDetailViewState();
}

class _ProjectDetailViewState extends ConsumerState<ProjectDetailView>
    with ProjectDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithBackButtonStack(
                image: ''.ext.randomImage,
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.all(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CircleAvatarWithText(
                      publisherName: projectModel.publisher,
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    GeneralSubTitle(
                      value: projectModel.projectName,
                      fontWeight: FontWeight.w900,
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    _DateAndAddressRow(projectModel: projectModel),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    _TitleDescription.topic(topic: projectModel.projectTopic),
                    context.sized.emptySizedHeightBoxNormal,
                    _TitleDescription.description(
                      description: projectModel.projectDescription,
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
