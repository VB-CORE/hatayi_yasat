import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/application_theme.dart';
import 'package:vbaseproject/product/utility/navigation/project_navigation.dart';

final class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});
  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Positioned.fill(
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
                ProjectNavigation(context).replaceToWidget(const SplashView());
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
