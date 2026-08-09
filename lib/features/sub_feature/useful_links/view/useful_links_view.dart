import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/useful_links/provider/useful_links_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/widget/app_bar/discover_section_app_bar.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/button/outline_action_button.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/useful_link_card.dart';

@immutable
final class UsefulLinksView extends ConsumerWidget {
  const UsefulLinksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(
      usefulLinksViewModelProvider.select((state) => state.count),
    );

    return GeneralScaffold(
      appBar: DiscoverSectionAppBar(
        title: LocaleKeys.usefulLink_title,
        subtitle: LocaleKeys.usefulLink_subtitle.tr(args: [count.toString()]),
        accentColor: context.appColors.olive,
      ),
      body: const _UsefulLinksListBuilder(),
    );
  }
}

@immutable
final class _UsefulLinksListBuilder extends ConsumerWidget {
  const _UsefulLinksListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(usefulLinksViewModelProvider.notifier)
        .fetchLinksCollectionReference();

    return GeneralFirestoreListView(
      query: query,
      itemBuilder: (context, model) {
        return Padding(
          padding:
              const PagePadding.horizontal16Symmetric() +
              const PagePadding.vertical8Symmetric(),
          child: _LinkCard(link: model),
        );
      },
      onRetry: () {},
      emptyBuilder: (context) {
        return GeneralNotFoundWidget(
          title: LocaleKeys.notFound_usefulLinks.tr(),
        );
      },
    );
  }
}
