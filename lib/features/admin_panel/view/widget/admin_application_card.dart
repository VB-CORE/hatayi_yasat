part of '../admin_applications_tab.dart';

@immutable
final class _AdminApplicationCard extends StatelessWidget {
  const _AdminApplicationCard({
    required this.application,
    required this.isProcessing,
    required this.isBusy,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final MerchantApplicationModel application;
  final bool isProcessing;
  final bool isBusy;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kZero,
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentTitle(value: application.businessName, maxLine: 2),
            const EmptyBox.xSmallHeight(),
            Row(
              children: [
                Expanded(
                  child: GeneralContentSubTitle(
                    value: application.applicantName,
                    maxLine: 1,
                  ),
                ),
                GeneralContentSmallTitle(value: application.createdAt.timeAgo),
              ],
            ),
            const EmptyBox.middleHeight(),
            switch (application.status) {
              MerchantApplicationStatus.pending => _AdminApplicationActions(
                isProcessing: isProcessing,
                isBusy: isBusy,
                onApprove: onApprove,
                onReject: onReject,
              ),
              MerchantApplicationStatus.approved =>
                const _AdminApplicationApprovedRow(),
              MerchantApplicationStatus.rejected => GeneralContentSubTitle(
                value: application.status.labelKey.tr(),
              ),
            },
          ],
        ),
      ),
    );
  }
}

@immutable
final class _AdminApplicationActions extends StatelessWidget {
  const _AdminApplicationActions({
    required this.isProcessing,
    required this.isBusy,
    required this.onApprove,
    required this.onReject,
  });

  final bool isProcessing;
  final bool isBusy;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    if (isProcessing) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return Row(
      children: [
        Expanded(
          child: GeneralButtonV2.active(
            label: LocaleKeys.admin_approve.tr(),
            isEnabled: !isBusy,
            action: onApprove,
          ),
        ),
        const EmptyBox.smallWidth(),
        Expanded(
          child: OutlinedButton(
            onPressed: isBusy ? null : onReject,
            child: Text(LocaleKeys.admin_reject.tr()),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _AdminApplicationApprovedRow extends StatelessWidget {
  const _AdminApplicationApprovedRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AdminVerifiedBadge(),
        const EmptyBox.smallWidth(),
        GeneralContentSubTitle(
          value: MerchantApplicationStatus.approved.labelKey.tr(),
        ),
      ],
    );
  }
}
