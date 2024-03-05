import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/button/multiple_select_button.dart';
import 'package:lifeclient/product/widget/icon/index.dart';
import 'package:lifeclient/product/widget/text/title_description_text.dart';
import 'package:lifeclient/product/widget/text_field/index.dart';

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
          MultipleSelectButton(
            onUpdatedSelectedItems: (value) {},
            items: List.generate(
              10,
              (index) =>
                  MultipleSelectItem(title: 'title $index', id: '$index'),
            ),
          ),
          CustomTextFormField(
            hint: 'Test',
            validator: ValidatorNormalTextField(),
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
