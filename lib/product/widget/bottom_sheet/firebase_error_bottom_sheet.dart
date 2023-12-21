import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

/// FirebaseErrorBottomSheet uses for show bottom sheet about firebase error
final class FirebaseErrorBottomSheet extends StatelessWidget {
  const FirebaseErrorBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return const FirebaseErrorBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.all(),
      child: Column(
        children: [
          GeneralContentTitle(
            value: LocaleKeys.sheet_firebase_error.tr(),
            maxLine: AppConstants.kFour,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Assets.lottie.firebaseError.lottie(),
          ),
        ],
      ),
    );
  }
}
