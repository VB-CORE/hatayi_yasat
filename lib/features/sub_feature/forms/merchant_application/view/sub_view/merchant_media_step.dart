part of '../merchant_application_view.dart';

const int _maxPhotoCount = 10;
const int _photosPerRow = 4;

final class _MerchantMediaStep extends ConsumerStatefulWidget {
  const _MerchantMediaStep({
    required this.formKey,
    required this.addressController,
    required this.openTimeController,
    required this.closeTimeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController addressController;
  final TimePickerController openTimeController;
  final TimePickerController closeTimeController;

  @override
  ConsumerState<_MerchantMediaStep> createState() => _MerchantMediaStepState();
}

final class _MerchantMediaStepState extends ConsumerState<_MerchantMediaStep>
    with
        AutomaticKeepAliveClientMixin<_MerchantMediaStep>,
        AppProviderMixin<_MerchantMediaStep> {
  @override
  bool get wantKeepAlive => true;

  MerchantApplicationViewModel get _viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  int _visiblePhotoSlotCount(int photoCount) =>
      photoCount < _maxPhotoCount ? photoCount + 1 : _maxPhotoCount;

  Future<void> _pickPhoto(int index) async {
    final file = await GeneralMediaSheet.open(context);
    if (!mounted || file == null) return;
    _viewModel.addOrReplacePhoto(index, file);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(merchantApplicationViewModelProvider);
    final photoFiles = state.photoFiles;
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListViewWithSpace(
        children: [
          const EmptyBox.middleHeight(),
          OpenAndCloseTimePicker(
            closeTimeController: widget.closeTimeController,
            openTimeController: widget.openTimeController,
          ),
          LabeledProductTextField(
            isMultiline: true,
            controller: widget.addressController,
            labelText: LocaleKeys.requestCompany_address.tr(),
            hintText: LocaleKeys.requestCompany_address.tr(),
            validator: ValidatorNormalTextField().validate,
          ),
          Padding(
            padding: const PagePadding.vertical12Symmetric(),
            child: _MerchantPlacePickerFormField(
              key: ValueKey(state.selectedCompany?.documentId),
              initialValue: state.selectedLocation,
              onChanged: _viewModel.setLocation,
              initialPosition: LatLng(
                productState.selectedCity.location.latitude,
                productState.selectedCity.location.longitude,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GeneralBodySmallTitle(
                    LocaleKeys.merchantApplication_photosTitle.tr(),
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  GeneralBodySmallTitle(
                    LocaleKeys.merchantApplication_photosHint.tr(),
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink400,
                  ),
                ],
              ),
              const EmptyBox.middleHeight(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _visiblePhotoSlotCount(photoFiles.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _photosPerRow,
                  mainAxisSpacing: WidgetSizes.spacingS,
                  crossAxisSpacing: WidgetSizes.spacingXs,
                ),
                itemBuilder: (context, index) => _MerchantPhotoSlot(
                  file: index < photoFiles.length ? photoFiles[index] : null,
                  onTap: () => _pickPhoto(index),
                  onRemove: () => _viewModel.removePhotoAt(index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _MerchantPhotoSlot extends StatelessWidget {
  const _MerchantPhotoSlot({
    required this.file,
    required this.onTap,
    required this.onRemove,
  });

  final File? file;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final photoFile = file;
    if (photoFile == null) {
      return InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: const GeneralDottedRectangle(
          borderRadius: CustomRadius.small,
          child: SizedBox.expand(
            child: Icon(
              AppIcons.addPhoto,
              color: AppColors.ink300,
            ),
          ),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: onTap,
          child: ClipRRect(
            borderRadius: CustomRadius.medium,
            child: Image.file(photoFile, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: WidgetSizes.spacingXSS,
          right: WidgetSizes.spacingXSS,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: onRemove,
            child: Container(
              width: WidgetSizes.spacingL,
              height: WidgetSizes.spacingL,
              decoration: const BoxDecoration(
                color: AppColors.ink800,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                AppIcons.close,
                size: WidgetSizes.spacingM,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
