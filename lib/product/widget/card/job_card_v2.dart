// TODO: (mehmetkaranlik) after implement job card, delete v2 from name
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

@immutable
final class JobCardV2 extends StatelessWidget {
  const JobCardV2({
    required this.item,
    super.key,
  });

  factory JobCardV2.dummy() {
    return JobCardV2(
      item: AdvertiseModel(
        documentId: '1',
        title: 'Flutter Developer',
        gender: Genders.male,
        phoneNumber: '05555555555',
        owner: 'Cıncık Software',
        role: 'Software Developer',
        description: 'Looking for toughnut flutter developer' * 5,
      ),
    );
  }

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    if (item.title.ext.isNullOrEmpty) return const SizedBox.shrink();
    return Card(
      child: ListTile(
        title: _Title(item: item),
        subtitle: _Subtitle(item: item),
      ),
    );
  }
}

final class _Subtitle extends StatelessWidget {
  const _Subtitle({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: InputBorder.none,
      tilePadding: EdgeInsets.zero,
      title: Text(item.role ?? ''),
      childrenPadding: context.padding.verticalLow,
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DescriptionDetail(item: item),
        _PhoneDetail(item: item),
      ],
    );
  }
}

final class _GenderDetail extends StatelessWidget {
  const _GenderDetail({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.gender.displayName,
      style: context.general.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

final class _DescriptionDetail extends StatelessWidget {
  const _DescriptionDetail({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralContentTitle(
          value: LocaleKeys.advertise_description.tr(),
        ),
        GeneralBodyTitle(
          item.description ?? '',
        ),
      ],
    );
  }
}

final class _PhoneDetail extends StatelessWidget {
  const _PhoneDetail({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () => _onPressed(context),
      child: Padding(
        padding: context.padding.verticalLow,
        child: Text(
          '${LocaleKeys.advertise_phone.tr()} ${item.phoneNumber ?? ''}',
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (item.phoneNumber.ext.isNullOrEmpty) return;
    RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: item.phoneNumber!,
    );
  }
}

final class _Title extends StatelessWidget {
  const _Title({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TitleText(item: item),
        context.sized.emptySizedWidthBoxLow,
        _OwnerText(item: item),
      ],
    );
  }
}

final class _OwnerText extends StatelessWidget {
  const _OwnerText({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.owner ?? '',
      style: context.general.textTheme.titleSmall?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}

final class _TitleText extends StatelessWidget {
  const _TitleText({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        item.title!,
        style: context.general.textTheme.titleLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
        maxLines: AppConstants.kOne,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
