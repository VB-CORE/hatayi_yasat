import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/place_request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/project_request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/scholarship_request_form.dart';

final class RequestProjectRoute extends GoRouteData {
  const RequestProjectRoute();

  static const route = TypedGoRoute<RequestProjectRoute>(
    path: 'requestProject',
    name: 'Request Project',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProjectRequestForm();
}

final class RequestCompanyRoute extends GoRouteData {
  const RequestCompanyRoute();

  static const route = TypedGoRoute<RequestCompanyRoute>(
    path: 'requestCompany',
    name: 'Request Company',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PlaceRequestForm();
}

final class RequestScholarshipRoute extends GoRouteData {
  const RequestScholarshipRoute();

  static const route = TypedGoRoute<RequestScholarshipRoute>(
    path: 'requestScholarship',
    name: 'Request Scholarship',
  );

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScholarshipRequestForm();
}
