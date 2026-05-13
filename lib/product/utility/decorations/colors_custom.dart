import 'package:flutter/material.dart';

@immutable
final class ColorsCustom {
  const ColorsCustom._();

  // ─── V2 Mozaik palette ─────────────────────────────────────────────────
  // Derived from the new mozaik logo (deep navy + coral + teal + olive).

  // Primary — Deep Navy (mosaic ground). `sambacus` is kept as the alias
  // used across the legacy code; bumping its value migrates every existing
  // usage to the V2 navy shade.
  static const Color sambacus = Color(0xFF0F2A47);
  static const Color navy = Color(0xFF0F2A47);
  static const Color navy50 = Color(0xFFEAEEF3);
  static const Color navy100 = Color(0xFFCBD4E0);
  static const Color navy200 = Color(0xFF94A4B9);
  static const Color navy300 = Color(0xFF5C7491);
  static const Color navy400 = Color(0xFF2E4D70);
  static const Color navy600 = Color(0xFF0B2138);
  static const Color navy700 = Color(0xFF08182A);
  static const Color navy800 = Color(0xFF050F1B);
  static const Color navy900 = Color(0xFF02060D);

  // Accent — Coral (mosaic red tesselation).
  static const Color coral = Color(0xFFE84B3C);
  static const Color coral50 = Color(0xFFFDECEA);
  static const Color coral100 = Color(0xFFFACFCB);
  static const Color coral200 = Color(0xFFF4A097);
  static const Color coral300 = Color(0xFFEE7263);
  static const Color coral400 = Color(0xFFEA5B4D);
  static const Color coral600 = Color(0xFFCD3A2C);
  static const Color coral700 = Color(0xFFA12C20);

  // Secondary — Teal (mosaic turquoise). `teal` and `teal400` are aliases.
  static const Color teal = Color(0xFF3CB6C9);
  static const Color teal400 = teal;
  static const Color teal50 = Color(0xFFE5F5F8);
  static const Color teal100 = Color(0xFFBFE7EE);
  static const Color teal200 = Color(0xFF8FD4DF);
  static const Color teal300 = Color(0xFF5EC0CF);
  static const Color teal500 = Color(0xFF2A9DAF);
  static const Color teal600 = Color(0xFF207E8C);
  static const Color teal700 = Color(0xFF185E68);

  // Success — Olive Green (mosaic green tesselation). `olive` and `olive400`
  // are aliases for the base shade used across the V2 design.
  static const Color olive = Color(0xFF7FBE3F);
  static const Color olive400 = olive;
  static const Color olive50 = Color(0xFFF2F9E8);
  static const Color olive100 = Color(0xFFDCEEC0);
  static const Color olive200 = Color(0xFFBDDF92);
  static const Color olive300 = Color(0xFF9DCF63);
  static const Color olive500 = Color(0xFF67A030);
  static const Color olive600 = Color(0xFF4F7C25);

  // Memorial gold — reserved for hatıralar / anma surfaces only.
  static const Color gold = Color(0xFFA87D15);
  static const Color gold50 = Color(0xFFFAF4E4);
  static const Color gold100 = Color(0xFFF1E2B3);
  static const Color gold200 = Color(0xFFE9CE7E);
  static const Color gold300 = Color(0xFFDDB74B);
  static const Color gold600 = Color(0xFF8A6610);

  // Cool stone neutrals — pair naturally with navy primary.
  static const Color bgCool = Color(0xFFF7F9FB);
  static const Color bgCoolDeep = Color(0xFFEEF2F6);
  static const Color ink50 = Color(0xFFEEF2F6);
  static const Color ink100 = Color(0xFFE1E7EE);
  static const Color ink200 = Color(0xFFCBD3DC);
  static const Color ink300 = Color(0xFFA8B2BE);
  static const Color ink400 = Color(0xFF7A8593);
  static const Color ink500 = Color(0xFF566270);
  static const Color ink600 = Color(0xFF3A4452);
  static const Color ink700 = Color(0xFF26303D);
  static const Color ink800 = Color(0xFF16202C);
  static const Color ink900 = Color(0xFF0A1320);

  // ─── Legacy tokens (still referenced across the app) ───────────────────
  static const Color endless = Color(0xFFE23E3E);
  static const Color braziliante = Color(0xFF34C759);
  static const Color brandeisBlue = Color(0xFF0D6EFD);
  static const Color lightGray = Color(0xffCED4DA);
  static const Color softGray = Color.fromRGBO(219, 219, 219, 1);
  static const Color gray = Color.fromRGBO(245, 245, 245, 1);
  static const Color warmGrey = Color.fromRGBO(153, 153, 153, 1);
  static const Color darkGray = Color.fromRGBO(91, 91, 91, 1);
  static const Color underlinePurple = Color.fromRGBO(82, 0, 255, 1);
  static const Color white = Color(0xFFFFffff);
  static const Color imperilRead = Color(0xffEF2636);
  static const Color royalPeacock = Color(0xff27AAE5);
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xFF000000);
  static const Color green = Color(0xFF00FF00);
}
