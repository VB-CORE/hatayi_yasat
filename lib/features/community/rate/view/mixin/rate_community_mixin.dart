import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';

mixin RateCommentControllerMixin
    on ConsumerState<RateCard>, AppProviderMixin<RateCard> {
  final TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final vote = ref.read(rateCommunityProviderProvider(widget.esnafId)).vote;
    commentController.text = vote?.comment ?? '';
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void onVoteChanged(RateCommunityState? prev, RateCommunityState next) {
    if (prev?.vote == null && next.vote != null) {
      appProvider.showSnackbarMessage(LocaleKeys.rate_rateThankYou.tr());
      widget.onSubmitted?.call();
    }
  }
}
