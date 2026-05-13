import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Lightweight model for a container-market (konteyner çarşı) tile.
/// Backed by hard-coded sample data today; will move to Firestore once
/// the admin tooling for container markets ships.
@immutable
final class ContainerMarket extends Equatable {
  const ContainerMarket({
    required this.id,
    required this.nameKey,
    required this.areaKey,
    required this.districtKey,
    required this.shopCount,
    required this.accent,
  });

  final String id;
  final String nameKey;
  final String areaKey;
  final String districtKey;
  final int shopCount;
  final Color accent;

  @override
  List<Object?> get props => [id, nameKey, areaKey, districtKey, shopCount];
}

/// Static sample list mirroring `V3_CONTAINER_MARKETS` from the design.
/// Locale keys are resolved by the view; accent colors stay raw brand
/// tokens because each card's mosaic gradient is intentionally locked.
const containerMarketSamples = <ContainerMarket>[
  ContainerMarket(
    id: 'turkey',
    nameKey: 'containerMarkets.marketTurkey',
    areaKey: 'containerMarkets.marketTurkeyArea',
    districtKey: 'containerMarkets.districtAntakya',
    shopCount: 21,
    accent: ColorsCustom.coral,
  ),
  ContainerMarket(
    id: 'serinyol',
    nameKey: 'containerMarkets.marketSerinyol',
    areaKey: 'containerMarkets.marketSerinyolArea',
    districtKey: 'containerMarkets.districtAntakya',
    shopCount: 67,
    accent: ColorsCustom.teal,
  ),
  ContainerMarket(
    id: 'defne',
    nameKey: 'containerMarkets.marketDefne',
    areaKey: 'containerMarkets.marketDefneArea',
    districtKey: 'containerMarkets.districtDefne',
    shopCount: 34,
    accent: ColorsCustom.navy,
  ),
  ContainerMarket(
    id: 'samandag',
    nameKey: 'containerMarkets.marketSamandag',
    areaKey: 'containerMarkets.marketSamandagArea',
    districtKey: 'containerMarkets.districtSamandag',
    shopCount: 18,
    accent: ColorsCustom.olive,
  ),
];
