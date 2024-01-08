/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class $AssetsDocsGen {
  const $AssetsDocsGen();

  /// File path: assets/docs/kvkk.pdf
  String get kvkk => 'assets/docs/kvkk.pdf';

  /// List of all assets
  List<String> get values => [kvkk];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_car_help.png
  AssetGenImage get icCarHelp =>
      const AssetGenImage('assets/icons/ic_car_help.png');

  /// File path: assets/icons/ic_map_help.png
  AssetGenImage get icMapHelp =>
      const AssetGenImage('assets/icons/ic_map_help.png');

  /// File path: assets/icons/ic_watermark.png
  AssetGenImage get icWatermark =>
      const AssetGenImage('assets/icons/ic_watermark.png');

  /// List of all assets
  List<AssetGenImage> get values => [icCarHelp, icMapHelp, icWatermark];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_welcome.png
  AssetGenImage get imgWelcome =>
      const AssetGenImage('assets/images/img_welcome.png');

  /// List of all assets
  List<AssetGenImage> get values => [imgWelcome];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/better_not_found.json
  LottieGenImage get betterNotFound =>
      const LottieGenImage('assets/lottie/better_not_found.json');

  /// File path: assets/lottie/city_loading.json
  LottieGenImage get cityLoading =>
      const LottieGenImage('assets/lottie/city_loading.json');

  /// File path: assets/lottie/city_loading_better.json
  LottieGenImage get cityLoadingBetter =>
      const LottieGenImage('assets/lottie/city_loading_better.json');

  /// File path: assets/lottie/connection_lost.json
  LottieGenImage get connectionLost =>
      const LottieGenImage('assets/lottie/connection_lost.json');

  /// File path: assets/lottie/firebase_error.json
  LottieGenImage get firebaseError =>
      const LottieGenImage('assets/lottie/firebase_error.json');
  /// File path: assets/lottie/loading_gray.json
  LottieGenImage get loadingGray =>
      const LottieGenImage('assets/lottie/loading_gray.json');

  /// File path: assets/lottie/not_found.json
  LottieGenImage get notFound =>
      const LottieGenImage('assets/lottie/not_found.json');

  /// File path: assets/lottie/search.json
  LottieGenImage get search =>
      const LottieGenImage('assets/lottie/search.json');

  /// File path: assets/lottie/success.json
  LottieGenImage get success =>
      const LottieGenImage('assets/lottie/success.json');

  /// List of all assets
  List<LottieGenImage> get values => [
        betterNotFound,
        cityLoading,
        cityLoadingBetter,
        connectionLost,
        firebaseError,
        loadingGray,
        notFound,
        search,
        success
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/tr.json
  String get tr => 'assets/translations/tr.json';

  /// List of all assets
  List<String> get values => [en, tr];
}

class Assets {
  Assets._();

  static const $AssetsDocsGen docs = $AssetsDocsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
