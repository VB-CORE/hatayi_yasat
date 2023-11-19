import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});
  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          TitleDescription(
            title: 'vb10 birthday',
            description: 'Happpyyyyy new year to all vb10 lovers 🥳',
          ),
        ],
      ),
    );
  }
}
