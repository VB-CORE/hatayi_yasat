import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_company_sheet_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';
import 'package:lifeclient/product/widget/text_field/custom_search_field.dart';

part '../mixin/merchant_company_sheet_mixin.dart';

final class MerchantCompanySheet extends ConsumerStatefulWidget {
  const MerchantCompanySheet({super.key});

  static Future<StoreModel?> show(BuildContext context) {
    return showModalBottomSheet<StoreModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const MerchantCompanySheet(),
    );
  }

  @override
  ConsumerState<MerchantCompanySheet> createState() =>
      _MerchantCompanySheetState();
}

class _MerchantCompanySheetState extends ConsumerState<MerchantCompanySheet>
    with MerchantCompanySheetMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantCompanySheetViewModelProvider);
    final isLoading = state.isFetching || state.isSearching;
    return Padding(
      padding: const PagePadding.onlyBottom(),
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontalSymmetric(),
          child: SizedBox(
            height: context.sized.dynamicHeight(0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(AppIcons.close),
                  ),
                ),
                CustomSearchField(
                  hint: LocaleKeys.merchantApplication_selectCompany.tr(),
                  onChange: onSearchChanged,
                ),
                const EmptyBox.middleHeight(),
                if (isLoading)
                  const Padding(
                    padding: PagePadding.defaultPadding(),
                    child: CircularProgressIndicator.adaptive(),
                  )
                else if (state.isError)
                  Padding(
                    padding: const PagePadding.defaultPadding(),
                    child: GeneralBodySmallTitle(
                      LocaleKeys.message_somethingWentWrong.tr(),
                    ),
                  )
                else if (state.searchResults != null)
                  Flexible(
                    child: ListView.separated(
                      padding: const PagePadding.onlyBottom(),
                      itemCount: state.searchResults!.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final result = state.searchResults![index];
                        return _MerchantCompanyTile(
                          name: result.name,
                          imageUrl: result.image.isEmpty
                              ? result.images.firstOrNull
                              : result.image,
                          onTap: () => onCompanySelected(result.id),
                        );
                      },
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      padding: const PagePadding.onlyBottom(),
                      itemCount: state.companies.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final company = state.companies[index];
                        return _MerchantCompanyTile(
                          name: company.name,
                          imageUrl: company.images.firstOrNull,
                          onTap: () => Navigator.pop(context, company),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _MerchantCompanyTile extends StatelessWidget {
  const _MerchantCompanyTile({
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  final String name;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final thumbSize = context.sized.dynamicHeight(0.07);
    return ListTile(
      contentPadding: const PagePadding.allVeryLow(),
      onTap: onTap,
      title: GeneralBodySmallTitle(name, fontWeight: FontWeight.w500),
      leading: ClipRRect(
        borderRadius: CustomRadius.small,
        child: SizedBox(
          width: thumbSize,
          height: thumbSize,
          child: CustomNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
