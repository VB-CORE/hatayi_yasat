part of '../merchant_application_view.dart';

final class _MerchantMediaStep extends ConsumerStatefulWidget {
  const _MerchantMediaStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantMediaStepState();
}

final class _MerchantMediaStepState
    extends StepFormConsumerState<_MerchantMediaStep>
    with AppProviderMixin<_MerchantMediaStep>, _MerchantMediaStepMixin {
  @override
  Widget onBuild(BuildContext context) {
    return ListViewWithSpace(
      children: [
        const EmptyBox.middleHeight(),
        OpenAndCloseTimePicker(
          closeTimeController: closeTimeController,
          openTimeController: openTimeController,
        ),
        LabeledProductTextField(
          isMultiline: true,
          controller: addressController,
          labelText: LocaleKeys.requestCompany_address.tr(),
          hintText: LocaleKeys.requestCompany_address.tr(),
          validator: ValidatorNormalTextField().validate,
        ),
        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: _MerchantPlacePickerFormField(
            key: ValueKey(
              ref.watch(
                merchantApplicationViewModelProvider.select(
                  (value) => value.selectedCompany?.documentId,
                ),
              ),
            ),
            initialValue: _selectedLocation,
            onChanged: _onLocationChanged,
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
              itemCount: _visiblePhotoSlotCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _photosPerRow,
                mainAxisSpacing: WidgetSizes.spacingS,
                crossAxisSpacing: WidgetSizes.spacingXs,
              ),
              itemBuilder: (context, index) => _MerchantPhotoSlot(
                file: index < _photoFiles.length ? _photoFiles[index] : null,
                onTap: () => _onPhotoSlotTapped(index),
                onRemove: () => _removePhotoAt(index),
              ),
            ),
          ],
        ),
      ],
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
