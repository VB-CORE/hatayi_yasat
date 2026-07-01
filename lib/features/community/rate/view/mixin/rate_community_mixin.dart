import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/rate_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

mixin RateCommentControllerMixin on ConsumerState<RateCard> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose(); // önce kendi kaynağını temizle
    super.dispose();
  }

  void onVoteChanged(RateCommunityState? prev, RateCommunityState next) {
    if (prev?.vote == null && next.vote != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.rate_rateThankYou.tr())),
      );
    }
  }
}
