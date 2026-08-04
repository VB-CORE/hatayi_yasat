import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/details/mixin/news_detail_view_mixin.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_bookmark_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/image/custom_image_with_view_dialog.dart';

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
    final hasBody = news.content?.isNotEmpty ?? false;
    final isBookmarked = ref.watch(
      newsBookmarkViewModelProvider(news.documentId).select(
        (state) => state.isSaved,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.notification_typeNews.tr()),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(newsBookmarkViewModelProvider(news.documentId).notifier)
                .toggle(news),
            icon: Icon(
              isBookmarked ? AppIcons.bookmark : AppIcons.bookmarkBorder,
            ),
          ),
          IconButton(
            onPressed: shareNews,
            icon: const Icon(AppIcons.share),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacing.screenH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.lg),
                Text(
                  news.title ?? '',
                  maxLines: TextFieldMaxLengths.maxLine,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: context.general.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w100,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                if (news.createdAt case final date?) _NewsMetaRow(date: date),
                const SizedBox(height: AppSpacing.xl),
                Hero(
                  tag: ValueKey(news.documentId),
                  child: ClipRRect(
                    borderRadius: AppRadius.card,
                    child: CustomImageWithViewDialog(image: news.image),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                if (hasBody)
                  _SelectableContentText(content: news.content!)
                else
                  GeneralContentSubTitle(
                    value: LocaleKeys.notFound_newsContent.tr(),
                  ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
