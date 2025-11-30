# ⚡ Hızlı Başlangıç - Open Source Yayın Kontrol Listesi

> **5 dakikada yapılması gerekenler** ✅

---

## 🔴 ÖNCE BUNLARI YAP (Kritik)

### 1️⃣ .gitignore Güncelle (2 dakika)

`.gitignore` dosyasına ekle:

```gitignore
# User-specific files
.claude/settings.local.json
*.xcuserdata/
xcuserdata/
```

### 2️⃣ TODO Yorumlarını Düzelt (3 dakika)

Şu dosyalardaki Türkçe TODO'ları değiştir:

- `lib/product/navigation/app_router.dart`
  - `// TODO: Bu sayfa yapılacak.` → `// TODO: Implement missing page`

- `lib/features/sub_feature/notifications/notification_mixin.dart`
  - `// TODO: This method is not working properly.` → `// TODO: Refactor notification handler`

### 3️⃣ User-Specific Dosyaları Temizle (1 dakika)

```bash
# Şu dosyayı sil:
rm .claude/settings.local.json

# Xcode user data'yı sil:
rm -rf ios/Pods/Pods.xcodeproj/xcuserdata/
```

---

## 🟡 SONRA BUNLARI YAP (Önemli)

### 4️⃣ README.md Güncelle (10 dakika)

README.md'nin başına ekle:
- Proje açıklaması
- Kurulum adımları
- Firebase setup talimatları
- Özellikler listesi

**Detaylı içerik için:** `OPEN_SOURCE_CHECKLIST.md` dosyasındaki "5. README.md Güncellemesi" bölümüne bak.

### 5️⃣ Firebase Kararı Ver

**Seçenek A:** Firebase dosyalarını repo'da tut (kolay)
- ✅ Hiçbir şey yapma
- ⚠️ API anahtarları görünür olacak (bu normal ve güvenli)

**Seçenek B:** Firebase dosyalarını gizle (güvenli)
- `.gitignore`'daki Firebase satırlarının başındaki `#` işaretini kaldır
- Dosyaları git'ten kaldır ama local'de sakla

---

## 🟢 BONUS (Opsiyonel)

### 6️⃣ Ekstra Dosyalar Ekle

- [ ] `CONTRIBUTING.md` oluştur
- [ ] `.github/ISSUE_TEMPLATE/` klasörü oluştur
- [ ] `CODE_OF_CONDUCT.md` ekle

---

## ✅ SON KONTROL

```bash
# 1. Analiz çalıştır
flutter analyze

# 2. Git durumunu kontrol et
git status

# 3. Commit et
git add .
git commit -m "chore: Prepare for open source release"
git push origin main
```

---

## 🚀 YAYIN

GitHub'da:
1. Settings → Repository visibility → **Make public**
2. Description ekle: "Community-driven mobile app for Hatay"
3. Topics ekle: `flutter`, `firebase`, `mobile-app`
4. License: MIT ✅

---

## 📋 DETAYLI LİSTE

Tüm detaylar için:
👉 **`OPEN_SOURCE_CHECKLIST.md`** dosyasına bak

---

**Toplam Süre:** ~20 dakika
**Zorunluk Seviyesi:** 🔴 Kritik adımlar mutlaka yapılmalı!
