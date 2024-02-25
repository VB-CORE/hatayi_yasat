import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/event/provider/event_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/event_router/event_router.dart';
import 'package:lifeclient/product/widget/builder/firestore_grid_view.dart';
import 'package:lifeclient/product/widget/card/event_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

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
