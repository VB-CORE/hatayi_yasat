import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/mock_auth.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/mixin/community_list_mixin.dart';
import 'package:lifeclient/features/community/rate/view/widget/comment_card.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class CommunityList extends ConsumerWidget
    with AppProviderStateMixin, CommunityListMixin {
  const CommunityList({
    required this.isComment,
    required this.esnafId,
    super.key,
  });
  final bool isComment;
  final String esnafId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RateCommunityState>(
      rateCommunityProviderProvider(esnafId),
      (prev, next) => onDeleteResult(context, ref, esnafId, prev, next),
    );

    final isReadOnly = ref.watch(
      rateCommunityProviderProvider(
        esnafId,
      ).select((state) => state.isReadOnly),
    );

    return Column(
      children: [
        if (isComment)
          _CommentListBody(
            esnafId: esnafId,
          ),

        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: GeneralButtonV2.active(
            label: _buttonLabel(isReadOnly),
            isBorderless: isComment,
            isEnabled: isComment && !isReadOnly,
            action: () async {
              if (!isComment || isReadOnly) return;
              if (!MockAuth.isAuthenticated) {
                await showLoginRequiredDialog(context);
                return;
              }
              await RateCard.show(context, esnafId: esnafId);
            },
          ),
        ),
      ],
    );
  }

  String _buttonLabel(bool isReadOnly) {
    if (!isComment) return LocaleKeys.rate_commentingDisabled.tr();
    if (isReadOnly) return LocaleKeys.rate_commentAdded.tr();
    return LocaleKeys.rate_addComment.tr();
  }
}

final class _CommentListBody extends ConsumerWidget {
  const _CommentListBody({required this.esnafId});
  final String esnafId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rateCommunityProviderProvider(esnafId));
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.isError) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.comments.isEmpty) {
      return GeneralContentSubTitle(
        value: LocaleKeys.rate_noCommentsYet.tr(),
        textAlign: TextAlign.center,
      );
    } else {
      final notifier = ref.read(
        rateCommunityProviderProvider(esnafId).notifier,
      );
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.comments.length,
        itemBuilder: (context, index) {
          final rate = state.comments[index];
          final isOwn = state.vote?.userId == rate.userId;
          final isWork = isOwn && !state.isProcessing;
          return CommentCard(
            rateModel: rate,
            onEdit: isWork
                ? () => RateCard.show(
                    context,
                    esnafId: esnafId,
                    initialComment: rate.comment,
                  )
                : null,
            onDelete: isWork ? notifier.deleteVote : null,
          );
        },
      );
    }
  }
}
