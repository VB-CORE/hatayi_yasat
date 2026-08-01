import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';

final class MerchantReplySheet extends ConsumerStatefulWidget {
  const MerchantReplySheet({required this.review, super.key});

  static Future<String?> open(
    BuildContext context, {
    required VoteModel review,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: MerchantReplySheet(review: review),
      ),
    );
  }

  final VoteModel review;

  @override
  ConsumerState<MerchantReplySheet> createState() => _MerchantReplySheetState();
}

final class _MerchantReplySheetState extends ConsumerState<MerchantReplySheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.review.merchantReply ?? '',
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralBodyTitle(
                LocaleKeys.merchantPanel_reviews_replyTitle.tr(),
                fontWeight: FontWeight.bold,
              ),
              const EmptyBox.xSmallHeight(),
              Text(
                widget.review.comment ?? '',
                maxLines: AppConstants.kThree,
                overflow: TextOverflow.ellipsis,
                style: AppText.bodySm,
              ),
              const EmptyBox.middleHeight(),
              CustomTextFormMultiField(
                hint: LocaleKeys.merchantPanel_reviews_replyHint.tr(),
                controller: _controller,
                maxLength: TextFieldMaxLengths.veryLarge,
                validator: ValidatorNormalTextField(),
              ),
              const EmptyBox.middleHeight(),
              GeneralButtonV2.active(
                action: _submit,
                label: LocaleKeys.merchantPanel_reviews_replyAction.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
