import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/page_app_bar.dart';
import 'package:vbaseproject/product/widget/general/general_expansion_image_tile.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';

final class ChainStoresView extends StatefulWidget {
  const ChainStoresView({super.key});

  @override
  State<ChainStoresView> createState() => _ChainStoresViewState();
}

final class _ChainStoresViewState extends State<ChainStoresView> {
  final _dummyLogoImage =
      'https://cdn.freelogovectors.net/wp-content/uploads/2012/02/turkcelllogo.png';
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(pageTitle: LocaleKeys.chain_stores_title),
      body: Padding(
        padding: const PagePadding.vertical6Symmetric(),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GeneralExpansionImageTile(
              pageTitle: 'Zincir Mağaza $index',
              subTitle: 'Zincir Mağaza Açıklama',
              imageUrl: _dummyLogoImage,
              children: List.generate(
                4,
                (index) => ListTile(
                  title: Text('Zincir Mağaza $index'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Zincir Mağaza Detay $index'),
                      Text(
                        'Zincir Mağaza Adres $index',
                        style: context.general.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(AppIcons.location),
                    onPressed: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
