part of '../group_details_view.dart';

final class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return GeneralContentSmallTitle(
      value: value,
      color: AppColors.navy300,
      fontWeight: FontWeight.w700,
    );
  }
}

final class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: child,
      ),
    );
  }
}
