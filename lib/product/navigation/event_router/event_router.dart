import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/details/view/event_detail_view.dart';
import 'package:lifeclient/features/event/view/event_view.dart';

final class EventRoute extends GoRouteData {
  const EventRoute();

  static const route = TypedGoRoute<EventRoute>(
    path: 'event',
    name: 'Events',
    routes: [
      EventDetailsRoute.route,
    ],
  );

  @override
  Widget build(BuildContext context, GoRouterState state) => const EventView();
}

final class EventDetailsRoute extends GoRouteData {
  EventDetailsRoute({required this.$extra});

  static const route = TypedGoRoute<EventDetailsRoute>(
    path: 'details',
    name: 'Event Details',
  );

  final CampaignModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EventDetailView(event: $extra);
}
