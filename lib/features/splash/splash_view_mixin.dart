import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/splash/splash_view.dart';
import 'package:lifeclient/features/splash/view_model/splash_state.dart';
import 'package:lifeclient/features/splash/view_model/splash_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/dialog/not_connected_to_internet_dialog.dart';
import 'package:lifeclient/product/widget/sheet/index.dart';
import 'package:lottie/lottie.dart';

mixin SplashViewMixin
    on
        AppProviderMixin<SplashView>,
        ConsumerState<SplashView>,
        SingleTickerProviderStateMixin<SplashView> {
  static const Duration _authResolveTimeout = Duration(seconds: 20);

  late final NotifierProvider<SplashViewModel, SplashState> _homeProvider;

  late final AnimationController _controller;
  AnimationController get lottieController => _controller;

  void onLoadedLottie(LottieComposition composition) {
    _controller.duration = composition.duration;
    unawaited(_controller.repeat(min: 0.6, max: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _homeProvider = NotifierProvider(
      () => SplashViewModel(productProvider: productProvider),
    );

    ref.listenManual(_homeProvider, (previous, next) async {
      // When init done, stop lottie animation
      _controller.stop();

      if (next.isError) {
        final retry =
            (await GeneralErrorSheet.show(
              context,
              title: LocaleKeys.message_somethingWentWrong.tr(),
            )) ??
            false;
        if (!retry) return;
        if (!context.mounted) return;
        await ref.read(_homeProvider.notifier).refresh();
        return;
      }

      if (next.isNeedToOnBoard) {
        const OnboardRoute().go(context);
        return;
      }
      if (next.isNeedToForceUpdate) {
        return;
      }

      if (!next.isConnectedToInternet) {
        final response =
            (await NotConnectedToInternetDialog.show(context)) ?? false;
        if (!response) return;
        await ref.read(_homeProvider.notifier).refresh();
        return;
      }
      if (!next.isOperationStaring) {
        final resumeLocation = _resumeLocation;
        if (resumeLocation != null) {
          await _resume(resumeLocation);
          return;
        }
        if (SharedCache.instance.isLoginSeen) {
          const MainTabRoute().go(context);
          return;
        }
        const LoginRoute().go(context);
      }
    });
  }

  String? get _resumeLocation {
    final from = widget.from;
    if (from == null || !from.startsWith('/')) return null;
    final uri = Uri.tryParse(from);
    if (uri == null || uri.hasScheme || uri.hasAuthority) return null;
    final path = uri.path.replaceFirst(RegExp(r'/+$'), '');
    if (path.isEmpty || path == const BannedRoute().location) return null;
    return from;
  }

  Future<void> _resume(String location) async {
    await _waitForAuth();
    if (!mounted) return;
    Router.neglect(context, () => context.go(location));
  }

  Future<void> _waitForAuth() async {
    if (ref.read(authViewModelProvider) is! AuthInitial) return;
    final resolved = Completer<void>();
    final subscription = ref.listenManual(authViewModelProvider, (_, next) {
      if (next is! AuthInitial && !resolved.isCompleted) resolved.complete();
    });
    await resolved.future.timeout(_authResolveTimeout, onTimeout: () {});
    subscription.close();
  }
}
