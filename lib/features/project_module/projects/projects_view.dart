import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  @override
  Widget build(BuildContext context) {
    return const NotFoundLottie();
  }
}
