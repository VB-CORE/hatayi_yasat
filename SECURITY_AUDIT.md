# Web yayını öncesi güvenlik denetimi

Tarih: 2026-10-08 · Branch: `feature/web_deploy` (33990529) · Hedef: Firebase Hosting, `app.hatayiyasat.com`

## Özet

Web bundle'ı temiz: `build/web` içinde yalnızca Firebase web API anahtarı var, kaynak
haritası, `.env`, servis hesabı ya da başka bir anahtar yok. Bağımlılıklarda bilinen
zafiyet çıkmadı. Uygulamada Gemini / AI çağrısı yok.

Asıl risk backend tarafında. Repo **public** ve web anahtarı herkesin elinde olduğu
için, tarayıcıdan Firebase'e doğrudan istek atan biri için tek engel rules. Şu an:

- Giriş yapmış herhangi bir kullanıcı Storage'daki haber, mekan ve ilan görsellerini
  silebilir ya da üzerine yazabilir (F-01).
- Herhangi bir kullanıcı kendini istediği grubun yöneticisi yapabilir (F-02).
- Admin kontrolü e-postanın doğrulanmış olmasını aramıyor (F-03).
- Web'de App Check kapalı; yukarıdakileri script'le büyük ölçekte denemek serbest (F-05).

Yayından önce F-01, F-02, F-03 kapatılmalı. F-04 life_admin'e ait ama aynı projeyi
etkiliyor.

### Kapsam ve sınırlar

| Alan | Durum |
|---|---|
| Web build (`flutter build web --release`, Flutter 3.47.6) | İncelendi |
| Repo + 1009 commit'lik geçmiş, gitleaks 8.30.1 | Tarandı |
| `build/web`, gitleaks + desen araması | Tarandı |
| `pubspec.lock`, osv-scanner 2.6.0 (320 paket) | Tarandı, bulgu yok |
| Firestore / Storage rules | `../life_admin/firebase/` **çalışma kopyası** okundu; deploy edilmiş sürümle aynı olduğu doğrulanmadı (commit'lenmemiş fark var) |
| Cloud Functions (`search`) | **İncelenemedi**: kaynak bu repoda yok, `functions/` altında yalnızca `node_modules` ve `.env` var |
| Firebase / GCP konsol ayarları | İncelenemedi, bkz. elle kontrol listesi |

Yapılandırma: flavor ya da `--dart-define` ile gizli değer enjeksiyonu yok
(tek istisna `ANALYTICS_DEBUG` bayrağı). Firebase ayarları
[firebase_options.dart](lib/firebase_options.dart) içinde sabit. CI Flutter 3.44.9'a
sabitli, `.fvmrc` yok.

## Bulgular

| ID | Önem | Konum | Risk | Çözüm | Efor |
|---|---|---|---|---|---|
| F-01 | **CRITICAL** | `life_admin/firebase/storage.rules:15-82` | `news/`, `adBoard/`, `approvedApplications/`, `approvedCampaigns/`, `touristicPlaces/` dahil 14 klasörde `allow write: if isSignedIn()`. `write` silmeyi de kapsar. Google ile giriş yapan herkes yayındaki görselleri silebilir ya da başka içerikle değiştirebilir. İçerik türü kontrolü yok, 1 MB altı her dosya (HTML, SVG) yüklenebilir. | Admin içerik klasörlerinde yazmayı admin'e kısıtla. Kullanıcı yüklemelerinde yolu `/{klasör}/{uid}/{dosya}` yap, `request.auth.uid == uid`, `contentType.matches('image/.*')` ve `resource == null` (üzerine yazma yok) iste; `delete` kapalı. | M |
| F-02 | **HIGH** | `life_admin/firebase/firestore.rules:309`, `:313-315` | Üyelik `create` ve yeniden katılma `update` kurallarında alan doğrulaması yok. Kullanıcı kendi üyelik dokümanını `role: 2` ile yazıp grup yöneticisi olur (`isGroupAdmin`): kilitleri çevirir, başkalarının gönderi ve cevaplarını soft-delete eder. `isClosed` gruplara katılım da engellenmiyor. | `create`: `request.resource.data.get('role', 1) == 1` ve `uid == memberUid`. Yeniden katılma: `affects(['isDeleted','deletedAt','updatedAt'])`. Rol değişimi yalnızca grup sahibine ayrı kural. | S |
| F-03 | **HIGH** | `life_admin/firebase/firestore.rules:10-14`, `:418-420` | `isAdmin()` yalnızca `token.email` listede mi diye bakıyor, `email_verified` aramıyor. `adminList` her giriş yapana açık, yani admin e-postaları okunabiliyor. Email/Password sağlayıcısı açıksa ve listedeki bir adresin hesabı yoksa, o adresle doğrulanmamış hesap açan kişi admin olur. | `isAdmin()` içine `request.auth.token.email_verified == true` ekle. `adminList` okumasını `isAdmin()` yap. Kalıcı çözüm: custom claim. | S |
| F-04 | **HIGH** | `life_admin/assets/service_account.json`, `life_admin/lib/product/shared/service/firebase_auth_service.dart:11` | `id-firebase-push-sender@savehatay` servis hesabının özel anahtarı life_admin'in asset'i; admin uygulamasının ipa/apk'sından çıkarılabilir ve git geçmişinde (4 commit) duruyor. Repo private olsa da anahtar dağıtılan binary'nin içinde. Web build'i etkilemez, aynı projeyi etkiler. | Anahtarı GCP'de iptal et, push gönderimini callable Cloud Function'a taşı, dosyayı ve `pubspec.yaml:87` satırını kaldır. | M |
| F-05 | **HIGH** | [app_check_initialize_web.dart](lib/product/init/app_check/app_check_initialize_web.dart) | Web'de App Check no-op. Mobilde Play Integrity / App Attest etkin; ama web anahtarı olmadığı için konsolda enforcement açılamıyor (açılırsa web kırılır). Sonuç: Firestore, Storage ve `search` function'ı her yerden script'le çağrılabilir. | reCAPTCHA Enterprise anahtarı oluştur, web'de `ReCaptchaEnterpriseProvider` ile etkinleştir, önce izleme modunda metrikleri gör, sonra Firestore / Storage / Functions için enforce et. | M |
| F-06 | MEDIUM | `life_admin/firebase/firestore.rules:216-223` | Mekan puanı (`ratingSum`/`ratingCount`) ve `visitCount`, oy dokümanı yazılmadan da her giriş yapan tarafından ±1 oynatılabiliyor. Döngüyle herhangi bir mekanın puanı istenen yere çekilir. Aynı durum `memberCount`, `likeCount`, `entryCount` için geçerli. | Sayaçları client'tan al, oy / üyelik / beğeni dokümanı üzerinde Firestore trigger ile hesapla. Ara çözüm: `existsAfter()` ile aynı batch'te oy dokümanı şartı. | L |
| F-07 | MEDIUM | `life_admin/firebase/firestore.rules:431-435`, `:453-457`, `:463-467`, `:496-500` | `unApprovedApplications`, `unApprovedCampaigns`, `scholarship`, `error` koleksiyonlarında `create: if isSignedIn()`; alan, boyut, sahiplik ve sıklık kontrolü yok. Sınırsız çöp kayıt (maliyet + admin panelini boğma). | `keys().hasOnly([...])`, string uzunluk sınırları, `ownerUid == request.auth.uid`. Sıklık için App Check (F-05) + doküman kimliği olarak uid. | M |
| F-08 | MEDIUM | `life_admin/firebase/firestore.rules:308`, `:323`, `:347`, `:363` | Grup gönderi, tartışma ve cevapları üye olmayan her giriş yapan kullanıcıya açık; üyelik listesi de öyle. Yorumdaki niyet ("katılmak ve içeriğini okumak değil") ile kural uyuşmuyor, kapalı grupların içeriği sızıyor. | `allow read: if isGroupMember(groupId) \|\| isAdmin()`; en azından `isClosed` gruplar için. | S |
| F-09 | MEDIUM | [firebase.json](firebase.json) | Güvenlik başlığı yok: CSP, `X-Content-Type-Options`, `Referrer-Policy`, `Permissions-Policy`, çerçeveleme koruması. Clickjacking'e açık. | Aşağıdaki `headers` bloğu. | S |
| F-10 | MEDIUM | GitHub secret `FIREBASE_TOKEN` (2025-01-05) | Kişisel hesabın süresiz refresh token'ı; o hesabın eriştiği **tüm** Firebase projelerine yetki verir ve `--token` kullanımı kaldırılıyor. Repo public. | Yeni workflow yalnızca hosting yetkili servis hesabı kullanıyor. Eski secret'ı sil, `firebase logout --token` ile iptal et. | S |
| F-11 | MEDIUM | `life_admin/firebase/firestore.rules:385-386` | Kupon sahibi kuponun her alanını güncelleyebiliyor (`merchantUid`, `storeId`, sınır dışı `ratio`). `create`'teki doğrulamalar `update`'te yok. | `update`'te `affects([...])` + aynı `ratio` / `expiresAt` kontrolleri. | S |
| F-12 | LOW | [uri_utility.dart:14-24](lib/product/utility/uri/uri_utility.dart#L14-L24), [link_actions.dart:30-37](lib/product/utility/link_actions.dart#L30-L37) | Şema kontrolü `contains('http://')` ile yapılıyor, `openUrl` hiç kontrol etmiyor; `javascript:…//http://` gibi bir değer geçer. Veri bugün yalnızca admin'in yazdığı koleksiyonlardan geliyor, bu yüzden düşük. | Tek yerde izin listesi: `http`, `https`, `mailto`, `tel`. | S |
| F-13 | LOW | [auth_guard.dart:15-21](lib/product/navigation/auth_guard.dart#L15-L21) | `LoginRoute.from` doğrulanmadan `redirect`'e veriliyor. go_router dış adrese gitmez, yani açık yönlendirme değil; bozuk değer hata sayfasına ya da döngüye düşürür. Splash tarafı ([splash_view_mixin.dart:99-107](lib/features/splash/splash_view_mixin.dart#L99-L107)) doğru doğruluyor. | Aynı doğrulamayı ortak bir yardımcıya alıp iki yerde kullan. | S |
| F-14 | LOW | [AndroidManifest.xml:29](android/app/src/main/AndroidManifest.xml#L29), [AppDelegate.swift:12](ios/Runner/AppDelegate.swift#L12), [docs/security_note_check.md:14-15](docs/security_note_check.md#L14-L15), geçmişte `web/index.html` (5787f178) | Public repoda 6 farklı Google API anahtarı görünüyor (3 Firebase, 2 Maps, 1 eski web). Firebase anahtarları gizli değildir; Maps anahtarları kısıtsızsa faturaya yazılır. | Konsolda her anahtara uygulama + API kısıtı (elle kontrol listesi). Geçmişteki eski web anahtarı hâlâ duruyorsa sil. | S |
| F-15 | LOW | [pubspec.yaml:74-78](pubspec.yaml#L74-L78) | `in_app_review` üçüncü kişinin fork'unda hareketli bir dala (`patch-2`) bağlı. `pubspec.lock` commit'i sabitliyor, ama `pub upgrade` incelenmemiş kodu çeker. | `ref`'i commit SHA'sına (`560e70f3…`) sabitle ya da fork'u VB-CORE altına al. | S |
| F-16 | LOW | [analyze.yml](.github/workflows/analyze.yml), [deploy_web.yml](.github/workflows/deploy_web.yml) | Action'lar etikete bağlı (`@v4`, `@v2`, `@v0`), SHA'ya değil. Etiket taşınırsa deploy yetkili job'da yabancı kod çalışır. | Action'ları commit SHA'sına sabitle, Dependabot ile güncelle. | S |
| F-17 | LOW | `build/web/canvaskit/*.symbols` (6 dosya) | Motorun hata ayıklama sembolleri yayına çıkıyor. Uygulama koduna dair bilgi içermez; gereksiz yüzey ve boyut. CanvasKit zaten `www.gstatic.com`'dan yükleniyor. | `firebase.json` `ignore` listesine `**/*.symbols`. | S |

Temiz çıkanlar: `print` / `debugPrint` yok; `kDebugMode` kontrolleri doğru yönde;
release'te emulator ya da test uç noktası kullanılmıyor (`FirebaseEnv` tanımlı ama
çağrılmıyor); `HtmlElementView`, `innerHTML`, HTML / Markdown render yok; tek WebView
sabit `https://www.hatayiyasat.com/` adresini açıyor; `web/index.html`'de üçüncü taraf
script yok; anonim giriş kullanılmıyor; `users/{uid}` yalnızca sahibine ve admin'e açık,
rol / ban alanları kullanıcı tarafından değiştirilemiyor; route guard'ların koruduğu
esnaf ve admin yazmaları rules'ta da zorlanıyor.

Bağımlılıklar: bırakılmış, geri çekilmiş ya da güvenlik uyarılı paket yok. Majör sürümü
geride olanlar: `syncfusion_flutter_pdfviewer` 33→35, `file_picker` 11→13,
`package_info_plus` 8→10, `go_router` 17→18, `cached_network_image` 3→4, `kartal` 4→5
(wasm build'i `dart:html` yüzünden engelliyor), `share_plus` 12→13.

### Rules testi önerileri (`life_admin/firebase/test/rules.test.mjs`)

Mevcut dosyada 3 test var. Eklenmesi gerekenler, hepsi "reddedilmeli" yönünde:

```js
// F-01
await assertFails(userStorage.ref('news/x.jpg').delete());
await assertFails(userStorage.ref('news/x.jpg').put(bytes, { contentType: 'image/jpeg' }));
await assertFails(userStorage.ref(`pending/${uid}/a.html`).put(bytes, { contentType: 'text/html' }));
// F-02
await assertFails(setDoc(doc(userDb, `groups/g1/members/${uid}`), { role: 2, isDeleted: false }));
await assertFails(updateDoc(doc(userDb, `groups/g1/members/${uid}`), { isDeleted: false, role: 2 }));
// F-03
const unverified = env.authenticatedContext('x', { email: 'admin@…', email_verified: false });
await assertFails(setDoc(doc(unverified.firestore(), 'news/n1'), { title: 't' }));
await assertFails(getDoc(doc(userDb, 'adminList/config')));
// F-06
await assertFails(updateDoc(doc(userDb, 'approvedApplications/s1'), { ratingSum: 5, ratingCount: 1 }));
// F-08
await assertFails(getDocs(collection(nonMemberDb, 'groups/g1/posts')));
// F-11
await assertFails(updateDoc(doc(merchantDb, 'coupons/c1'), { ratio: 500 }));
```

## Önerilen `firebase.json` başlıkları

Henüz uygulanmadı. `hosting[0]` içindeki `ignore` ve `headers` şu hale gelir:

```json
"ignore": ["firebase.json", "**/.*", "**/node_modules/**", "**/*.symbols"],
"headers": [
  {
    "source": "**",
    "headers": [
      { "key": "Cache-Control", "value": "no-cache" },
      { "key": "X-Content-Type-Options", "value": "nosniff" },
      { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" },
      { "key": "X-Frame-Options", "value": "DENY" },
      { "key": "Cross-Origin-Opener-Policy", "value": "same-origin-allow-popups" },
      { "key": "Permissions-Policy", "value": "geolocation=(self), camera=(self), microphone=(), payment=(), usb=(), browsing-topics=()" },
      { "key": "Content-Security-Policy-Report-Only", "value": "default-src 'self'; script-src 'self' 'wasm-unsafe-eval' https://www.gstatic.com https://apis.google.com https://accounts.google.com https://www.google.com https://www.recaptcha.net https://www.googletagmanager.com; style-src 'self' 'unsafe-inline' https://accounts.google.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: blob: https:; media-src 'self' blob: https://firebasestorage.googleapis.com; connect-src 'self' https://*.googleapis.com https://*.cloudfunctions.net https://www.gstatic.com https://fonts.gstatic.com https://*.google-analytics.com https://www.googletagmanager.com https://accounts.google.com; frame-src https://savehatay.firebaseapp.com https://accounts.google.com https://appleid.apple.com https://www.google.com https://www.recaptcha.net https://www.hatayiyasat.com; worker-src 'self' blob:; frame-ancestors 'none'; base-uri 'self'; form-action 'self'; object-src 'none'" }
    ]
  },
  { "source": "/icons/**", "headers": [{ "key": "Cache-Control", "value": "public, max-age=86400" }] },
  { "source": "/favicon.png", "headers": [{ "key": "Cache-Control", "value": "public, max-age=86400" }] }
]
```

Notlar:

- `Cross-Origin-Opener-Policy: same-origin-allow-popups` bilinçli: `same-origin`
  `signInWithPopup`'ı bozar.
- `camera=(self)` QR tarayıcı (`mobile_scanner`) için. Konum ya da kamera web'de
  kullanılmayacaksa `()` yap.
- Harita web'de desteklenmediği için karo sunucusu yok. Google Maps açılırsa
  `script-src` ve `connect-src`'ye `https://maps.googleapis.com`, `img-src` zaten `https:`.
- `img-src https:` geniş, çünkü görseller Storage dışındaki adreslerden de geliyor
  (örn. `pbs.twimg.com`). Kaynaklar netleşince daralt.
- HSTS'yi Firebase Hosting kendisi ekliyor.

CSP'yi zorlamaya geçirme: önce `Report-Only` ile preview kanalına deploy et; giriş
(Google popup, Apple, redirect), haber detayı, mekan detayı, video, PDF, QR ve
"Hakkında" WebView akışlarını Chrome ve Safari'de gez, konsoldaki `[Report Only]`
ihlallerini topla. Meşru olanları listeye ekle. Bir hafta canlıda ihlalsiz
kaldıktan sonra anahtarı `Content-Security-Policy` olarak değiştir. Sürekli izleme
istenirse `report-to` ile bir toplama ucu ekle.

## Elle kontrol listesi

Koddan doğrulanamayanlar; hepsi `savehatay` projesinde.

**Google Cloud → APIs & Services → Credentials**

- [ ] Web anahtarı (`AIzaSyA9UT…rIxE`): HTTP referrer kısıtı `app.hatayiyasat.com/*`,
      `savehatay.web.app/*`, `savehatay.firebaseapp.com/*`; API kısıtı yalnızca
      kullanılanlar (Identity Toolkit, Token Service, Firestore, Storage, Installations,
      Remote Config, FCM Registration, App Check).
- [ ] Android anahtarı (`AIzaSyDUOA…c--I`): paket adı + SHA-1 kısıtı.
- [ ] iOS anahtarı (`AIzaSyDy0N…1FOE`): bundle ID kısıtı.
- [ ] Maps anahtarları (`AIzaSyCif1…G-IY` Android, `AIzaSyBRKe…WgVw` iOS): uygulama
      kısıtı + yalnızca Maps SDK; günlük kota sınırı.
- [ ] Eski web anahtarı (`AIzaSyB23q…40Fg`, 2023): hâlâ varsa sil.
- [ ] `id-firebase-push-sender` servis hesabının anahtarlarını iptal et (F-04); rolü
      yalnızca FCM gönderimi mi?

**Firebase Console**

- [ ] Authentication → Settings → Authorized domains: `app.hatayiyasat.com` ekli;
      preview kanalları için `savehatay.web.app`; `localhost` canlıda kalmasın.
- [ ] Authentication → Sign-in method: yalnızca Google ve Apple açık mı? Email/Password
      ve Anonymous kapalı mı (F-03 ve F-07'nin etkisini belirler)? "One account per
      email" açık mı?
- [ ] Google OAuth istemcisi: Authorized JavaScript origins ve redirect URI'larında
      `https://app.hatayiyasat.com`.
- [ ] Apple: Services ID ve return URL (WEB-30 hâlâ açık).
- [ ] App Check: Firestore, Storage, Functions için enforcement durumu ve doğrulanmamış
      istek oranı.
- [ ] Deploy edilmiş Firestore ve Storage rules, `life_admin/firebase/` ile aynı mı?
      Çalışma kopyasında commit'lenmemiş `memories` kuralı var.
- [ ] Storage → CORS: `app.hatayiyasat.com` ve `savehatay.web.app` ekli.
- [ ] Hosting: `app.hatayiyasat.com` özel alan adı `savehatay` sitesine bağlı, sertifika
      hazır (şu an DNS çözülmüyor, `savehatay.web.app` boş).

**Cloud Functions (kaynağı göremedim)**

- [ ] `search`: `maxInstances`, zaman aşımı, girdi uzunluk sınırı, App Check zorlaması,
      kullanıcı başına sıklık sınırı. MongoDB bağlantısı kullanıyor
      (`functions/.env` → `MONGODB_URI`): sorgu parametreli mi, Atlas IP erişim listesi
      dar mı?
- [ ] Faturalama: bütçe uyarısı ve Firestore / Functions / Storage için kota uyarıları.

**GitHub**

- [ ] `FIREBASE_SERVICE_ACCOUNT_SAVEHATAY` secret'ı oluşturuldu, rolü yalnızca
      Firebase Hosting Admin.
- [ ] Eski `FIREBASE_TOKEN` silindi ve iptal edildi (F-10).
- [ ] `production` environment'ında onay zorunlu, yalnızca `main` deploy edebiliyor.
