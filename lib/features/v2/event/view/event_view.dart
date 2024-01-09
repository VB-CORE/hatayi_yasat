import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/event/provider/event_view_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/navigation/event_router/event_router.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/builder/firestore_grid_view.dart';
import 'package:vbaseproject/product/widget/card/event_card.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

part 'widget/event_grid_builder.dart';

final class EventView extends ConsumerStatefulWidget {
  const EventView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventViewState();
}

class _EventViewState extends ConsumerState<EventView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: const _EventGridBuilder(),
    );
  }
}
