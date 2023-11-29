import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

/// GeneralDottedPhotoAdd is a widget that is used to add photo
final class GeneralDottedPhotoAdd extends StatelessWidget {
  const GeneralDottedPhotoAdd({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GeneralDottedRectangle(
      child: SizedBox(
        height: context.sized.dynamicHeight(.2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_a_photo_outlined),
              GeneralBodyTitle(LocaleKeys.button_addPhoto.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
