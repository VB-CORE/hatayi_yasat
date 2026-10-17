# 🚀 Open Source Yayınlama Kontrol Listesi

> **Proje:** hatayi_yasat (Hatayı Yaşat)
> **Tarih:** 2025-11-29
> **Versiyon:** 8.1.0

---

## ⚠️ ÖNCE OKUYUN

Bu checklist, projeyi **Public/Open Source** yapmadan önce tamamlanması gereken adımları içerir. Her maddeyi tamamladıktan sonra işaretleyin.

---

## 🔴 KRİTİK ÖNCELIK (Mutlaka Yapılmalı)

### 1. `.gitignore` Dosyasını Güncelleme

- [ ] `.gitignore` dosyasını açın
- [ ] Aşağıdaki satırları ekleyin:

```gitignore
# User-specific files
.claude/settings.local.json
*.xcuserdata/
xcuserdata/

# macOS
.DS_Store

# IDE - User specific
ios/Pods/Pods.xcodeproj/xcuserdata/
```

**Not:** Firebase dosyaları için iki seçenek var:

#### Seçenek A: Firebase Dosyalarını Repo'da Tutmak (Kolay)
✅ **Avantajları:**
- Contributors kolayca projeyi çalıştırabilir
- Setup süreci daha hızlı

⚠️ **Dezavantajları:**
- API anahtarları görünür (ancak bu normal ve güvenlidir - Firebase Security Rules ile kontrol edilir)

**Yapılması gereken:** Hiçbir şey yapmanıza gerek yok, mevcut durum bu.

#### Seçenek B: Firebase Dosyalarını Gizlemek (Güvenli)
✅ **Avantajları:**
- Daha profesyonel görünüm
- Her environment için farklı config

⚠️ **Dezavantajları:**
- Her contributor kendi Firebase projesi kurmak zorunda

**Yapılması gerekenler:**
```bash
# .gitignore dosyasında şu satırların başındaki # işaretlerini kaldırın:
firebase_options.dart
google-services.json
GoogleService-Info.plist
```

**Sonra:**
```bash
# Bu dosyaları git'ten kaldırın (ama local'de saklayın)
git rm --cached lib/firebase_options.dart
git rm --cached android/app/google-services.json
git rm --cached ios/Runner/GoogleService-Info.plist
git rm --cached macos/Runner/GoogleService-Info.plist

# Commit edin
git commit -m "chore: Remove Firebase config files from version control"
```

**Ve `.env.example` dosyası oluşturun:**
```bash
# Dosya: firebase_setup_guide.md
Detaylı Firebase setup talimatları ekleyin (README.md güncellemesine bakın)
```

---

### 2. Kişisel Path'leri Temizleme

- [ ] `.claude/settings.local.json` dosyasını kontrol edin
- [ ] İçinde `vb10` kullanıcı adı var mı?
  - Varsa dosyayı silin veya path'leri değiştirin
  - `.gitignore`'a eklediğinizden emin olun

```bash
# Kontrol için:
cat .claude/settings.local.json

# Eğer kişisel path'ler varsa:
rm .claude/settings.local.json
echo ".claude/settings.local.json" >> .gitignore
```

---

### 3. Xcode User Data Temizliği

- [ ] User-specific Xcode dosyalarını kontrol edin:

```bash
# Bu dosyaları silin (yeniden generate edilecektir):
rm -rf ios/Pods/Pods.xcodeproj/xcuserdata/

# Commit etmeyin - .gitignore'da olduğundan emin olun
```

---

## 🟡 YÜKSEK ÖNCELİK

### 4. TODO Yorumlarını Temizleme

Şu dosyalardaki TODO yorumlarını düzeltin:

- [ ] **lib/product/navigation/app_router.dart**
  ```dart
  // ❌ ÖNCE: // TODO: Bu sayfa yapılacak.
  // ✅ SONRA: // TODO: Implement missing page
  ```

- [ ] **lib/features/sub_feature/forms/project_request/view/mixin/project_request_form_mixin.dart**
  ```dart
  // Mevcut: // TODO: This method should be updated with the new checkbox widget
  // ✅ OK - Bu kalabilir
  ```

- [ ] **lib/features/sub_feature/notifications/notification_mixin.dart**
  ```dart
  // ❌ ÖNCE: // TODO: This method is not working properly.
  // ✅ SONRA: // TODO: Refactor notification handler to support all notification states
  ```

- [ ] **lib/product/feature/cache/shared_v2/shared_operation_manager.dart**
  ```dart
  // ❌ ÖNCE: // TODO: it will update
  // ✅ SONRA: // TODO: Update cache invalidation strategy
  ```

**Toplu değiştirme için:**
```bash
# Tüm Türkçe TODO'ları bulun:
grep -r "TODO.*yapılacak\|TODO.*Bu" lib/

# Manuel olarak düzeltin veya sed kullanın (dikkatli!)
```

---

### 5. README.md Güncellemesi

- [ ] Mevcut README.md dosyasını açın
- [ ] Aşağıdaki içeriği **en üste** ekleyin:

```markdown
# 🌟 Hatayı Yaşat - Community Platform

[![Flutter Version](https://img.shields.io/badge/Flutter-3.7.0+-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> Hatay için topluluk tabanlı mobil uygulama

[İngilizce tanım ekleyin - örnek:]
> A community-driven mobile application connecting people with local services, events, and community initiatives in Hatay region.

---

## 📱 Özellikler (Features)

- 🏘️ Topluluk etkinlikleri ve duyurular
- 📰 Yerel haberler ve güncellemeler
- 🗺️ Harita tabanlı yer keşfi
- 📋 Form ve başvuru sistemleri
- 🔔 Anlık bildirimler
- 🌐 Çok dilli destek (TR/EN)

---

## 🚀 Kurulum (Getting Started)

### Gereksinimler (Prerequisites)

- Flutter SDK (3.7.0 veya üzeri)
- Dart SDK (3.0.0 veya üzeri)
- Firebase hesabı
- iOS development: Xcode 14+, CocoaPods
- Android development: Android Studio, JDK 17

### 📦 Kurulum Adımları

#### 1. Depoyu Klonlayın
```bash
git clone https://github.com/VB-CORE/hatayi_yasat.git
cd hatayi_yasat
```

#### 2. Bağımlılıkları Yükleyin
```bash
flutter pub get
```

#### 3. Firebase Kurulumu ⚠️ ÖNEMLİ

Bu proje Firebase kullanmaktadır. Kendi Firebase projenizi oluşturmanız gerekiyor:

**A. Firebase Projesi Oluşturun**
1. [Firebase Console](https://console.firebase.google.com)'a gidin
2. Yeni proje oluşturun veya mevcut projeyi kullanın

**B. Firebase Servislerini Aktifleştirin**
- ✅ Authentication (isteğe bağlı)
- ✅ Firestore Database
- ✅ Cloud Storage
- ✅ Cloud Messaging (FCM)
- ✅ Crashlytics
- ✅ Remote Config
- ✅ Analytics

**C. Platform-Specific Config Dosyalarını İndirin**

Android için:
```bash
# google-services.json dosyasını indirin
# android/app/ klasörüne kopyalayın
```

iOS için:
```bash
# GoogleService-Info.plist dosyasını indirin
# ios/Runner/ klasörüne kopyalayın
```

macOS için (isteğe bağlı):
```bash
# GoogleService-Info.plist dosyasını indirin
# macos/Runner/ klasörüne kopyalayın
```

**D. FlutterFire CLI ile Konfigürasyon**
```bash
# FlutterFire CLI'yi yükleyin
dart pub global activate flutterfire_cli

# Firebase projenizi yapılandırın
flutterfire configure

# Bu komut firebase_options.dart dosyasını oluşturacaktır
```

**E. Firebase Security Rules Kurulumu** 🔐

⚠️ **ÇOK ÖNEMLİ:** Firebase Security Rules'ları mutlaka yapılandırın!

Firebase Console'da şu kuralları ayarlayın:

**Firestore Rules (örnek):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Kendi kurallarınızı buraya ekleyin
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

**Storage Rules (örnek):**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### 4. iOS Ek Adımlar
```bash
cd ios
pod install
cd ..
```

#### 5. Uygulamayı Çalıştırın
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

---

## 🏗️ Proje Mimarisi

### Teknoloji Stack
- **State Management:** Riverpod 3.0
- **Navigation:** GoRouter
- **Database:**
  - Firebase Firestore (remote)
  - Hive (local cache)
- **Code Generation:** build_runner, freezed, json_serializable
- **Localization:** easy_localization
- **Maps:** Google Maps Flutter

### Klasör Yapısı
```
lib/
├── features/          # Feature-based modüller
├── product/           # Paylaşılan business logic
│   ├── model/         # Data models
│   ├── utility/       # Utilities & helpers
│   ├── init/          # Initialization
│   └── navigation/    # Routing
└── main.dart          # Entry point
```

---

## 🛠️ Development

### Code Generation
```bash
# Build runner (model generation)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Localization
```bash
# Dil dosyalarını generate et
flutter pub run easy_localization:generate -O lib/product/init/language -f keys -o locale_keys.g.dart --source-dir assets/translations
```

### Icon Update
```bash
sh ./scripts/update_icon.sh
```

### Tests
```bash
# Unit & Widget tests
flutter test

# UI Tests (Maestro)
cd maestro
./run_tests.sh
```

---

## 🧪 Testing

Bu proje Maestro UI testing framework'ünü kullanır.

Detaylı test dökümanı için [README'nin test bölümüne](#ui-testing-with-maestro) bakın.

---

## 🤝 Katkıda Bulunma (Contributing)

Katkılarınızı bekliyoruz! Lütfen aşağıdaki adımları takip edin:

1. Bu depoyu fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

### Kod Standartları
- `.cursorrules` dosyasındaki kurallara uyun
- `flutter analyze` hatasız geçmeli
- Yeni özellikler için test yazın
- Anlamlı commit mesajları kullanın (Conventional Commits)

---

## 📄 Lisans (License)

Bu proje MIT lisansı altında lisanslanmıştır - detaylar için [LICENSE](../LICENSE) dosyasına bakın.

---

## 📞 İletişim

- **Email:** grafikhtyapp@gmail.com
- **Twitter:** [@10VBacik](https://twitter.com/10VBacik)

---

## 🙏 Teşekkürler

Bu proje şu harika open source paketleri kullanmaktadır:
- [Riverpod](https://riverpod.dev/)
- [GoRouter](https://pub.dev/packages/go_router)
- [Firebase](https://firebase.google.com/)
- [Hive](https://pub.dev/packages/hive)

---

## 📊 Project Status

- ✅ Production'da aktif
- 🔄 Aktif geliştirme
- 📱 Platforms: iOS, Android, Web (experimental)

---

_Made with ❤️ for Hatay community_
```

- [ ] Yukarıdaki içeriği README.md'ye ekleyin
- [ ] Türkçe/İngilizce çevirileri kontrol edin
- [ ] Proje özelliklerini kendi projenize göre güncelleyin

---

### 6. Kişisel Bilgileri Değerlendirme (Opsiyonel)

**Dosya:** `lib/features/main/settings/model/contact_model.dart`

Mevcut durum:
```dart
ContactModel(
  name: 'Veli Bacık',
  mail: 'grafikhtyapp@gmail.com',
  twitterUrl: 'https://twitter.com/10VBacik',
),
```

**Seçenekler:**

- [ ] **Seçenek A:** Aynen bırakın (Uygulama içinde iletişim bilgisi olarak görünmesi normaldir)
- [ ] **Seçenek B:** Ekip/organizasyon bilgisine çevirin:
  ```dart
  ContactModel(
    name: 'Hatayı Yaşat Ekibi',
    mail: 'contact@hatayiyasat.com', // veya mevcut email
    twitterUrl: 'https://twitter.com/hatayiyasatapp', // veya mevcut
  ),
  ```

**Karar verin ve işaretleyin:**
- [ ] Kişisel bilgiler aynen kalacak
- [ ] Kişisel bilgiler organizasyon bilgisine çevrilecek

---

## 🟢 ORTA ÖNCELİK (Nice to Have)

### 7. CONTRIBUTING.md Dosyası Oluşturma

- [ ] Yeni dosya oluşturun: `CONTRIBUTING.md`
- [ ] Aşağıdaki içeriği ekleyin:

```markdown
# Contributing to Hatayı Yaşat

Katkılarınız için teşekkür ederiz! 🎉

## 🚀 Nasıl Katkıda Bulunabilirim?

### 1. Issue Bildirme
- Önce mevcut issue'ları kontrol edin
- Açık ve detaylı açıklama yazın
- Mümkünse ekran görüntüsü ekleyin
- Cihaz ve OS bilgisi paylaşın

### 2. Pull Request Süreci

#### Adım 1: Fork & Clone
```bash
git clone https://github.com/YOUR_USERNAME/hatayi_yasat.git
cd hatayi_yasat
```

#### Adım 2: Branch Oluşturun
```bash
git checkout -b feature/your-feature-name
# veya
git checkout -b fix/your-bug-fix
```

#### Adım 3: Kodlayın
- `.cursorrules` dosyasındaki kurallara uyun
- Anlamlı commit mesajları kullanın

#### Adım 4: Test Edin
```bash
flutter analyze
flutter test
```

#### Adım 5: Push & PR
```bash
git push origin feature/your-feature-name
```

GitHub'da Pull Request açın.

## 📝 Kod Standartları

### Zorunlu Kurallar
- **Const kullanımı:** Her stateless widget `const` constructor olmalı
- **Magic numbers:** Sayısal değerler named constant olmalı
- **Localization:** UI text'leri `LocaleKeys.*.tr()` kullanmalı
- **Icons:** `AppIcons.*` kullanmalı (Icons.* değil)
- **Colors:** `ColorsCustom.*` kullanmalı
- **Padding:** `PagePadding.*` kullanmalı

### Commit Mesajları
[Conventional Commits](https://www.conventionalcommits.org/) kullanın:

```
feat: Add new feature
fix: Fix bug in navigation
docs: Update README
style: Format code
refactor: Refactor state management
test: Add unit tests
chore: Update dependencies
```

### Code Review
- Tüm PR'lar review gerektirir
- CI checks pass olmalı
- Çakışma (conflict) olmamalı

## 🧪 Test Yazma

Yeni özellikler için test yazın:
```dart
test('should return correct value', () {
  // Arrange
  final expected = 'value';

  // Act
  final result = yourFunction();

  // Assert
  expect(result, expected);
});
```

## 📚 Dokümantasyon

- Public API'ler dokümante edilmeli
- Kompleks logic için yorum ekleyin
- README güncellemesi gerekiyorsa ekleyin

## ❓ Sorular?

Issue açın veya email atın: grafikhtyapp@gmail.com

## 🙏 Teşekkürler!

Her katkı değerlidir ❤️
```

---

### 8. GitHub Issue Templates Oluşturma

- [ ] `.github/ISSUE_TEMPLATE/` klasörü oluşturun
- [ ] Bug report template ekleyin
- [ ] Feature request template ekleyin

**Bug Report Template** (`.github/ISSUE_TEMPLATE/bug_report.md`):
```markdown
---
name: Bug Report
about: Bir hata bildirin
title: '[BUG] '
labels: bug
assignees: ''
---

## 🐛 Bug Açıklaması
[Açık ve net bir açıklama yazın]

## 📱 Nasıl Reproduce Edilir
Adımlar:
1. '...' gidin
2. '...' tıklayın
3. '...' görün

## ✅ Beklenen Davranış
[Ne olmasını bekliyordunuz?]

## 📸 Ekran Görüntüleri
[Varsa ekran görüntüsü ekleyin]

## 📋 Ortam Bilgileri
- Cihaz: [örn. iPhone 14]
- OS: [örn. iOS 17.0]
- App Version: [örn. 8.1.0]

## 📝 Ek Bilgiler
[Ek context varsa ekleyin]
```

**Feature Request Template** (`.github/ISSUE_TEMPLATE/feature_request.md`):
```markdown
---
name: Feature Request
about: Yeni özellik önerin
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

## 🚀 Özellik Açıklaması
[Özelliği açık bir şekilde tanımlayın]

## 💡 Motivasyon
[Bu özellik neden gerekli?]

## 📝 Önerilen Çözüm
[Nasıl implement edilmeli?]

## 🔄 Alternatifler
[Düşündüğünüz alternatif çözümler]

## 📸 Mockup/Örnek
[Varsa görsel örnek ekleyin]
```

---

### 9. CI/CD Pipeline Kurulumu (Opsiyonel)

- [ ] `.github/workflows/` klasörü oluşturun
- [ ] CI workflow ekleyin

**Flutter CI** (`.github/workflows/flutter_ci.yml`):
```yaml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.7.0'
        channel: 'stable'

    - name: Install dependencies
      run: flutter pub get

    - name: Verify formatting
      run: dart format --output=none --set-exit-if-changed .

    - name: Analyze project source
      run: flutter analyze

    - name: Run tests
      run: flutter test

    - name: Build Android APK
      run: flutter build apk --debug
```

---

## 🔵 DÜŞÜK ÖNCELİK

### 10. functions/index.js İncelemesi

- [ ] `functions/index.js` dosyasını açın
- [ ] İçinde hardcoded secret/API key var mı kontrol edin
- [ ] Environment variables kullanılıyor mu?
- [ ] Firebase Functions deployment yapıldığında sorun çıkabilecek kod var mı?

**Not:** Functions klasörünü henüz incelemediniz. Lütfen kontrol edin:
```bash
cat functions/index.js | grep -i "key\|secret\|token\|password"
```

---

### 11. Ek Dokümantasyon

- [ ] **CODE_OF_CONDUCT.md** ekleyin (Topluluk kuralları)
- [ ] **SECURITY.md** ekleyin (Güvenlik politikası)
- [ ] **CHANGELOG.md** ekleyin (Versiyon geçmişi)

---

## 📋 SON KONTROL LİSTESİ

Tüm yukarıdaki adımları tamamladıktan sonra:

- [ ] `flutter analyze` çalıştırın - hata olmamalı
- [ ] `flutter test` çalıştırın - testler geçmeli
- [ ] `git status` yapın - istenmeyen dosyalar staged değil mi?
- [ ] `.gitignore` doğru çalışıyor mu test edin
- [ ] README.md render kontrolü yapın (GitHub preview)
- [ ] License dosyası doğru mu?
- [ ] Firebase Security Rules ayarlandı mı?
- [ ] Tüm TODO'lar temizlendi mi?

---

## 🚀 YAYIN ADIMI

Herşey hazır olduğunda:

### 1. Final Commit
```bash
git add .
git commit -m "chore: Prepare project for open source release

- Update .gitignore with user-specific files
- Clean up TODO comments
- Enhance README with setup instructions
- Add contributing guidelines
- Add issue templates"
```

### 2. Push to GitHub
```bash
git push origin main
```

### 3. Repository Settings (GitHub)
- [ ] Repository'yi **Public** yapın
- [ ] Description ekleyin: "Community-driven mobile app for Hatay region"
- [ ] Topics ekleyin: `flutter`, `firebase`, `mobile-app`, `open-source`, `community`
- [ ] License seçin: MIT
- [ ] Wiki'yi enable edin (opsiyonel)
- [ ] Discussions'ı enable edin (opsiyonel)
- [ ] Branch protection rules ekleyin (main branch)

### 4. İlk Release Oluşturun
- [ ] GitHub Releases bölümüne gidin
- [ ] "Create a new release" tıklayın
- [ ] Tag version: `v8.1.0`
- [ ] Release title: "Initial Public Release v8.1.0"
- [ ] Release notes yazın

**Örnek Release Notes:**
```markdown
## 🎉 Initial Public Release

We're excited to announce the first public release of Hatayı Yaşat mobile application!

### Features
- Community events and announcements
- Local news and updates
- Map-based place discovery
- Forms and application systems
- Push notifications
- Multi-language support (TR/EN)

### Tech Stack
- Flutter 3.7.0+
- Firebase (Firestore, Storage, FCM, Crashlytics)
- Riverpod 3.0 for state management
- GoRouter for navigation

### Getting Started
Please read our comprehensive [README.md](README.md) for setup instructions.

### Contributing
We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

Made with ❤️ for Hatay community
```

---

## ✅ TAMAMLANDI!

Tebrikler! Projeniz artık Open Source için hazır 🎉

**Sonraki Adımlar:**
- Community feedback bekleyin
- İlk contributors'ları karşılayın
- Issues'ları takip edin
- Düzenli güncelleme yapın

---

## 📞 Yardıma İhtiyacınız Var mı?

Bu checklist hakkında sorularınız için:
- GitHub Issue açın
- Email: grafikhtyapp@gmail.com

---

**Son Güncelleme:** 2025-11-29
**Checklist Versiyonu:** 1.0
**Durum:** ✅ Hazır
