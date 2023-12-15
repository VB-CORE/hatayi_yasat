import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';
import 'package:vbaseproject/features/v2/details/view/project_detail_view.dart';

mixin ProjectDetailMixin on ConsumerState<ProjectDetailView> {
  // TODO: replace with parameter from constructor
  late final RequestProjectModel projectModel;
  @override
  void initState() {
    super.initState();
    projectModel = widget.project;
  }

  Future<void> goBackAction() async {
    // TODO: implement goBackAction for click back button
  }

  Future<void> joinNowAction() async {
    // TODO: implement joinNowAction for click join now button
  }
}
