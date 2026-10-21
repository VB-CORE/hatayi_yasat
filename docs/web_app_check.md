# Web App Check — kurulum ve yayın kontrolü

Web yayınında kötüye kullanımın asıl kapısı burasıdır: Firebase web API anahtarı
herkeste olduğu için, tarayıcıdan Firestore/Storage'a doğrudan istek atmayı
engelleyen tek şey App Check'tir. Kaynak: [SECURITY_AUDIT.md](../SECURITY_AUDIT.md) F-05.

## Kod tarafı (bu repoda yapıldı)

| Dosya | Değişiklik |
|---|---|
| [app_check_initialize_web.dart](../lib/product/init/app_check/app_check_initialize_web.dart) | No-op yerine gerçek aktivasyon: yayında reCAPTCHA Enterprise, debug'da web debug provider |
| [firebase.json](../firebase.json) | CSP (Report-Only), `X-Content-Type-Options`, `Referrer-Policy`, `X-Frame-Options`, `Cross-Origin-Opener-Policy`, `Permissions-Policy`; `**/*.symbols` yayına çıkmıyor |
| [scripts/web_build.sh](../scripts/web_build.sh) | `--dart-define=RECAPTCHA_ENTERPRISE_SITE_KEY=...`, anahtar yoksa uyarı |
| [deploy_web.yml](../.github/workflows/deploy_web.yml) | Anahtarı `vars.RECAPTCHA_ENTERPRISE_SITE_KEY`'ten build adımına geçirir |

Mobil taraf değişmedi: `app_check_initialize_io.dart` aynı kaldı, `activate()` yalnızca
web implementasyonunda dolduruldu.

Anahtar gizli **değildir** (paketle tarayıcıya iner), o yüzden secret değil repository
variable olarak tutulur.

## Elle yapılacaklar (konsol)

1. **reCAPTCHA Enterprise anahtarı**: Google Cloud → reCAPTCHA Enterprise → Create key
   → Web sitesi, alan adları `app.hatayiyasat.com`, `savehatay.web.app`,
   `localhost`. Anahtarı kopyala.
2. **App Check'e bağla**: Firebase Console → App Check → Apps → Web → reCAPTCHA Enterprise
   → anahtarı yapıştır.
3. **GitHub**: repo → Settings → Secrets and variables → Actions → Variables →
   `RECAPTCHA_ENTERPRISE_SITE_KEY` = aynı anahtar.
4. **Debug token** (isteğe bağlı): `flutter run -d chrome` yapıp konsolda yazdırılan
   token'ı App Check → Apps → Manage debug tokens altına ekle. Sabit token için
   `--dart-define=APP_CHECK_DEBUG_TOKEN=...`.

## Enforcement sırası (atlanırsa web kırılır)

1. Anahtarı gir, preview kanalına deploy et (`scripts/deploy_web.sh preview`).
2. App Check → Metrics'te **doğrulanmamış istek oranını izle**. Giriş (Google/Apple),
   haber ve mekan detayı, arama, görsel yükleme akışlarını gez — doğrulanmamış istek
   görünmemeli.
3. Sırayla **monitor → enforce**: önce Storage, sonra Firestore, sonra Cloud Functions.
4. Her adımdan sonra bir tur daha gez; `permission-denied` artışı varsa enforcement'ı geri al.

## Okuma/yazma limitleri — rules tarafı

App Check "yalnızca gerçek uygulama çağırabilir" der; **kim ne yazabilir** kısmı
rules'ta ve rules **life_admin** reposunda yaşar (`firebase/firestore.rules`,
`firebase/storage.rules`, testler `firebase/test/rules.test.mjs`) — bkz.
[CLAUDE.md](../CLAUDE.md) §"Firestore rules ve index'ler bu repoda değil".

Yayından önce kapatılması gerekenler (audit F-01, F-02, F-03):

- Storage'da haber/mekan/ilan görsellerine giriş yapan herkesin `write` (siler,
  üzerine yazar) yetkisi var.
- `groups/{id}/members/{uid}` create/update'inde alan doğrulaması yok → kullanıcı
  kendini `role: 2` ile grup yöneticisi yapabiliyor.
- `isAdmin()` doğrulanmış e-postayı aramıyor.

Bunlar bu repodaki değişikliklerle kapanmaz; rules PR'ı + `rules.test.mjs` ayrı iş.

## Doğrulama

```bash
# Anahtar verilmiş bir build
RECAPTCHA_ENTERPRISE_SITE_KEY=<key> bash scripts/web_build.sh

# Güvenlik başlıkları (deploy sonrası)
curl -sI https://app.hatayiyasat.com | grep -i -E 'content-security|x-frame|referrer|permissions|content-type-options'
```

Tarayıcıda Application → Storage/cookies içinde App Check token'ının oluştuğu ve
Network sekmesinde isteklerin `X-Firebase-AppCheck` başlığı taşıdığı görülmelidir.
