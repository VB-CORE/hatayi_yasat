import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:ticketcher/ticketcher.dart';

@immutable
final class CustomHorizontalTicketcher extends StatelessWidget {
  const CustomHorizontalTicketcher({
    required this.sections,
    this.decoration,
    super.key,
  });

  final List<Section> sections;
  final TicketcherDecoration? decoration;

  static TicketcherDecoration ticketDecoration({bool isSelected = false}) =>
      TicketcherDecoration(
        backgroundColor: ColorsCustom.gray,
        borderDash: const BorderDash(dash: 8, gap: 4),
        border: Border.all(
          color: isSelected
              ? ColorsCustom.underlinePurple.withValues(alpha: 0.3)
              : ColorsCustom.softGray,
          width: 2,
        ),
      );

  static TicketcherDecoration get defaultDecoration => ticketDecoration();

  @override
  Widget build(BuildContext context) {
    return Ticketcher.horizontal(
      decoration: decoration ?? defaultDecoration,
      sections: sections,
    );
  }
}
