part of '../map_place_picker.dart';

final class _CityCenterTextButton extends StatelessWidget {
  const _CityCenterTextButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ColorsCustom.royalPeacock.withOpacity(.9),
      ),
      child: Text(
        text,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorsCustom.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
