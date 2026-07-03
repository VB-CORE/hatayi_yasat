import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/provider/monetization_state.dart';
import 'package:lifeclient/features/monetization/provider/monetization_view_model.dart';
import 'package:lifeclient/features/monetization/view/mixin/monetization_view_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/ticketcher/custom_horizontal_ticketcher.dart';
import 'package:ticketcher/ticketcher.dart';

part 'widget/monetization_body_view.dart';

final class MonetizationView extends ConsumerStatefulWidget {
  const MonetizationView({super.key});

  @override
  ConsumerState<MonetizationView> createState() => _MonetizationViewState();
}

class _MonetizationViewState extends ConsumerState<MonetizationView>
    with AppProviderMixin<MonetizationView>, MonetizationViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(monetizationViewModelProvider);

    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.monetization_title,
        actions: buildAppBarActions(),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(MonetizationState state) {
    if (state.isError) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.monetization_loadError.tr(),
      );
    }

    if (state.isFetching) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (state.coupons.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.monetization_emptyCoupons.tr(),
      );
    }

    return _MonetizationBodyView(
      state: state,
      onEditCoupon: onEditCouponPressed,
      onDeleteCoupon: onDeleteCouponPressed,
    );
  }
}
