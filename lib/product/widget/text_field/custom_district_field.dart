

// final class CustomDistrictSelectionFormField extends StatelessWidget {
//   const CustomDistrictSelectionFormField({
//     required this.hint,
//     required this.controller,
//     required this.onSelected,
//     required this.validator,
//     required this.items,
//     this.textInputType = TextInputType.text,
//     this.maxLength = TextFieldMaxLengths.none,
//     super.key,
//   });
//   final String hint;
//   final TextEditingController controller;
//   final TextInputType textInputType;
//   final TextFieldMaxLengths maxLength;
//   final ValueChanged<SelectSheetModel> onSelected;
//   final ValidatorField validator;
//   final List<TownModel> items;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLength: maxLength.value,
//       readOnly: true,
//       validator: validator.validate,
//       inputFormatters: [FilteringTextInputFormatter.deny('')],
//       keyboardType: textInputType,
//       onTap: () async {
//         final item = await GeneralSelectSheet.show(
//           context,
//           items: items
//               .map(
//                 (e) => SelectSheetModel(
//                   id: e.documentId,
//                   title: e.name ?? '',
//                 ),
//               )
//               .toList(),
//         );
//         if (item == null) return;
//         controller.text = item.title;
//         onSelected.call(item);
//       },
//       decoration: NewCustomTextFieldDecoration(hint: hint, context: context),
//     );
//   }
// }

