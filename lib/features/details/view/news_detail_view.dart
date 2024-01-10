import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/details/mixin/news_detail_view_mixin.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/icon/icon_with_text.dart';
import 'package:vbaseproject/product/widget/image/custom_image_with_view_dialog.dart';
import 'package:vbaseproject/product/widget/special/user_special_card.dart';

part 'widget/news_detail_sub_view.dart';

final class NewsDetailView extends ConsumerStatefulWidget {
  const NewsDetailView({required this.news, super.key});
  final NewsModel news;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends ConsumerState<NewsDetailView>
    with NewsDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithButtonAndNameStack(
                image: news.image ?? '',
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.horizontalSymmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const PagePadding.onlyTopMedium(),
                      child: GeneralSubTitle(
                        value: news.title ?? '',
                        fontWeight: FontWeight.w900,
                        maxLine: TextFieldMaxLengths.maxLine,
                      ),
                    ),
                    Padding(
                      padding: const PagePadding.onlyTopMedium(),
                      child: _DateIconAndText(date: news.createdAt),
                    ),
                    const Padding(
                      padding: PagePadding.onlyTopMedium(),
                      child: UserSpecialCard(user: SpecialUser.creator),
                    ),
                    Padding(
                      padding: const PagePadding.onlyTopMedium(),
                      child:
                          _SelectableContentText(content: news.content ?? ''),
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
