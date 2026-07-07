import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/rate/model/mock_auth.dart';
import 'package:lifeclient/features/community/rate/model/mock_community_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_provider.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/view/widget/comment_card.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class CommunityList extends ConsumerWidget {
  const CommunityList({
    required this.model,
    super.key,
  });

  final MockCommunityModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReadOnly = ref.watch(
      rateCommunityProviderProvider(
        model.esnafId,
      ).select((state) => state.isReadOnly),
    );

    return Column(
      children: [
        if (model.isComment)
          _CommentListBody(
            esnafId: model.esnafId,
          ),

        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: GeneralButtonV2.active(
            label: _buttonLabel(isReadOnly),
            isBorderless: model.isComment,
            isEnabled: model.isComment && !isReadOnly,
            action: () async {
              if (!model.isComment || isReadOnly) return;
              if (!MockAuth.isAuthenticated) {
                await _showLoginRequiredDialog(context);
                return;
              }
              await RateCard.show(context, esnafId: model.esnafId);
            },
          ),
        ),
      ],
    );
  }

  String _buttonLabel(bool isReadOnly) {
    if (!model.isComment) return LocaleKeys.rate_commentingDisabled.tr();
    if (isReadOnly) return LocaleKeys.rate_commentAdded.tr();
    return LocaleKeys.rate_addComment.tr();
  }

  Future<void> _showLoginRequiredDialog(BuildContext context) =>
      GeneralTextDialog.show(
        context,
        LocaleKeys.rate_loginRequiredTitle.tr(),
        LocaleKeys.rate_loginRequiredContent.tr(),

        [
          GeneralDialogButton(
            title: LocaleKeys.button_cancel,
            onPressed: () => Navigator.pop(context),
          ),
          GeneralDialogButton(
            title: LocaleKeys.button_login,
            onPressed: () {
              Navigator.pop(context);
              const MainTabRoute().go(context);
            },
          ),
        ],
        backgroundColor: context.general.colorScheme.surface,
      );
}

final class _CommentListBody extends ConsumerWidget {
  const _CommentListBody({required this.esnafId});
  final String esnafId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rateCommunityProviderProvider(esnafId));
    switch (state.listStatus) {
      case _CommunityListStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case _CommunityListStatus.error:
        return GeneralContentSubTitle(
          value: LocaleKeys.message_somethingWentWrong.tr(),
          textAlign: TextAlign.center,
        );

      case _CommunityListStatus.empty:
        return GeneralContentSubTitle(
          value: LocaleKeys.rate_noCommentsYet.tr(),
          textAlign: TextAlign.center,
        );
      case _CommunityListStatus.loaded:
        final notifier = ref.read(
          rateCommunityProviderProvider(esnafId).notifier,
        );
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.comments.length,
          itemBuilder: (context, index) {
            final comment = state.comments[index];
            final isOwn = state.vote?.userId == comment.userId;
            return CommentCard(
              rateModel: comment,
              onEdit: isOwn
                  ? () => RateCard.show(context, esnafId: esnafId)
                  : null,
              onDelete: isOwn ? notifier.deleteVote : null,
            );
          },
        );
    }
  }
}

enum _CommunityListStatus { loading, error, empty, loaded }

extension on RateCommunityState {
  _CommunityListStatus get listStatus {
    if (isLoading) return _CommunityListStatus.loading;
    if (isError) return _CommunityListStatus.error;
    if (comments.isEmpty) return _CommunityListStatus.empty;
    return _CommunityListStatus.loaded;
  }
}
