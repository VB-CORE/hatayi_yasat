# 🔐 Güvenlik Notları - Open Source Yayın

> **Güvenlik değerlendirmesi ve öneriler**

---

## ✅ GÜVENLİ OLAN DURUMLAR

### 1. Firebase API Anahtarları (Client-Side)

**Konum:** `lib/firebase_options.dart`

```dart
apiKey: 'AIzaSyDUOAiKOMpuNxnpysbMoN9gx85LSRNc--I'  // Android
apiKey: 'AIzaSyDy0ND6I8WABYRgWmoqkSgHKV9dZ_r1FOE'  // iOS
```

✅ **GÜVENLI** - Açıklama:
- Firebase API anahtarları client-side uygulamalarda public olması normaldir
- Bu anahtarlar sadece Firebase projenizi tanımlar, yetkilendirme YAPMAZLAR
- Gerçek güvenlik Firebase Console'daki Security Rules ile sağlanır
- Google'ın official dökümanına göre bu anahtarların public olması sorun değildir

📚 **Referans:** [Firebase API Key Security](https://firebase.google.com/docs/projects/api-keys)

**Kontrol Edilmesi Gerekenler:**
- ✅ Firestore Security Rules yapılandırılmış mı?
- ✅ Firebase Storage Rules yapılandırılmış mı?
- ✅ Firebase Authentication aktif mi?
- ✅ Rate limiting ayarları yapılmış mı?

---

### 2. Firebase Functions Environment Variables

**Konum:** `functions/index.js`

```javascript
const BASE_URL = process.env.FUNCTIONS_EMULATOR
  ? process.env.BASE_URL
  : functions.config().mongo.baseurl;

const SECRET = process.env.FUNCTIONS_EMULATOR
  ? process.env.SECRET
  : functions.config().mongo.secret;
```

✅ **GÜVENLI** - Açıklama:
- Secrets hardcoded değil, environment variables kullanılıyor
- Production'da `functions.config()` kullanılıyor
- Local development'da `.env` dosyası kullanılıyor

**Kontrol Edin:**
```bash
# .env dosyası git'te olmamalı
cat .gitignore | grep ".env"

# Çıktı olmalı: *.env* veya .env
```

**Firebase Functions Config:**
```bash
# Production secrets'ları şöyle set edin:
firebase functions:config:set mongo.baseurl="YOUR_MONGO_URL"
firebase functions:config:set mongo.secret="YOUR_SECRET_KEY"
```

---

## ⚠️ DİKKAT EDİLMESİ GEREKENLER

### 1. MongoDB/Backend URL ve Secret

**functions/index.js** dosyasında:
- Mongo URL harici bir backend'e istek atıyor
- SECRET header ile yetkilendirme yapılıyor

**Güvenlik Kontrolleri:**

- [ ] `functions/.env` dosyası `.gitignore`'da mı?
  ```bash
  # Kontrol:
  ls -la functions/.env 2>/dev/null || echo "✅ .env bulunamadı (iyi)"
  ```

- [ ] `.env.example` dosyası var mı? (olmalı)
  ```bash
  # Oluşturun:
  cat > functions/.env.example << EOF
  # MongoDB Backend Configuration
  BASE_URL=https://your-mongodb-api.com
  SECRET=your-secret-key-here
  EOF
  ```

- [ ] Firebase Functions Config production'da set edilmiş mi?
  ```bash
  firebase functions:config:get
  # Çıktı: { "mongo": { "baseurl": "...", "secret": "..." } }
  ```

---

### 2. Google Services JSON/Plist Dosyaları

**Mevcut Durum:**
- ❌ Şu anda Git'e commit edilmiş
- ⚠️ `.gitignore`'da yorum satırı halinde

**Seçenekler:**

#### Seçenek A: Repo'da Tut (Kolay)
✅ Avantajlar:
- Contributors kolayca setup yapabilir
- Public API anahtarları, güvenlik Firebase Rules'da

⚠️ Dezavantajlar:
- Project ID ve config'ler görünür
- Her environment için aynı config

**Yapılacak:** Hiçbir şey

#### Seçenek B: Repo'dan Kaldır (Güvenli)
✅ Avantajlar:
- Daha profesyonel
- Environment-specific config mümkün

⚠️ Dezavantajlar:
- Setup süreci uzar
- Detaylı dokümantasyon gerekir

**Yapılacaklar:**
```bash
# 1. .gitignore'daki yorum işaretlerini kaldır
sed -i '' 's/# firebase_options.dart/firebase_options.dart/' .gitignore
sed -i '' 's/# google-services.json/google-services.json/' .gitignore
sed -i '' 's/# GoogleService-Info.plist/GoogleService-Info.plist/' .gitignore

# 2. Git'ten kaldır (ama local'de sakla)
git rm --cached lib/firebase_options.dart
git rm --cached android/app/google-services.json
git rm --cached ios/Runner/GoogleService-Info.plist
git rm --cached macos/Runner/GoogleService-Info.plist

# 3. .env.example benzeri dosyalar oluştur
cp lib/firebase_options.dart lib/firebase_options.dart.example
# İçindeki gerçek değerleri 'YOUR_API_KEY' ile değiştir

# 4. Commit
git commit -m "chore: Remove Firebase config from version control"
```

---

## 🔒 FIREBASE SECURITY RULES ÖNERİLERİ

### Firestore Rules

**Mevcut Durum:** Bilinmiyor, kontrol edilmeli

**Önerilen Kurallar:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Authenticated users only
    match /{document=**} {
      allow read, write: if request.auth != null;
    }

    // Approved Applications - Public read, admin write
    match /approvedApplications/{applicationId} {
      allow read: if true;
      allow write: if request.auth != null
                   && request.auth.token.admin == true;
    }

    // User-specific data
    match /users/{userId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;
    }
  }
}
```

**Kontrol:**
```bash
# Firebase Console'da kontrol edin:
# https://console.firebase.google.com/project/savehatay/firestore/rules
```

---

### Storage Rules

**Önerilen Kurallar:**

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    // Public images
    match /public/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }

    // User uploads
    match /users/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
                   && request.auth.uid == userId
                   && request.resource.size < 5 * 1024 * 1024; // 5MB limit
    }
  }
}
```

---

## 📋 GÜVENLİK KONTROL LİSTESİ

Projeyi public yapmadan önce:

### Firebase Security

- [ ] Firestore Security Rules yapılandırıldı mı?
- [ ] Storage Security Rules yapılandırıldı mı?
- [ ] Authentication enabled mı?
- [ ] App Check enabled mı? (DDOS koruması)
- [ ] Rate limiting ayarlandı mı?
- [ ] Test mode'dan production mode'a geçildi mi?

### Environment Variables

- [ ] `functions/.env` dosyası `.gitignore`'da mı?
- [ ] `functions/.env.example` oluşturuldu mu?
- [ ] Production secrets `firebase functions:config` ile set edildi mi?
- [ ] `.env` dosyalarında gerçek secretlar yok mu?

### API Keys & Secrets

- [ ] Client-side API keys (Firebase) → ✅ Public olabilir
- [ ] Server-side secrets (MongoDB) → ❌ Environment variables'da
- [ ] Signing keys/certificates → ❌ Kesinlikle gizli
- [ ] OAuth client secrets → ❌ Kesinlikle gizli

### Files & Paths

- [ ] `.gitignore` user-specific dosyaları kapsıyor mu?
- [ ] `xcuserdata/` ignore ediliyor mu?
- [ ] `.claude/settings.local.json` ignore ediliyor mu?
- [ ] Personal path'ler (`/Users/veli/`) yok mu?

---

## 🚨 ASLA PAYLAŞILMAMASI GEREKENLER

❌ **Kesinlikle Git'e eklenMEmeli:**

1. **Private Keys / Certificates**
   - `*.p12`
   - `*.keystore`
   - `*.jks`
   - `key.properties`

2. **Environment Files**
   - `.env`
   - `.env.local`
   - `.env.production`

3. **OAuth Secrets**
   - Client secrets
   - Refresh tokens
   - Access tokens

4. **Database Credentials**
   - MongoDB connection strings (with password)
   - SQL database passwords
   - Redis passwords

5. **Signing Configs**
   - Android signing config files
   - iOS provisioning profiles (private)

---

## ✅ PAYLAŞILMASI GÜVENLI OLANLAR

✅ **Git'e eklenebilir:**

1. **Firebase Config (Client-side)**
   - `google-services.json` (opsiyonel)
   - `GoogleService-Info.plist` (opsiyonel)
   - `firebase_options.dart` (opsiyonel)
   - **Ama:** Firebase Security Rules mutlaka yapılandırılmalı!

2. **Example Files**
   - `.env.example`
   - `firebase_options.dart.example`
   - Template config files

3. **Public Assets**
   - Images, icons, fonts
   - Localization files
   - Public documentation

---

## 📞 Güvenlik Sorunu Bildirme

Eğer projenizde bir güvenlik açığı keşfederseniz:

1. **Public issue AÇMAYIN**
2. Email gönderin: grafikhtyapp@gmail.com
3. Detaylı açıklama yapın
4. Yanıt bekleyin (24-48 saat)

---

## 📚 Referanslar

- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [Firebase API Keys](https://firebase.google.com/docs/projects/api-keys)
- [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)

---

**Son Güncelleme:** 2025-11-29
**Güvenlik Audit Versiyonu:** 1.0
**Durum:** ✅ Reviewed
