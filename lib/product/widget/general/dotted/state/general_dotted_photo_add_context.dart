import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_provider.dart';

/// [GeneralDottedPhotoAddContext] has a state of [GeneralDottedPhotoAddProviderState]
/// It is used to access the state of [GeneralDottedPhotoAddProviderState] from context
final class GeneralDottedPhotoAddContext extends InheritedWidget {
  const GeneralDottedPhotoAddContext({
    required super.child,
    required this.state,
    super.key,
  });

  final GeneralDottedPhotoAddProviderState state;

  static GeneralDottedPhotoAddProviderState of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<GeneralDottedPhotoAddContext>();
    if (result == null) {
      throw Exception('GeneralDottedPhotoAddContext not found in context');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(GeneralDottedPhotoAddContext oldWidget) => false;
}
