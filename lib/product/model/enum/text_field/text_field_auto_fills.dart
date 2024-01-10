import 'package:flutter/widgets.dart';

enum TextFieldAutoFills {
  normal([AutofillHints.nickname]),
  name([
    AutofillHints.name,
    AutofillHints.namePrefix,
    AutofillHints.nameSuffix,
    AutofillHints.familyName,
    AutofillHints.organizationName,
  ]),
  address([
    AutofillHints.addressCity,
    AutofillHints.addressCityAndState,
    AutofillHints.fullStreetAddress,
  ]),
  phone([AutofillHints.telephoneNumber]),
  ;

  const TextFieldAutoFills(this.value);
  final List<String> value;
}
