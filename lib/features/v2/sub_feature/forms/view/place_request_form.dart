import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/mixin/create_request_form_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/dotted/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';

final class PlaceRequestForm extends ConsumerStatefulWidget {
  const PlaceRequestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceRequestFormState();
}

class _PlaceRequestFormState extends ConsumerState<PlaceRequestForm>
    with PlaceRequestFormMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GeneralBigTitle('Create Pleace'),
      ),
      body: ListView(
        padding: const PagePadding.all(),
        children: [
          const GeneralDottedPhotoAdd(),
          CustomTextFormField(
            hint: 'Shelter name',
            controller: TextEditingController(),
          ),
          GeneralButtonV2.active(action: () {}, label: 'Complete'),
        ],
      ),
    );
  }
}
