# Web Geçişi — Kalan İş Planı

> **Repo:** `VB-CORE/hatayi_yasat` · **EPIC:** [#535](https://github.com/VB-CORE/hatayi_yasat/issues/535) · **Milestone:** Web Geçişi · **Tarih:** 18 Ekim 2026

---

## 1. Nerede duruyoruz

Web geçişi planında **46 kod** (WEB-01 … WEB-46) var:

| Durum | Adet | Açıklama |
|---|---|---|
| Kapalı | 14 | tamamlandı |
| Açık | 21 | #535'in alt issue'su, `label:WEB` ile filtrelenir |
| **Eksik** | **11** | GitHub'da issue'su yok — aşağıda ele alınıyor |

Kalan tahmini efor: **~36 kişi-gün** (WEB-15 hariç; açılırsa +2 hafta).

**Kritik yol** (açık → açık bağımlılıklar):

```
WEB-46 (#514) Merchant veri topla   ──►  WEB-15 (#492) masaüstü layout kararı
WEB-25 (#501) Storage CORS          ──►  WEB-33 (#520) Storage rules  [admin]
WEB-24 (#505) Maps Web              ──►  WEB-31 (#507) Maps key kısıtı
WEB-42 (#512) merkezi facade'lar    ──►  WEB-35 (#516) Web hata izleme
```

**Bloker'lar:** WEB-30 (#502 yetkili domain / OAuth) · WEB-40 (#513 `dart:io`)

---

## 2. Bu branch'te ne yapıldı

Branch: `chore/repo-name-align` → PR [#537](https://github.com/VB-CORE/hatayi_yasat/pull/537)

| Değişiklik | Neden |
|---|---|
| `origin` remote `life_client` → `hatayi_yasat`; yinelenen `fork` remote kaldırıldı | Repo'nun kanonik adı `hatayi_yasat`; `life_client` 301 ile buraya yönleniyor |
| `CLAUDE.md`, `.claude/skills/*` (5), `.claude/agents/*` (1) | Repo atıfları kanonik ada çekildi |
| `docs/open_source_check.md` | `git clone` talimatları düzeltildi |
| `docs/reference_links.md` (yeni) | #127'deki Figma/Postman/mockup bağlantıları buraya taşındı, issue kapatıldı |
| `docs/web-gecisi-plani.md` (bu dosya) | Web geçişi kalan iş planı |

Dokunulmayanlar: `pubspec.yaml` → `name: lifeclient` (Dart paket adı, import'ları kırar) · lokal çalışma dizini adı.

---

## 3. Eksik 11 kod

Bu kodlar **hiçbir yerde bulunamadı**: ne repo çalışma ağacında, ne 417 branch'in commit geçmişinde, ne de GitHub'da 221 issue / 60 PR metninde. Yalnızca harici plan dokümanında yaşıyorlar.

> ⚠️ Aşağıdaki başlıklar ve kabul kriterleri **öneridir** — plan dokümanındaki gerçek içerik değil. Sıra numaralarına bakarak çıkarılmış tahminlerdir. Gerçek içerikle değiştirilmesi gerekiyor.

### WEB-07 · WEB-08 · WEB-09
*Komşuluk: WEB-06 (build boyutu + cache header, kapalı) ↔ WEB-10 (web kabuğu, kapalı)*

- **WEB-07 — öneri:** Meta ve PWA temel ayarları (`web/index.html` başlık/favicon, `manifest.json`, `theme-color`, apple-touch-icon). *Kabul:* sekme başlığı ve ikon doğru · manifest geçerli, "Ana ekrana ekle" çalışıyor.
- **WEB-08 — öneri:** İkon fontlarının subset'lenmesi. `docs/web_build_size.md` ölçümüne göre ilk yüklemenin **18,9 MB'ının 15,6 MB'ı** üç Material Symbols varyantı. *Kabul:* ilk yükleme < 5 MB · eksik ikon yok · mobil build boyutu artmıyor.
- **WEB-09 — öneri:** İlk açılış (boot) deneyimi — yavaş ağda boş beyaz ekran yerine yükleme göstergesi, splash ↔ ilk frame geçişi, hata durumunda yeniden dene.

### WEB-16 · WEB-17 · WEB-18 · WEB-19
*Komşuluk: WEB-15 (merchant masaüstü kararı) ↔ WEB-20 (hash'siz temiz URL) — yani layout→routing geçiş bölgesi*

- **WEB-16 — öneri:** Erişilebilirlik (a11y) tabanı — görünür odak halkası, mantıklı `Tab` sırası, ikon-only butonlarda anlamsal etiket.
- **WEB-17 — öneri:** Bilinmeyen rota / 404 davranışı — geçersiz URL'de anlaşılır "sayfa bulunamadı" ekranı + dönüş yolu, Hosting rewrite kuralıyla tutarlı.
- **WEB-18 — öneri:** Sekme başlığı ↔ rota eşlemesi (`document.title` her ekranda doğru; geri/ileri'de senkron).
- **WEB-19 — öneri:** Ortak iskelet bileşenleri ve scroll bütünlüğü — AppBar / alt gezinme / masaüstü sidebar; iç içe scroll'da çift scrollbar olmaması.

### WEB-29
*Komşuluk: WEB-28 (metin seçimi, sağ tık, zoom, kapalı) ↔ WEB-30 (yetkili domain + OAuth, açık)*

- **WEB-29 — öneri:** Web'de paylaşma ve dosya indirme davranışı — mobildeki sistem paylaşım menüsünün karşılığı yok; linki panoya kopyalama, afiş/dosya indirme, takvim `.ics` akışları. *Bağımlılık:* WEB-42 (açık, #512).

### WEB-37 · WEB-38 · WEB-39
*Komşuluk: güvenlik kümesi — WEB-36 (güvenlik header'ları) ↔ WEB-40 (`dart:io`)*

- **WEB-37 — öneri:** App Check'in web'de zorunlu hale getirilmesi — reCAPTCHA v3, production'da zorunlu / dev'de debug token, açılışı bloklamamalı (bkz. geçmiş PR #523). *Bağımlılık:* WEB-30 (açık, #502).
- **WEB-38 — öneri:** Sunucu tarafı yetki ve oran sınırı — web'de tüm çağrılar tarayıcıdan görünür olduğu için Cloud Functions'ta yetki doğrulaması, anonim kullanıma sınır. *Bağımlılık:* WEB-34 (açık, #509).
- **WEB-39 — öneri:** Çerez / analitik onayı ve gizlilik — onay alınmadan analitik başlamaması, KVKK ekranıyla tutarlılık. *Bağımlılık:* WEB-34 (açık, #509).

### Karar tablosu

| Kod | Karar | Tahmin | Not / bağımlılık |
|---|:---:|---|---|
| WEB-07 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-08 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-09 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-16 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-17 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-18 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-19 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-29 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-37 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-38 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |
| WEB-39 | ☐ Aç &nbsp; ☐ Kapsam dışı | | |

---

## 4. Kod haritası (WEB-01 → WEB-46)

| Kod | Issue | Durum | Başlık |
|---|---|---|---|
| WEB-01 | #486 | kapalı | Firebase web uygulama yapılandırması |
| WEB-02 | #487 | kapalı | Firebase Hosting yapılandırması |
| WEB-03 | #490 | kapalı | Flutter Web platform iskeleti |
| WEB-04 | #496 | açık | Hosting dağıtım workflow'u |
| WEB-05 | #488 | açık | CI Flutter sürümü + web build |
| WEB-06 | #495 | kapalı | Build boyutu + cache header |
| **WEB-07** | — | **EKSİK** | ? |
| **WEB-08** | — | **EKSİK** | ? |
| **WEB-09** | — | **EKSİK** | ? |
| WEB-10 | #497 | kapalı | Ortalanmış sabit genişlikli kabuk |
| WEB-11 | #494 | kapalı | Responsive paket + breakpoint |
| WEB-12 | #489 | açık | `dynamicWidth/Height` denetimi |
| WEB-13 | #491 | açık | Sheet / dialog / overlay |
| WEB-14 | #493 | açık | Sabit piksel denetimi — [rapor](web_fixed_sizes.md) |
| WEB-15 | #492 | açık | Merchant masaüstü layout kararı |
| **WEB-16** | — | **EKSİK** | ? |
| **WEB-17** | — | **EKSİK** | ? |
| **WEB-18** | — | **EKSİK** | ? |
| **WEB-19** | — | **EKSİK** | ? |
| WEB-20 | #498 | kapalı | Hash'siz temiz URL |
| WEB-21 | #504 | kapalı | Yenilemede auth yarışı |
| WEB-22 | #500 | kapalı | Tarayıcı geri/ileri |
| WEB-23 | #506 | kapalı | Mouse, klavye, hover, focus |
| WEB-24 | #505 | açık | Google Maps Web desteği |
| WEB-25 | #501 | açık | Storage CORS |
| WEB-26 | #508 | açık | FCM Web Push |
| WEB-27 | #499 | açık | WebView → iframe / yeni sekme |
| WEB-28 | #503 | kapalı | Metin seçimi, sağ tık, zoom |
| **WEB-29** | — | **EKSİK** | ? |
| WEB-30 | #502 | açık | Yetkili domain + OAuth origin |
| WEB-31 | #507 | açık | Maps key kısıtı + bütçe alarmı |
| WEB-32 | #519 | açık | Firestore rules (admin) |
| WEB-33 | #520 | açık | Storage rules + CORS (admin) |
| WEB-34 | #509 | açık | İstemci sır taraması |
| WEB-35 | #516 | açık | Web hata izleme |
| WEB-36 | #511 | açık | Hosting güvenlik header'ları |
| **WEB-37** | — | **EKSİK** | ? |
| **WEB-38** | — | **EKSİK** | ? |
| **WEB-39** | — | **EKSİK** | ? |
| WEB-40 | #513 | açık | `dart:io` platform-nötr |
| WEB-41 | #510 | kapalı | Web sosyal girişi popup/redirect |
| WEB-42 | #512 | açık | Merkezi facade'lar |
| WEB-43 | #518 | kapalı | `webview_flutter` kaldırıldı |
| WEB-44 | #517 | açık | Mobil regresyon kapsamı |
| WEB-45 | #515 | kapalı | Kurallar CLAUDE.md/CONTRIBUTING |
| WEB-46 | #514 | açık | Merchant kullanım verisi |

---

## 5. Kararı uygulama

Yeni issue açmak için:

```bash
gh issue create --repo VB-CORE/hatayi_yasat \
  --title "WEB-07 Meta ve PWA temel ayarları" \
  --label WEB --milestone "Web Geçişi" \
  --body-file web-07.md
```

Sonra EPIC #535'in altına bağla:

```bash
PID=$(gh api repos/VB-CORE/hatayi_yasat/issues/535 --jq .node_id)
CID=$(gh api repos/VB-CORE/hatayi_yasat/issues/<yeni-no> --jq .node_id)
gh api graphql \
  -f query='mutation($p:ID!,$c:ID!){addSubIssue(input:{issueId:$p,subIssueId:$c}){subIssue{number}}}' \
  -f p="$PID" -f c="$CID"
```

"Kapsam dışı" işaretlenenler için issue açmaya gerek yok; #535'teki kayıp kodlar bölümüne gerekçesiyle not düşülmesi yeterli.

---

## 6. Sırada bekleyenler

| Konu | Durum |
|---|---|
| PR #322 (`feature/uitest`) | **draft'a alındı**, açık bekliyor — 2025-06'dan, CONFLICTING, main'in 550 commit gerisinde |
| PR #534 → #496 (Hosting deploy) | `Closes #496` eklendi, merge bekliyor |
| PR #533 → #499 (About yeni sekme) | Merge bekliyor; #499 kabul kriteri iframe istiyordu, site `frame-ancestors` ile engelliyor |
| PR #530 → #505 (Maps Web) | **#507 bekliyor** (Maps web key) |
| Branch budama | **Yapılmadı** — karar: 417 remote branch olduğu gibi kalıyor |
| Org project board'ları | 4 board var; **#2 "Hatay'ı Yaşat"** aktif (public, 22 web item eklendi) |
| Sunucu tarafı aksiyonları | Firebase + GCP checklist'i **#535 yorumunda** |
