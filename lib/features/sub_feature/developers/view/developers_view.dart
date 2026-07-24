import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/sub_feature/developers/provider/developers_state.dart';
import 'package:lifeclient/features/sub_feature/developers/provider/developers_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/bubble/bubble_chart.dart';
import 'package:lifeclient/product/widget/bubble/bubble_data.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

part 'widget/developers_grid_builder.dart';
part 'widget/soft_arc_mosaic.dart';

final class DevelopersView extends ConsumerStatefulWidget {
  const DevelopersView({super.key});

  @override
  ConsumerState<DevelopersView> createState() => _DevelopersViewState();
}

final class _DevelopersViewState extends ConsumerState<DevelopersView>
    with AppProviderMixin<DevelopersView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(developersViewModelProvider);
    final onRetry = ref
        .read(developersViewModelProvider.notifier)
        .fetchDevelopers;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PageAppBar(
        pageTitle: LocaleKeys.developers_title,
      ),
      body: switch (state) {
        DevelopersState(isFetching: true) => const PlaceShimmerList(),
        DevelopersState(isError: true) => GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
          onRefresh: onRetry,
        ),
        DevelopersState(:final developers) => _DevelopersBubbleChart(
          developers: developers,
        ),
      },
    );
  }
}
