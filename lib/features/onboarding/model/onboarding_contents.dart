import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/onboarding/model/onboarding_model.dart';

@immutable
final class OnboardingContents {
  const OnboardingContents._();

  static List<OnboardingModel> create() {
    return const [
      OnboardingModel(
        category: 'MEKAN KEŞFİ',
        title: 'Mahallenin esnafı, avucunun içinde',
        desc:
            'Antakya, Defne, İskenderun... Yakınındaki açık mekanları gör, kategoriye ve semte göre filtrele, aradığını anında bul.',
        chips: [
          'Ana sayfa akışı',
          'Kategori & Filtre',
          'Mekan Detayı',
          'Favoriler',
        ],
        color: AppColors.coral,
      ),
      OnboardingModel(
        category: 'TOPLULUK & DAYANIŞMA',
        title: 'Birlikte daha güçlüyüz',
        desc:
            'Yardımlaşma taleplerini takip et, ihtiyaç sahiplerine destek ol ya da kendi ihtiyaçlarını toplulukla paylaş.',
        chips: [
          'İhtiyaç Haritası',
          'Destek Talepleri',
          'Gönüllü Ağı',
          'Geri Bildirim',
        ],
        color: AppColors.teal,
      ),
      OnboardingModel(
        category: 'ESNAF DESTEĞİ',
        title: 'Yerel ekonomiyi kalkındıralım',
        desc:
            'Yerel esnafların ürünlerini ve hizmetlerini incele, sipariş vererek veya ziyaret ederek onlara destek ol.',
        chips: [
          'Yerel Ürünler',
          'Esnaf Hikayeleri',
          'Askıda Destek',
          'Doğrudan İletişim',
        ],
        color: AppColors.gold,
      ),
      OnboardingModel(
        category: 'HABERLER & DUYURULAR',
        title: 'Şehrinden haberdar ol',
        desc:
            'Hatay genelindeki güncel gelişmeleri, altyapı çalışmalarını ve topluluk duyurularını anlık bildirimlerle takip et.',
        chips: [
          'Güncel Haberler',
          'Duyurular',
          'Etkinlik Takvimi',
          'Önemli Telefonlar',
        ],
        color: AppColors.olive,
      ),
    ];
  }
}
