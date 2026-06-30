import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/button/apple_sign_in_button.dart';
import 'package:lifeclient/product/widget/button/google_sign_in_button.dart';
import 'package:lifeclient/product/widget/general/general_scaffold.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      backgroundColor: context.general.colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EmptyBox.largeXHeight(),
            _AppHeader(),
            const Spacer(),
            _HeroText(context),
            const EmptyBox.largeHeight(),
            GoogleSignInButton(
              text: 'Google ile devam et',
              onTap: () {},
            ),
            const EmptyBox.middleHeight(),
            AppleSignInButton(
              text: 'Apple ile devam et',
              onTap: () {},
            ),
            const EmptyBox.middleHeight(),
            _GuestButton(),
            const EmptyBox.middleHeight(),
            _LegalText(context),
            const EmptyBox.largeHeight(),
          ],
        ),
      ),
    );
  }

  Widget _AppHeader() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.general.colorScheme.surface,
            borderRadius: CustomRadius.large,
            boxShadow: [
              BoxShadow(
                color: context.general.colorScheme.shadow.withValues(
                  alpha: 0.12,
                ),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Assets.icons.icApp.image(),
        ),
        const EmptyBox.middleWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hatay'ı Yaşat",
              style: context.general.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsCustom.sambacus,
              ),
            ),
            Text(
              'TOPLULUK',
              style: context.general.textTheme.labelSmall?.copyWith(
                color: ColorsCustom.royalPeacock,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _HeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MAHALLE · MEKAN · HATIRA',
          style: context.general.textTheme.labelSmall?.copyWith(
            color: ColorsCustom.endless,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const EmptyBox.smallHeight(),
        RichText(
          text: TextSpan(
            style: context.general.textTheme.displaySmall?.copyWith(
              color: ColorsCustom.sambacus,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(text: 'Hatay\'ı '),
              TextSpan(
                text: 'birlikte',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: ColorsCustom.endless,
                ),
              ),
              TextSpan(text: '\nyaşatalım.'),
            ],
          ),
        ),
        const EmptyBox.smallHeight(),
        Text(
          'Esnafı destekle, hatıralarını paylaş, mahalleni keşfet — şehri yaşatan herkes burada.',
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: context.general.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _GuestButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Misafir olarak devam et',
          style: context.general.textTheme.titleSmall?.copyWith(
            decoration: TextDecoration.underline,
            color: context.general.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _LegalText(BuildContext context) {
    return Center(
      child: Text(
        'Devam ederek kullanım koşullarını ve KVKK kabul etmiş olursun.',
        textAlign: TextAlign.center,
        style: context.general.textTheme.bodySmall?.copyWith(
          color: context.general.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
