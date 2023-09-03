import 'package:flutter/material.dart';

import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';

class SearchFieldDisabled extends StatelessWidget {
  const SearchFieldDisabled({required this.onTap, super.key, this.hint});
  final String? hint;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextField(
        onTap: onTap,
        decoration: InputDecoration(
          enabled: false,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
          disabledBorder: const OutlineInputBorder(
            borderRadius: CustomRadius.extraLarge,
          ),
          border: const OutlineInputBorder(
            borderRadius: CustomRadius.extraLarge,
          ),
        ),
      ),
    );
  }
}
