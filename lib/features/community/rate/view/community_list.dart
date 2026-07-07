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

final class CommunityList extends ConsumerStatefulWidget {
  const CommunityList({
    required this.model,
    super.key,
  });

  final MockCommunityModel model;

  @override
  ConsumerState<CommunityList> createState() => _CommunityListState();
}

final class _CommunityListState extends ConsumerState<CommunityList> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      rateCommunityProviderProvider(widget.model.esnafId),
    );

    return Column(
      children: [
        if (widget.model.isComment)
          _CommentListBody(
            state: state,
            esnafId: widget.model.esnafId,
          ),

        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: GeneralButtonV2.active(
            label: _buttonLabel(state),
            isBorderless: widget.model.isComment,
            isEnabled: widget.model.isComment && !state.isReadOnly,
            action: () async {
              if (!widget.model.isComment || state.isReadOnly) return;
              if (!MockAuth.isAuthenticated) {
                await _showLoginRequiredDialog(context);
                return;
              }
              await RateCard.show(context, esnafId: widget.model.esnafId);
            },
          ),
        ),
      ],
    );
  }

  String _buttonLabel(RateCommunityState state) {
    if (!widget.model.isComment) return LocaleKeys.rate_commentingDisabled.tr();
    if (state.isReadOnly) return LocaleKeys.rate_commentAdded.tr();
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
  const _CommentListBody({required this.esnafId, required this.state});
  final String esnafId;
  final RateCommunityState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.isError) {
      return GeneralContentSubTitle(
        value: LocaleKeys.message_somethingWentWrong.tr(),
        textAlign: TextAlign.center,
      );
    }
    if (state.comments.isEmpty) {
      return GeneralContentSubTitle(
        value: LocaleKeys.rate_noCommentsYet.tr(),
        textAlign: TextAlign.center,
      );
    }
    final notifier = ref.read(rateCommunityProviderProvider(esnafId).notifier);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.comments.length,
      itemBuilder: (context, index) {
        final comment = state.comments[index];
        final isOwn = state.vote?.userId == comment.userId;
        return CommentCard(
          rateModel: comment,
          onEdit: isOwn ? () => RateCard.show(context, esnafId: esnafId) : null,
          onDelete: isOwn ? notifier.deleteVote : null,
        );
      },
    );
  }
}
