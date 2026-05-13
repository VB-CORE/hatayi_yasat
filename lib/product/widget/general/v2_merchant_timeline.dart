import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/merchant_application_model.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// V2 merchant application status timeline.
///
/// Renders the [MerchantApplicationStatus] lifecycle as a vertical
/// progress indicator — three or four stages (submitted → in review →
/// approval → badge live). The stage matching [current] is highlighted
/// as active; earlier stages are marked done.
class V2MerchantTimeline extends StatelessWidget {
  const V2MerchantTimeline({required this.current, super.key});

  final MerchantApplicationStatus current;

  @override
  Widget build(BuildContext context) {
    final stages = <_StageData>[
      _StageData(
        stage: MerchantApplicationStatus.submitted,
        label: LocaleKeys.merchantOnboarding_timelineSubmitted.tr(),
      ),
      _StageData(
        stage: MerchantApplicationStatus.inReview,
        label: LocaleKeys.merchantOnboarding_timelineInReview.tr(),
      ),
      _StageData(
        stage: MerchantApplicationStatus.approved,
        label: LocaleKeys.merchantOnboarding_timelineApproval.tr(),
        note: LocaleKeys.merchantOnboarding_timelineDoneNote.tr(),
      ),
    ];
    return Column(
      children: [
        for (var i = 0; i < stages.length; i++)
          _StageRow(
            data: stages[i],
            state: _resolveState(stages[i].stage),
            isLast: i == stages.length - 1,
          ),
      ],
    );
  }

  _StageState _resolveState(MerchantApplicationStatus stage) {
    if (current == MerchantApplicationStatus.rejected) {
      return stage == MerchantApplicationStatus.submitted
          ? _StageState.done
          : _StageState.rejected;
    }
    final order = [
      MerchantApplicationStatus.none,
      MerchantApplicationStatus.submitted,
      MerchantApplicationStatus.inReview,
      MerchantApplicationStatus.approved,
    ];
    final currentIndex = order.indexOf(current);
    final stageIndex = order.indexOf(stage);
    if (stageIndex < currentIndex) return _StageState.done;
    if (stageIndex == currentIndex) return _StageState.active;
    return _StageState.pending;
  }
}

class _StageRow extends StatelessWidget {
  const _StageRow({
    required this.data,
    required this.state,
    required this.isLast,
  });

  final _StageData data;
  final _StageState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final palette = _palette(colorScheme);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: palette.dotBg,
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                ),
                child: Icon(palette.icon, size: 16, color: palette.dotFg),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: palette.line,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const EmptyBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: V2Typography.label(
                      fontSize: 13,
                      color: palette.labelFg,
                    ),
                  ),
                  if (state == _StageState.active && data.note != null) ...[
                    const EmptyBox.xSmallHeight(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.tertiaryContainer,
                        borderRadius: CustomRadius.small,
                      ),
                      child: Text(
                        data.note!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onTertiaryContainer,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _StagePalette _palette(ColorScheme cs) {
    switch (state) {
      case _StageState.done:
        return _StagePalette(
          dotBg: cs.primaryContainer,
          dotFg: cs.onPrimary,
          line: cs.primaryContainer,
          labelFg: cs.onSurface,
          icon: Icons.check_rounded,
        );
      case _StageState.active:
        return _StagePalette(
          dotBg: cs.tertiary,
          dotFg: cs.onPrimary,
          line: cs.onPrimaryContainer,
          labelFg: cs.tertiary,
          icon: Icons.hourglass_top_rounded,
        );
      case _StageState.pending:
        return _StagePalette(
          dotBg: cs.onPrimaryFixed,
          dotFg: cs.onSecondaryFixed,
          line: cs.onPrimaryContainer,
          labelFg: cs.onSecondaryFixed,
          icon: Icons.circle_outlined,
        );
      case _StageState.rejected:
        return _StagePalette(
          dotBg: cs.error.withValues(alpha: 0.18),
          dotFg: cs.error,
          line: cs.onPrimaryContainer,
          labelFg: cs.error,
          icon: Icons.close_rounded,
        );
    }
  }
}

enum _StageState { done, active, pending, rejected }

class _StageData {
  const _StageData({required this.stage, required this.label, this.note});

  final MerchantApplicationStatus stage;
  final String label;
  final String? note;
}

class _StagePalette {
  const _StagePalette({
    required this.dotBg,
    required this.dotFg,
    required this.line,
    required this.labelFg,
    required this.icon,
  });

  final Color dotBg;
  final Color dotFg;
  final Color line;
  final Color labelFg;
  final IconData icon;
}
