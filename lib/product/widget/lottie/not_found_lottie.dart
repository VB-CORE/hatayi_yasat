import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';

class NotFoundLottie extends StatelessWidget {
  const NotFoundLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.sized.height,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.sized.dynamicHeight(.2),
            ),
            child: Assets.lottie.notFound.lottie(),
          ),
        ),
      ),
    );
  }
}
