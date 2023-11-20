import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/icon/index.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';
import 'package:vbaseproject/product/widget/textfield/custom_search_field.dart';

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
      body: Column(
        children: [
          const TitleDescription(
            title: 'vb10 birthday',
            description: 'Happpyyyyy new year to all vb10 lovers 🥳',
          ),
          const IconWithText(
            icon: Icons.cake,
            title: 'text',
          ),
          IconWithDateTitle(
            icon: Icons.cake,
            title: 'text',
            dateTime: DateTime.now(),
          ),
          CustomSearchField(
            hint: 'Search',
            onChange: (value) {},
          ),
        ],
      ),
    );
  }
}
