import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.onPressed,
    required this.isSendingRequestCheck,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isSendingRequestCheck;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyBottomMedium(),
        child: FloatingActionButton(
          onPressed: () {
            if (isSendingRequestCheck) return;
            onPressed();
          },
          child: isSendingRequestCheck
              ? const CircularProgressIndicator()
              : const Text(LocaleKeys.button_save).tr(),
        ),
      ),
    );
  }
}
