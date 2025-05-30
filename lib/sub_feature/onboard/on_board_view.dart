import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/keys/application_keys.dart';
import 'package:lifeclient/product/navigation/app_router.dart';

class OnBoarView extends StatefulWidget {
  const OnBoarView({super.key});
  @override
  State<OnBoarView> createState() => _OnBoarViewState();
}

class _OnBoarViewState extends State<OnBoarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: K.onboardKeys.view,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Positioned.fill(
              key: K.onboardKeys.fullImage,
              child: Assets.images.imgWelcome.image(
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              child: _AppBar(() async {
                await SharedCache.instance.setFirstAppOpen();
                if (!mounted) return;
                const SplashRoute().pushReplacement(context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(this.onPressed);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: onPressed,
            key: K.onboardKeys.skipButton,
            child: Icon(
              Icons.close,
              weight: ApplicationTheme.maxWeight,
              color: context.general.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
