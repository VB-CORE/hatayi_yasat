part of '../place_request_form.dart';

final class _PlacePickerFormField extends FormField<LatLng?> {
  _PlacePickerFormField({
    required ValueChanged<LatLng> onChanged,
    super.key,
    super.initialValue,
  }) : super(
          validator: (LatLng? value) => value != null ? null : '',
          builder: (FormFieldState<LatLng?> state) {
            final context = state.context;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecorations.circularMedium(
                    borderColor: state.hasError
                        ? context.general.colorScheme.error
                        : context.general.colorScheme.onPrimaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final response =
                              await state.context.route.navigateToPage<LatLng>(
                            MapPlacePicker(
                              initialPosition: state.value,
                            ),
                          );

                          if (response == null) return;
                          state.didChange(response);
                          onChanged.call(response);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(AppIcons.location),
                                Text(
                                  state.value != null
                                      ? LocaleKeys
                                          .component_mapPicker_updateFromMap
                                      : LocaleKeys.component_mapPicker_title,
                                ).tr(),
                                const Spacer(),
                              ],
                            ),
                            if (state.value != null)
                              Padding(
                                padding: const PagePadding.onlyTopLow() +
                                    const PagePadding.onlyLeft(),
                                child: GeneralContentSubTitle(
                                  value:
                                      '${state.value!.latitude.toStringAsFixed(4)}, ${state.value!.longitude.toStringAsFixed(4)}',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const PagePadding.onlyLeft(),
                    child: GeneralContentSmallTitle(
                      value: LocaleKeys.validation_requiredField.tr(),
                      color: context.general.colorScheme.error,
                    ),
                  ),
              ],
            );
          },
        );
}
