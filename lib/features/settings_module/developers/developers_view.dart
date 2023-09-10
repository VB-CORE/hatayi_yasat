import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/settings_module/developers/mixin/developer_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/card/developer_profile_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class DevelopersView extends ConsumerStatefulWidget {
  const DevelopersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DevelopersViewState();
}

class _DevelopersViewState extends ConsumerState<DevelopersView>
    with DeveloperViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.developers_title.tr()),
      ),
      body: devItems.isEmpty ? const NotFoundLottie() : _gridViewBuilder(),
    );
  }

  GridView _gridViewBuilder() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: devItems.length,
      itemBuilder: (BuildContext context, int index) {
        final model = devItems[index];
        return DeveloperProfileCard(model: model);
      },
    );
  }
}
