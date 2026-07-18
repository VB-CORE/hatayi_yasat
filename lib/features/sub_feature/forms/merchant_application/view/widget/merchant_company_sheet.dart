import 'dart:async';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

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
    return Padding(
      padding: const PagePadding.onlyBottom(),
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontalSymmetric(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
              TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: LocaleKeys.merchantApplication_selectCompany.tr(),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const EmptyBox.middleHeight(),
              if (isLoading)
                const Padding(
                  padding: PagePadding.defaultPadding(),
                  child: CircularProgressIndicator.adaptive(),
                )
              else if (hasError)
                Padding(
                  padding: const PagePadding.defaultPadding(),
                  child: GeneralBodySmallTitle(
                    LocaleKeys.message_somethingWentWrong.tr(),
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const PagePadding.onlyBottom(),
                    itemCount: visibleCompanies.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final company = visibleCompanies[index];
                      return _MerchantCompanyTile(
                        company: company,
                        onTap: () => Navigator.pop(context, company),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _MerchantCompanyTile extends StatelessWidget {
  const _MerchantCompanyTile({required this.company, required this.onTap});

  final StoreModel company;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final thumbSize = context.sized.dynamicHeight(0.07);
    return ListTile(
      contentPadding: const PagePadding.allVeryLow(),
      onTap: onTap,
      title: GeneralBodySmallTitle(company.name, fontWeight: FontWeight.w500),
      leading: ClipRRect(
        borderRadius: CustomRadius.small,
        child: SizedBox(
          width: thumbSize,
          height: thumbSize,
          child: CustomNetworkImage(
            imageUrl: company.images.firstOrNull,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
