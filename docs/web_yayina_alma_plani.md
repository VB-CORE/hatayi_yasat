# Web yayına alma planı

Bu plan, "tamam" dedikten sonra çalıştırılacak sıradır. Her aşama bir kapı: bir
sonrakine geçmek için öncekinin çıktısı görülmeli. Canlıya çıkış ve App Check
enforcement **ayrı ayrı onay** ister.

Referans: [domain runbook](web_domain_baglama.md) · [App Check kurulumu](web_app_check.md) ·
[SECURITY_AUDIT.md](../SECURITY_AUDIT.md)

## Durum (20.10.2026)

Kod ve doküman tarafı hazır; **hiçbir deploy yapılmadı**. Değişiklikler
`feautre/deploy_firebase` branch'inde, henüz commit edilmedi. Sahibinin tarafındaki
adımlar bekleniyor; onlar bitince Aşama 1 çalıştırılır.

### Senin tarafın (bekliyor)

- [ ] reCAPTCHA Enterprise anahtarı — GCP → reCAPTCHA Enterprise → Web key
      (alan adları: `app.hatayiyasat.com`, `savehatay.web.app`, `localhost`)
- [ ] Firebase Console → App Check → Apps → Web → anahtarı bağla
- [ ] GitHub → Settings → Variables → `RECAPTCHA_ENTERPRISE_SITE_KEY`
- [ ] Firebase Console → Hosting → `savehatay` → Add custom domain →
      `app.hatayiyasat.com`
- [ ] İsimtescil → DNS Yönetimi → çıkan `TXT` + `app` `CNAME` kayıtları
- [ ] Auth authorized domains, Google OAuth origins, Apple return URL, Storage CORS
- [ ] Preview review (Aşama 1'den sonra)
- [ ] `main`'e merge + live deploy + enforcement için ayrı onay

### Benim tarafım (hazır, tetiklenmeyi bekliyor)

- Preview build + deploy (Aşama 1)
- Anahtar geldikten sonra yeniden deploy + `X-Firebase-AppCheck` doğrulaması (Aşama 3)
- Live deploy (onay sonrası, Aşama 5)

## Aşama 0 — Son yerel test (yapıldı, 20.10.2026)

| Kontrol | Sonuç |
|---|---|
| `flutter analyze` | 0 hata; 15 mevcut bilgi/uyarı (bu değişikliklerle ilgisiz) |
| `flutter test` | 6 geçti, 2 başarısız — **ikisi de bu değişikliklerden önce de kırıktı** (stash ile doğrulandı) |
| `scripts/web_build.sh` uçtan uca | Başarılı, sızıntı kontrolleri temiz (`build/web is clean, 49M`) |
| App Check anahtarı pakette | ✅ (build argümanı işliyor) |
| Source map / servis hesabı / Mongo URI | ✅ yok |
| Yalnızca Firebase web API anahtarı | ✅ tek `AIza…` |
| Güvenlik başlıkları (yerel hosting) | ✅ CSP-Report-Only + nosniff + frame + referrer + permissions |
| SPA derin link (`/news/...`) | ✅ 200 |
| `.symbols` dosyaları | ✅ yayına çıkmıyor (build'de siliniyor, ayrıca ignore'da) |

Kalan tek doğrulanamayan şey **tarayıcıda çalışma**: giriş, App Check token'ı, görsel
yükleme. Bu ancak preview URL'de görülür → Aşama 1.

## Aşama 1 — Preview deploy (ben, ~5 dk)

```bash
FIREBASE_ACCOUNT=vbacik.10@gmail.com scripts/deploy_web.sh preview
```

Çıktı: `https://savehatay--<channel>-<hash>.web.app` (1 gün geçerli, listelenmez).

Bu aşamada App Check anahtarı **yok** → App Check kapalı. Bilinçli: önce uygulamanın
kendisi doğru çalışsın.

## Aşama 2 — Preview review (sen)

- [ ] Ana sayfa, haber detayı, mekan detayı, arama
- [ ] Google ile giriş (popup kapanıyor mu, oturum açılıyor mu)
- [ ] Apple ile giriş
- [ ] Sayfa yenileme + derin link
- [ ] Görseller, video, PDF
- [ ] Mobilde bozulan bir şey var mı (iOS/Android build'i etkilenmedi ama kontrol)

**Kapı:** burada bir sorun varsa canlıya çıkmıyoruz; düzelt → yeniden preview.

## Aşama 3 — App Check anahtarı (sen 2 dk, ben 3 dk)

1. GCP → reCAPTCHA Enterprise → Create key (web, alan adları: `app.hatayiyasat.com`,
   `savehatay.web.app`, `localhost`).
2. Firebase Console → App Check → Apps → Web → anahtarı bağla.
3. GitHub → Settings → Variables → `RECAPTCHA_ENTERPRISE_SITE_KEY`.
4. Ben preview'ı anahtarla yeniden deploy ederim; DevTools → Network'te
   `X-Firebase-AppCheck` başlığını doğrularım.

Bu aşamada yalnızca **monitor** — enforcement yok.

## Aşama 4 — Domain (Console + İsimtescil)

1. Firebase Console → Hosting → `savehatay` → Add custom domain → `app.hatayiyasat.com`.
2. Çıkan TXT + CNAME'i İsimtescil DNS Yönetimi'ne gir (ad alanı `app`, tam ad değil).
3. Sertifika çıkana kadar bekle; `curl -sI https://app.hatayiyasat.com` → 200.
4. Domain'e bağlı ayarlar (Auth authorized domains, Google OAuth origins, Apple return
   URL, Storage CORS) — [runbook §4](web_domain_baglama.md).

**Kapı:** sertifika + giriş çalışmadan canlı yok.

## Aşama 5 — Canlı deploy (ayrı onay)

1. Branch `feautre/deploy_firebase` → PR → `main` (CI `analyze` yeşil olmalı).
2. `main` üzerinde: `FIREBASE_ACCOUNT=vbacik.10@gmail.com scripts/deploy_web.sh live`
   ya da GitHub Actions → Deploy Web → `live`.
3. Smoke test ([runbook §5](web_domain_baglama.md)).

Geri alma: Console → Hosting → Release history → **Rollback** (saniyeler içinde).

## Aşama 6 — App Check enforcement (yayından 24-48 saat sonra)

Sırayla, her adımdan sonra bir tur gezinti:

1. Storage → Enforce
2. Firestore → Enforce
3. Cloud Functions → Enforce

`permission-denied` artarsa aynı yerden **Monitor**'a geri al (deploy gerekmez).

## Aşama 7 — Rules sertleştirme (ayrı PR, ilk hafta)

Bunlar web yayınını bloklamaz ama asıl "kim ne yazabilir" sorusunun cevabı:
F-01 (Storage yazma), F-02 (grup rolü yükseltme), F-03 (`email_verified`).

Repo **life_admin**; orada commit'lenmemiş çalışma var, o yüzden ayrı ve temiz bir
branch'te ele alınmalı. Rules değişikliği `firebase/test/rules.test.mjs` ile birlikte
gitmeli.

## Onay sınırları

Ben şunları **onay olmadan yapmam**:

- `live` deploy
- App Check enforcement
- `life_admin` reposunda değişiklik
- DNS kaydı silme/değiştirme (panel erişimi sende)
