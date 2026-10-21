# Web yayını

Bu dosya web tarafının tek referansı: yayın akışı, App Check, hosting başlıkları,
domain ve build notları. İş takibi EPIC [#535](https://github.com/VB-CORE/hatayi_yasat/issues/535)
ve `WEB-*` issue'larında; burada yalnızca kalıcı bilgi tutulur.

Son güncelleme: 22.10.2026

## 1. Nerede duruyoruz

| Konu | Durum |
|---|---|
| Hosting sitesi | Firebase projesi `savehatay`, hedef `app` ([.firebaserc](../.firebaserc)) |
| Varsayılan adres | `https://savehatay.web.app` |
| Hedef adres | `https://app.hatayiyasat.com` — custom domain tanımlı, DNS bekliyor |
| App Check (web) | Kod hazır; konsolda web uygulaması kaydı bekliyor |
| App Check enforcement | **Kapalı** (Firestore, Storage, RTDB, Auth hepsi `UNENFORCED`) |
| Güvenlik başlıkları | Yayında (`firebase.json`), CSP report-only |
| CI | Workflow hazır; `FIREBASE_SERVICE_ACCOUNT_SAVEHATAY` secret'ı eksik |

Preview kanalı kalıcı bir adres değildir; her branch kendi kanalını alır ve süresi
dolar. Güncel link için deploy çıktısına bakılır.

## 2. Komutlar

```bash
# Yerel önizleme (deploy yok) — http://localhost:5050
bash scripts/deploy_web.sh local

# Preview kanalı: build + deploy, 7 gün, App Check anahtarı dahil
bash scripts/preview_web.sh
bash scripts/preview_web.sh --skip-build     # build/web hazırsa

# Canlı: main + temiz çalışma ağacı ister, "live" yazarak onay ister
FIREBASE_ACCOUNT=<hesap> bash scripts/deploy_web.sh live
```

- `scripts/preview_web.sh` proje varsayılanlarını taşır: site anahtarı ve 7 günlük
  kanal ömrü. `RECAPTCHA_ENTERPRISE_SITE_KEY`, `PREVIEW_EXPIRES` ve
  `FIREBASE_ACCOUNT` ile ezilebilir.
- `FIREBASE_ACCOUNT` **repoya yazılmaz**; her geliştirici kendi yetkili hesabını
  `firebase login:use` ile seçer ya da env olarak verir.
- `scripts/deploy_web.sh live` yayın öncesi `main == origin/main` ve temiz çalışma
  ağacı kontrolü yapar.

### CI ile deploy

GitHub Actions → **Deploy Web** → Run workflow → `preview` veya `live`.
`live` yalnızca `main` üzerinde çalışır.

Gerekenler:

| Ad | Tür | Not |
|---|---|---|
| `RECAPTCHA_ENTERPRISE_SITE_KEY` | repository **variable** | Site anahtarı herkese açıktır, paketle tarayıcıya iner |
| `FIREBASE_SERVICE_ACCOUNT_SAVEHATAY` | repository **secret** | Hosting deploy yetkili servis hesabı JSON'u; **repoya girmez** |

Secret bugün tanımlı değilse workflow `live` adımında düşer; o durumda yerel
`scripts/deploy_web.sh live` kullanılır.

## 3. App Check (web)

- Sağlayıcı: **reCAPTCHA Enterprise** (score tabanlı anahtar).
- Site anahtarı build sırasında `--dart-define` ile verilir
  ([scripts/web_build.sh](../scripts/web_build.sh)). Anahtar yoksa App Check web'de
  **hiç açılmaz** ve build bir uyarı basar.
- Debug build'de `WebDebugProvider` kullanılır; token konsola yazılır veya
  `APP_CHECK_DEBUG_TOKEN` ile sabitlenir.
- Aktivasyon hatası uygulama açılışını bloklamaz; hata yutulur (web hata kanalı
  WEB-35/#516 açılana kadar).

### Konsol kaydı (yayından önce)

Firebase Console → **App Check** → Apps → Web → reCAPTCHA Enterprise → site anahtarı.

Kayıt yoksa token takası şu hatayı verir ve istekler App Check başlığı taşımaz:

```
400 FAILED_PRECONDITION — App not registered: <appId>
```

reCAPTCHA tarafının doğru olduğu, tarayıcıda token üretildiği görülerek anlaşılır;
tek eksik yukarıdaki kayıttır.

### Enforcement sırası

1. Site anahtarı build'de, konsol kaydı yapılmış, preview'da token akıyor.
2. **Monitor**: App Check → Metrics'te doğrulanmamış istek oranını izle.
3. Sırayla **enforce**: Storage → Firestore → Cloud Functions. Her adımdan sonra
   bir tur gezinti.
4. `permission-denied` artarsa aynı yerden **monitor**'a dön; deploy gerekmez.

> Anahtar olmadan enforcement açmak web'i kırar: her istek `permission-denied`
> döner. Enforcement, web App Check doğrulanmadan açılmaz.

## 4. Hosting başlıkları ve cache

`firebase.json` → `hosting[0].headers`, `**` kuralı:

| Başlık | Değer |
|---|---|
| `X-Content-Type-Options` | `nosniff` |
| `Referrer-Policy` | `strict-origin-when-cross-origin` |
| `X-Frame-Options` | `DENY` |
| `Cross-Origin-Opener-Policy` | `same-origin-allow-popups` |
| `Permissions-Policy` | geolocation/camera self, diğerleri kapalı |
| `Content-Security-Policy-Report-Only` | aşağıdaki not |

- `X-Frame-Options: DENY` girişi etkilemez: `authDomain` ayrı origin'dir
  (`savehatay.firebaseapp.com`), hosting başlıkları oraya uygulanmaz.
- CSP **report-only**. Zorunlu moda alınması için `script-src 'unsafe-inline'`
  (FlutterFire'ın enjekte ettiği `ff_trigger_firebase_*` yükleyicileri) ve
  `'wasm-unsafe-eval'` (CanvasKit) gerekir; bunlar kalkmadan enforce edilmemeli.
- Flutter dosya adlarına içerik hash'i koymadığı için `main.dart.js` ve asset'ler
  sabit adlıdır. Bu yüzden varsayılan `Cache-Control: no-cache`'tir; sabit adlı bir
  dosyaya `immutable` verilmez. Yalnızca `/icons/**` ve `/favicon.png` bir gün
  cache'lenir.
- Engine debug sembolleri (`*.symbols`) build'de silinir ve `firebase.json`'da
  ignore edilir; yayına çıkmaz.

## 5. Domain

Hedef: `app.hatayiyasat.com` → Firebase Hosting sitesi `savehatay`.
`www.hatayiyasat.com` (Google Sites) olduğu gibi kalır.

Firebase Console → Hosting → site `savehatay` → **Add custom domain** sonrası
konsolun verdiği kayıtlar DNS paneline girilir. Tipik olarak:

| Tür | Ad | Değer |
|---|---|---|
| `CNAME` | `app` | `savehatay.web.app` |
| `TXT` | `_acme-challenge.app` | Konsolun verdiği sertifika doğrulama değeri |

Notlar:

- Host alanına tam alan adı değil `app` yazılır.
- `*.hatayiyasat.com` wildcard'ı vardır; açık `app` kaydı onu ezer, `www` ve apex
  etkilenmez. Wildcard silinmez.
- Sertifika 15 dk – 2 saat (en fazla 24 saat) sürer.
- Kontrol: `dig +short app.hatayiyasat.com`, `curl -sI https://app.hatayiyasat.com`.

Domain bağlandıktan sonra güncellenmesi gerekenler:

| Ayar | Nerede |
|---|---|
| Authorized domains | Firebase Auth → Settings |
| OAuth JavaScript origin | GCP → Credentials → Web client |
| Storage CORS | GCS bucket `savehatay.appspot.com` |

## 6. Build boyutu

İlk yüklemenin en büyük kalemi kullanılmayan `material_symbols_icons` paketiydi
(üç font, ~15,7 MB transfer). Paket ve referanssız görseller kaldırıldı; ilk yükleme
~18,9 MB'tan ~3,2 MB'a indi. CanvasKit `www.gstatic.com` CDN'inden gelir, bizim
origin'e girmez.

Yeniden ölçmek için: `flutter build web --release`, ardından hosting emulator'da
Chrome DevTools → Network (Disable cache açık) → "transferred" değerleri.

## 7. Kalan işler

### Sahibinin yapacağı adımlar — planlanan: 23.10.2026

- [ ] **App Check kaydı:** Firebase Console → App Check → Apps → Web →
      reCAPTCHA Enterprise → site anahtarını kaydet. Kayıt sonrası
      `App not registered` hatası kaybolur, istekler `X-Firebase-AppCheck`
      başlığı taşımaya başlar.
- [ ] **DNS:** `app` CNAME → `savehatay.web.app`; `_acme-challenge.app` TXT
      (değeri Firebase Console verir). Wildcard'a dokunulmaz.
- [ ] **Sertifika sonrası:** Auth authorized domains ve OAuth JavaScript origin
      listesine `app.hatayiyasat.com` eklenir.
- [ ] **CI secret:** `FIREBASE_SERVICE_ACCOUNT_SAVEHATAY` eklenir; eklenmezse
      canlı deploy yerelden `scripts/deploy_web.sh live` ile yapılır.

### Sonraki aşama

- [ ] Yayından 24–48 saat sonra enforcement'ı sırayla aç (Storage → Firestore → Functions).
- [ ] Rules sertleştirmesi ayrı repo (`life_admin`) ve ayrı PR: F-01 Storage yazma,
      F-02 grup rolü yükseltme, F-03 `email_verified`.

## 8. Açık kaynak sınırı

Bu repo herkese açıktır. Repoya **girmez**:

- Servis hesabı JSON'u, OAuth token'ı, `FIREBASE_TOKEN`, `.env` dosyaları
- Kişisel hesap e-postaları (`FIREBASE_ACCOUNT` env ile verilir)
- Özel anahtarlar ve şifreler

Repoya **girebilir**: Firebase web API anahtarı ve reCAPTCHA Enterprise site
anahtarı. İkisi de tasarım gereği herkese açıktır, paketle tarayıcıya iner.
