part of '../main_tab_view.dart';

/// Ortalanmış mercan ("+") compose butonu. Bottom app bar'ın çentiğine
/// oturur ve [ComposeRoute]'a navigate eder.
final class _ComposeFabButton extends StatelessWidget {
  const _ComposeFabButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SizedBox(
      width: 56,
      height: 56,
      child: FloatingActionButton(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onPrimary,
        elevation: 6,
        highlightElevation: 8,
        shape: const CircleBorder(),
        onPressed: () => const ComposeRoute().push<void>(context),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}
