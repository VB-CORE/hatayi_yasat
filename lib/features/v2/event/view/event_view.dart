import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/custom_popup_menu_app_bar.dart';
import 'package:vbaseproject/product/widget/card/event_card.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

part 'widget/event_grid_builder.dart';

final class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: CustomPopupMenuAppbar(context: context),
      body: const _EventGridBuilder(),
    );
  }
}
