import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/mixin/news_detail_view_mixin.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/icon/icon_with_text.dart';

part '../sub_view/news_detail_sub_view.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithButtonAndNameStack(
                image: ''.ext.randomImage,
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.all(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.sized.emptySizedHeightBoxLow,
                    GeneralSubTitle(
                      value: news.title ?? '',
                      fontWeight: FontWeight.w900,
                    ),
                    IconWithText(
                      icon: AppIcons.calendar,
                      title: DateFormat.yMMMEd().format(
                        news.createdAt ?? DateTime.now(),
                      ),
                      color:
                          context.general.colorScheme.primary.withOpacity(0.7),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    context.sized.emptySizedHeightBoxLow,
                    GeneralBodyTitle(
                      news.content ?? '',
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
