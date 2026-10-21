# Domain bağlama ve yayına alma runbook'u

Hedef: `app.hatayiyasat.com` → Firebase Hosting sitesi `savehatay`.
Mevcut pazarlama sitesi (`www.hatayiyasat.com`, Google Sites) olduğu gibi kalır.

## 0. Bugünkü durum (ölçüldü — 20.10.2026)

| Host | DNS | HTTPS | Ne sunuyor |
|---|---|---|---|
| `www.hatayiyasat.com` | Google (`ghs.googlehosted.com`) | çalışıyor | Google Sites, canlı pazarlama sitesi |
| `hatayiyasat.com` | Google'a CNAME'lenmiş | **sertifika yok** | Google 404 |
| `app.hatayiyasat.com` | Google'a CNAME'lenmiş | **sertifika yok** | Google 404 |
| `savehatay.web.app` | Firebase | çalışıyor | Hosting sitesi `savehatay`, **boş** (404) |

Notlar:

- `app.hatayiyasat.com` şu an Google'ın ön yüzüne (`ghs.googlehosted.com`) bakıyor ama
  hiçbir Google ürününe bağlı değil: sertifika yok, 404 dönüyor.
- **DNS İsimtescil'de.** `isimtescil.net`'in nameserver'ları `us/eu/tr.dnsenable.com`;
  yani DNSEnable İsimtescil'in kendi DNS altyapısı. Kayıtlar İsimtescil müşteri
  panelindeki **DNS Yönetimi**'ne girilir, başka bir panele bakmaya gerek yok.
- **Kök adreste (apex) CNAME var:** `hatayiyasat.com CNAME ghs.googlehosted.com`.
  Bu DNS kurallarına aykırı (CNAME, SOA/NS/MX ile aynı isimde olamaz); sonuç olarak
  `NS`, `SOA`, `MX`, `TXT` sorgularının hepsi CNAME dönüyor. **Bu domainde e-posta
  kaydı yok** — ileride e-posta kurulursa önce bu CNAME kaldırılmalı.
- **Wildcard var:** `*.hatayiyasat.com CNAME ghs.googlehosted.com` — rastgele bir alt
  alan adı bile Google'a çözülüyor. `app` için açık kayıt yok; eklenecek açık kayıtlar
  wildcard'ı ezer, `www` ve apex etkilenmez.
- `www`'nin kendi kaydı mı yoksa wildcard'dan mı geldiği dışarıdan anlaşılmıyor; panelde
  görülür. Eğer `www` de yalnızca wildcard'dan geliyorsa, wildcard'ı silmeden önce
  `www`'ye açık CNAME ekle, yoksa pazarlama sitesi düşer.
- `hatayiyasat.com` apex'i de kırık (sertifika yok). Bu runbook'un konusu değil; ayrı
  karar: apex'i `www`'ye 301 ile yönlendirmek.

## 1. Ön koşullar

- [ ] `firebase login:use vbacik.10@gmail.com` — `savehatay` projesine erişen hesap bu.
      (`veli@classlist.com` ile `firebase hosting:sites:list` **403** veriyor.)
      Tek seferlik deploy için: `FIREBASE_ACCOUNT=vbacik.10@gmail.com scripts/deploy_web.sh preview`.
- [ ] `savehatay` sitesine en az bir kez deploy yapılmış (`scripts/deploy_web.sh preview`).
      Boş siteye de domain bağlanır ama kullanıcı 404 görür.
- [ ] DNS paneline erişim: **İsimtescil müşteri paneli** (DNSEnable / registrar değil).

### İsimtescil'de kayıt girmek

Panel yolu: **isimtescil.net → Müşteri Paneli → Alan Adları → hatayiyasat.com →
DNS Yönetimi**. (Arayüz adı sürüme göre "DNS Ayarları" da olabilir.)

- **Ad/Host** alanına tam alan adı değil, kısa ad yazılır: `app`, `www`, `@`.
- **TXT** kaydının değeri tırnak içinde yapıştırılmaz; konsolun verdiği metni olduğu
  gibi gir.
- TTL `3600` yeterli.
- Aynı host için eski kaydı silmeden yenisini eklersen iki kayıt çakışır; önce sil,
  sonra ekle.
- Kayıtlar 5–60 dakikada yayılır. Kontrol: `dig +short app.hatayiyasat.com`.

`app` için eklenecek açık kayıtlar mevcut wildcard'ı ezer, `www` ve apex etkilenmez.

## 2. Domaini Firebase'e bağla (Console)

1. Firebase Console → **Hosting** → site **savehatay** → **Add custom domain**.
2. `app.hatayiyasat.com` yaz, devam et.
3. Konsolun verdiği kayıtları **birebir** DNS paneline gir. Tipik olarak:
   - **Sahiplik doğrulama:** `TXT` kaydı (host ve değer konsolda yazar). Domain başka bir
     Google ürününde doğrulanmışsa bu adım atlanabilir.
   - **Yönlendirme:** alt alan adı için `CNAME` → `savehatay.web.app`.
     Bugün `app` için açık bir kayıt yok, wildcard'dan çözülüyor; bu yüzden CNAME'i
     **yeni kayıt** olarak ekle. Konsol `ghs.googlehosted.com` derse onu kullan.
4. Kayıtları kaydet, Console'da **Verify** / **Done**.

Uyarılar:

- **Cloudflare kullanılıyorsa proxy kapalı olmalı** (gri bulut). Turuncu bulut açıkken
  Google sertifika veremez, domain "Needs setup"ta kalır.
- Aynı host için tek bir yönlendirme kaydı olsun: eski `CNAME`/`A` kayıtlarını sil,
  ikisini birden bırakma.
- CAA kaydı varsa `pki.goog` (veya `letsencrypt.org`) izinli olmalı, yoksa sertifika
  verilmez.
- Bu domainde CAA yok, o yüzden ek adım gerekmiyor.
- **Konsol TXT'i `@` (apex) için isterse:** apex'te CNAME olduğu için TXT aynı isimde
  duramaz. O durumda önce `www` için açık CNAME'i ekle, sonra apex CNAME'ini kaldır,
  TXT'i gir. `app` için TXT istenirse sorun yok, doğrudan eklenir.
- İsimtescil panelinde kayıt "Ad" alanı `app.hatayiyasat.com` değil **`app`** olmalı.

## 3. Sertifikayı bekle ve doğrula

Süre: genelde 15 dakika – 2 saat, en fazla 24 saat.

```bash
dig +short app.hatayiyasat.com            # CNAME zinciri görünmeli
curl -sI https://app.hatayiyasat.com      # HTTP/2 200 + x-served-by
curl -s  https://app.hatayiyasat.com | head -c 200   # Flutter index.html
```

Konsolda domain durumu **Connected** olmalı. 24 saati geçtiyse sırayla bak:
DNS kaydı doğru mu → proxy kapalı mı → CAA kaydı → Console'daki domaini silip yeniden ekle.

## 4. Domain'e bağlı uygulama ayarları

Domain değişince aşağıdakiler de güncellenmeli; biri eksik kalırsa giriş veya görseller
sessizce kırılır.

| Ayar | Nerede | Değer |
|---|---|---|
| Authorized domains | Firebase Auth → Settings | `app.hatayiyasat.com`, `savehatay.web.app` (preview), `localhost` yalnızca geliştirmede |
| Google OAuth | GCP → Credentials → OAuth client | Authorized JavaScript origins + redirect URI: `https://app.hatayiyasat.com` |
| Apple | Apple Developer → Services ID | Return URL: `https://savehatay.firebaseapp.com/__/auth/handler` + domain listesine `app.hatayiyasat.com` |
| Storage CORS | GCS bucket `savehatay.appspot.com` | origin: `https://app.hatayiyasat.com`, `https://savehatay.web.app` |
| CSP (Report-Only) | [firebase.json](../firebase.json) | `frame-src`/`connect-src` içinde `savehatay.firebaseapp.com` var; canlıda ihlal çıkarsa ekle |
| reCAPTCHA Enterprise | GCP → reCAPTCHA | alan adları: `app.hatayiyasat.com`, `savehatay.web.app`, `localhost` |

## 5. Yayına alma sırası

Ayrıntılı, aşama kapılı plan: [web_yayina_alma_plani.md](web_yayina_alma_plani.md).

Bu sıra atlanırsa en sık görülen sonuç: App Check enforcement açık + anahtar yok →
web'de her istek `permission-denied`.

1. **Preview deploy** — `scripts/deploy_web.sh preview`. Preview URL'de tam tur at.
2. **App Check anahtarı** — [docs/web_app_check.md](web_app_check.md) adımları; GitHub
   repository variable `RECAPTCHA_ENTERPRISE_SITE_KEY` ekli olsun.
3. **Domain testi** — `https://app.hatayiyasat.com` üzerinde giriş (Google/Apple),
   haber/mekan detayı, arama, görsel yükleme.
4. **App Check monitor → enforce** — Storage → Firestore → Functions sırasıyla, her
   adımdan sonra bir tur daha gez.
5. **Live deploy** — `scripts/deploy_web.sh live` (main + temiz çalışma ağacı ister).
6. **Smoke test** — aşağıdaki liste.

### Smoke test

- [ ] `https://app.hatayiyasat.com` açılıyor, sertifika geçerli (kilit ikonu)
- [ ] `http://` → `https://` yönleniyor
- [ ] Google ile giriş popup'ı kapanıyor, oturum açılıyor
- [ ] Apple ile giriş (Safari + Chrome)
- [ ] Sayfa yenilemesi derin linkte 404 vermiyor (`rewrites` çalışıyor)
- [ ] Görseller yükleniyor (Storage CORS)
- [ ] Arama çalışıyor (Cloud Function + MongoDB)
- [ ] DevTools → Network: isteklerde `X-Firebase-AppCheck` başlığı var
- [ ] Console'da CSP `[Report Only]` ihlali yok
- [ ] `curl -sI https://app.hatayiyasat.com` güvenlik başlıklarını döndürüyor

## 6. Geri alma

| Durum | Yapılacak |
|---|---|
| Sertifika çıkmadı | Console'dan domaini sil, DNS'i eski hâline döndür |
| App Check web'i kırdı | Console'da enforcement'ı **monitor**'a al (deploy gerekmez) |
| Yeni sürüm bozuk | Console → Hosting → Release history → önceki sürüme **Rollback** |
| Domain tamamen kapatılacak | Console'dan domaini sil; `app` CNAME'ini kaldır |

## 7. Sık hatalar

| Belirti | Neden | Çözüm |
|---|---|---|
| `SSL_ERROR_SYSCALL` / `SSL handshake failed` | Sertifika henüz yok | Sertifikanın çıkmasını bekle |
| `DNS_PROBE_FINISHED_NXNAME` | Kayıt yanlış host'a girilmiş | Host alanı: `app` (tam ad değil) |
| "Needs setup" hiç değişmiyor | Cloudflare proxy açık / CAA engeli | Proxy'yi kapat, CAA'ya `pki.goog` ekle |
| 404 ama sertifika var | Siteye deploy yok ya da yanlış site | `firebase hosting:sites:list`, doğru `target` |
| Giriş "unauthorized domain" | Auth authorized domains eksik | §4 tablosu |
| Görseller 403 | Storage CORS eksik | §4 tablosu |
