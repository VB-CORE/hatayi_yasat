import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.onPressed,
    required this.isSendingRequestCheck,
    required this.title,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isSendingRequestCheck;
  final String title;

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
              : Text(
                  title,
                  textAlign: TextAlign.center,
                ).tr(),
        ),
      ),
    );
  }
}
