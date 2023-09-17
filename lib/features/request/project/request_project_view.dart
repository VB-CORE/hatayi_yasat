import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class RequestProjectView extends StatefulWidget {
  const RequestProjectView({super.key});

  @override
  State<RequestProjectView> createState() => _RequestProjectViewState();
}

class _RequestProjectViewState extends State<RequestProjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.projectRequest_title).tr(),
      ),
      body: const NotFoundLottie(),
    );
  }
}
