part of '../compose_view.dart';

class _ComposeTextField extends StatelessWidget {
  const _ComposeTextField({required this.controller, required this.maxLength});

  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: null,
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      style: textTheme.bodyMedium?.copyWith(
        height: 1.5,
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: LocaleKeys.compose_placeholder.tr(),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondaryFixed,
        ),
        border: InputBorder.none,
        counterText: '',
      ),
    );
  }
}

class _ComposeSubmitButton extends StatelessWidget {
  const _ComposeSubmitButton({
    required this.canSubmit,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool canSubmit;
  final bool isSubmitting;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return ElevatedButton(
      onPressed: canSubmit ? () => onSubmit() : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onPrimaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.small,
        ),
      ),
      child: isSubmitting
          ? SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.onPrimary,
              ),
            )
          : Text(
              LocaleKeys.compose_publish.tr(),
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }
}
