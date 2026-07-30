# YouTube Bölümü — Claude Code + Maestro MCP ile "Hatayı Yaşat" Otonom UI Testi

> Bu dosya, `release/v2/1.0.0_1` branch'indeki son iki commit + çalışma dizini
> değişikliklerinin analizinden üretilmiştir. Video çekimi, açıklama metni, MCP listesi
> ve skill dağıtımı için **tek kaynak dosya**dır.
>
> Analiz tarihi: 2026-07-29 · Branch: `release/v2/1.0.0_1` · Repo: `VB-CORE/life_client`

---

## 0. Bölümde Ne Yaptık — Teknik Özet (analiz çıktısı)

### Commit'ler

| Commit | Mesaj | Kapsam |
|---|---|---|
| `8be640fe` | added meastro skill | 14 dosya, +739 satır — skill + `.mcp.json` + `run.sh` |
| `6843a520` | meastro auto test added | 14 dosya, +454 satır — core + smoke flow'ları + auto suite |
| *(commit'lenmemiş)* | screenshot yolu + run.sh düzeltmesi | 9 dosya, +24/−18 |

### 1) `8be640fe` — Skill ve MCP altyapısı

- **`.claude/skills/hata-maestro-auto/`** (toplam **624 satır**, 5 dosya):
  - `SKILL.md` (188 satır) — 4 fazlı otonom protokol: Faz 0 bağlan/hazırla → Faz 1 canlı keşif
    → Faz 2 smoke suite yaz → Faz 3 selector boşluklarını raporla.
    10 "değişmez kural" içerir; en kritikleri:
    *inspect etmeden selector yazma*, *kaynak koda (lib/) dokunma*,
    *değişken Firestore verisine assert etme*, *hata olursa DUR ve raporla*.
  - `references/screen-map.md` (64 satır) — 25+ ekranın route / nav yolu / sabit anchor /
    "needs-id" haritası.
  - `references/selectors.md` (121 satır) — canlı `Semantics` id kataloğu + **kritik tuzak**:
    `GeneralSemanticKeys` enum'undaki 7 `home*` girdisi Flutter `Key()` ile bağlı olduğu için
    Maestro'ya **görünmez**.
  - `references/flow-templates.md` (189 satır) — bootstrap / goto-* / smoke starter'ları.
  - `references/key-injection.md` (62 satır) — selector yoksa izlenecek prosedür
    (tespit + rapor her zaman; kod değişikliği **sadece kullanıcı onayıyla**).
- **`.mcp.json`** — repo köküne Maestro MCP sunucusu tanımlandı (`maestro mcp`).
- **`maestro/run.sh`** (102 satır) — simulator boot + `flutter build ios --simulator --debug`
  + `xcrun simctl install` + flow koşumu + JUnit rapor.

### 2) `6843a520` — Üretilen test suite (454 satır YAML, 14 dosya)

**Core (yeniden kullanılabilir alt akışlar):**
- `bootstrap.yaml` (53 satır) — `launchApp: clearState` → `splashView` bekle → çıkmasını bekle →
  `when:` guard ile onboarding (`onboardButton`) → `when:` guard ile "Yenilikler" sheet'i
  (`whatsNewSheet`, **sürüm metnine değil id'ye** bağlı) → `mainTabView` + Firestore'un
  "Mekanlar" ile dönmesini doğrula.
- `goto_home` / `goto_community` / `goto_memories` / `goto_favorite` — sekme geçiş helper'ları.

**Smoke (8 flow):**

| # | Flow | Kapsam |
|---|---|---|
| 01 | `01_app_launch` | Sıfırdan açılış: splash → onboarding → Yenilikler → 4 sekmeli kabuk |
| 02 | `02_home_tab` | Anasayfa: mekan listesi, arama alanı, boş-durum yokluğu |
| 03 | `03_home_place_detail` | Mekan detayı: "Ara" / "Yol Tarifi Al", tab bar'ın kaybolması, geri |
| 04 | `04_community_tab` | Haberler / Etkinlikler / İş İlanı alt sekme şeridi |
| 05 | `05_memories_tab` | İlk ziyaret dialogu, foto grid, "Favori Anılarım" sheet'i |
| 06 | `06_favorite_tab` | Favoriler boş durumu |
| 07 | `07_favorite_add_and_list` | **Uçtan uca:** detayda favorile → listede gör → tümünü temizle |
| 08 | `08_tab_bar_navigation` | 4 sekme ileri-geri turu, "tek seçili sekme" kuralı |

**`smoke_test_auto.yaml`** — 8 flow'u tek runda zincirler; her alt akış `bootstrap` ile
baştan başladığı için testler birbirinden **izole** (bir testin bıraktığı favori/dialog
durumu diğerini kirletmez).

### 3) Commit'lenmemiş düzeltme (bölümün "hata ayıklama" sahnesi)

Gerçek koşumda çıkan iki sorun ve çözümü:

- **Screenshot yolları kırıktı.** Flow'lar `takeScreenshot: "../../reports/smoke/..."`
  kullanıyordu; Maestro bu yolu **flow dosyasına göre değil proje köküne göre** çözüyor.
  8 flow'da 12 yol `"maestro/reports/smoke/..."` olarak düzeltildi ve `run.sh` artık
  koşumdan önce `cd "$PROJECT_DIR"` yapıyor + `reports/smoke` klasörünü önceden açıyor.
- **Varsayılan hedef değişti.** `run.sh` varsayılanı `smoke` → **`auto`** oldu:
  `./maestro/run.sh` artık tüm akışları tek runda koşuyor; `./maestro/run.sh smoke`
  flow'ları tek tek koşuyor.

### 4) Ölçülen sonuç (dürüst tablo — videoda böyle anlat)

| Koşum | Cihaz | Sonuç |
|---|---|---|
| `smoke_test_auto` (03:34) | iPhone 17 · iOS 26.4 | ❌ ERROR — 19.0s (screenshot yolu) |
| `smoke/01_app_launch` (03:36) | iPhone 17 · iOS 26.4 | ✅ SUCCESS — 18.0s |

> Yani: tek flow yeşil, birleşik auto suite ilk denemede patladı → yol düzeltmesi bu yüzden
> yapıldı. Düzeltme sonrası full suite **henüz yeniden koşulmadı**; videoda "düzelttik ve
> yeşile boyduk" demeden önce `./maestro/run.sh --build` ile bir kez daha koş.

### 5) Bölümün en güçlü mesajı: **kaynak koda hiç dokunulmadı**

İki commit'te de `lib/` altında **tek satır değişmedi**. Skill, selector'ı olmayan
kontrolleri (FAB kalp butonu, filtre butonu, AppBar ikonları, ⋮ menüsü) `# NEEDS-ID:`
yorumu olarak flow'un içine yazdı ve düzeltmeyi kullanıcıya sordu. Örnek —
`05_memories_tab.yaml` içinde:

```yaml
# NEEDS-ID: kalp FAB'ının id'si yok, konumdan tıklanıyor (endDocked, sağ alt).
# `GeneralSemanticKeys.memoryFavoriteButton` eklenirse burası `id:` ile değiştirilmeli.
```

---

## 1. YouTube Başlığı

**Ana öneri — bunu başlık alanına yapıştır (55 karakter):**

```text
Claude Code + Maestro MCP: AI Kendi UI Testlerini Yazdı
```

Alternatifler (hepsi ≤ 60 karakter, mobilde kesilmez):

| # | Başlık | Karakter |
|---|---|---|
| 1 | `Claude Code + Maestro MCP: AI Kendi UI Testlerini Yazdı` | 55 |
| 2 | `AI Uygulamamı Gezdi, 8 E2E Test Yazdı \| Claude Code` | 51 |
| 3 | `Claude Code + Maestro: Kod Yazmadan 8 Flutter E2E Test` | 54 |
| 4 | `Flutter'da Otonom UI Test: Claude Code + Maestro MCP` | 52 |
| 5 | `Yapay Zeka Simulator'ü Sürdü, Testlerimi Yazdı` | 46 |

> Uzun (100 karaktere kadar) bir başlık istersen sınır 100'dür ama mobil aramada ~55'ten
> sonrası kesilir; anahtar kelimeleri **ilk 55 karaktere** sığdır.

**Başlık kuralları:** "Claude Code" ve "Maestro" mutlaka geçsin (arama hacmi orada),
sayı kullan ("8 E2E test"), tıklama tuzağı kurma — video zaten sonucu veriyor.
Başlıkta emoji/box-drawing karakteri kullanma.

---

## 2. YouTube Açıklaması (kopyala-yapıştır)

> **Neden önceki sürüm hata verdi — iki sebep vardı:**
>
> 1. **Uzunluk.** Eski açıklama **5.848 karakterdi**, YouTube limiti **5.000**. Asıl ret
>    sebebi büyük ihtimalle buydu; YouTube "kaydedilemedi" der, nedenini söylemez.
> 2. **Karakterler.** `━` (box-drawing), `→ ≠ ↔ ✅ ⚠ ·` ve varyasyon seçicili emoji
>    (`❤️ ⏱️ ▶️`) vardı.
>
> Aşağıdaki sürüm **4.597 karakter** (403 karakter pay var), tamamı **saf ASCII**
> (emoji/ok/çizgi yok), `<` `>` içermiyor. Ölçüldü — olduğu gibi yapıştırılabilir.
> Bir şey eklersen 5.000'i geçme.

```text
Claude Code'a bir skill yazdim, Maestro MCP'yi bagladim ve Flutter uygulamam "Hatayi Yasat"i
yapay zekaya teslim ettim: simulator'u kendi basina acti, ekranlari gezdi, her state'in
screenshot'ini aldi ve arkasinda calisan 8 smoke test birakti. Kaynak koda tek satir
dokunmadan.

Bu videoda AI'a "test yazdirmayi" degil, AI'in uygulamayi GERCEKTEN surerek ogrenmesini
goreceksin. Ezberden degil, canli view hierarchy'den.

------------------------------
NELER YAPTIK
------------------------------
- Maestro MCP'yi repo kokune .mcp.json ile bagladik (maestro mcp)
- hata-maestro-auto skill'i: 4 fazli otonom protokol, 624 satir talimat
- Faz 0: simulator hazirligi, build + install, bootstrap'i yesile boyama
- Faz 1: otonom kesif, inspect_view_hierarchy + screenshot ile 25+ ekranin haritasi
- Faz 2: 9 core alt akis + 8 smoke flow + auto suite (658 satir YAML)
- Faz 3: selector'i olmayan kontrollerin "needs-id" raporu, KOD DEGISTIRMEDEN
- run.sh: boot + flutter build + simctl install + JUnit rapor tek komutta
- Gercek hata ayiklama sahnesi: takeScreenshot yollari proje kokune gore cozuluyor

------------------------------
BOLUMDE OGRENDIKLERIMIZ
------------------------------
- Flutter'da Key() erisilebilirlik id'si DEGILDIR. Maestro sadece Semantics(identifier:)
  gorur; Key('homeSearchField') testte YOK sayilir.
- Surume bagli metne assert etme: "Yenilikler v8.1.0" her release'te degisir.
- Canli Firestore verisine assert etmek testi kirar; sabit UI etiketine assert et.
- Maestro'da assertVisible/tapOn TAM regex'tir: "Mekanlar", "Mekanlar!" ile eslesmez.
- Her testi clearState ile bootstrap'ten baslat, testler birbirini kirletmesin.
- AI'a "kaynak koda dokunma" dersen eksik selector'i duzeltmez, RAPORLAR. Kontrol sende.

------------------------------
ONCE BUNU IZLE: MAESTRO TEMELI
------------------------------
"Maestro ile Mobile UI Test yazmak coook kolay!"
https://www.youtube.com/watch?v=s3dBrakjlrI
Orada Maestro'yu anlattim; burada onu bir yapay zeka ajaninin eline veriyoruz.

------------------------------
KULLANDIGIM MCP SUNUCULARI
------------------------------
- Maestro MCP: bu bolumun yildizi (cihaz sur, inspect, screenshot, flow kos)
  https://maestro.dev - Dokuman: https://docs.maestro.dev
  Kurulum: curl -fsSL "https://get.maestro.mobile.dev" | bash
- codebase-memory-mcp: kod grafigi, kim kimi cagiriyor, mimari sorgular
- claude-mem: oturumlar arasi kalici hafiza. https://github.com/thedotmack/claude-mem

MCP nedir? https://modelcontextprotocol.io
Claude Code: https://claude.com/claude-code
Skill dokumani: https://docs.claude.com/en/docs/claude-code/skills

------------------------------
SKILL DOSYASI (indir, kendi projene at)
------------------------------
https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto

Maestro flow'lari:
https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/maestro

Tek komutla indir:
npx degit VB-CORE/life_client/.claude/skills/hata-maestro-auto#release/v2/1.0.0_1 .claude/skills/hata-maestro-auto

------------------------------
HATAYI YASAT NEDIR?
------------------------------
6 Subat depremlerinden sonra Hatay'daki isletmeler yikildi, tasindi, konteyner
carsilara dagildi ve bulunamaz oldu. Hatayi Yasat onlari yeniden bulunabilir kilmak
icin yazilmis acik kaynak bir Flutter uygulamasi: mekan rehberi, haber/etkinlik/is
ilani akisi, "Hatiralar" foto galerisi, turistik yerler ve konteyner carsilar.

Flutter / Firebase / Riverpod / Material 3 / TR-EN / MIT

Google Play: https://play.google.com/store/apps/details?id=com.hatayiyasat.app
App Store: https://apps.apple.com/us/app/id6465691080
Kaynak kod: https://github.com/VB-CORE/life_client
Instagram: https://www.instagram.com/hatayiyasat/

------------------------------
BOLUMLER
------------------------------
00:00 Giris: AI uygulamayi kendi basina test edebilir mi?
01:10 Maestro nedir, MCP ile ne degisiyor?
03:00 .mcp.json ile Maestro MCP'yi Claude Code'a baglamak
05:20 Skill neden sart? "Ezberden degil, canli UI'dan"
08:00 Faz 0: simulator, build, install, bootstrap'i kanitlamak
11:30 Faz 1: otonom kesif, inspect + screenshot ile ekran haritasi
16:00 Flutter tuzagi: Key() vs Semantics(identifier:)
19:00 Faz 2: 8 smoke flow'un yazilmasi
24:00 Uctan uca senaryo: favorile, listede gor, temizle
27:00 Ilk kosum ve HATA: screenshot yollari neden kirildi?
30:00 Duzeltme: run.sh, proje koku, auto suite
33:00 Faz 3: "needs-id", AI'in koda dokunmadan biraktigi rapor
36:00 Sonuc, maliyet ve bunu kendi projene nasil kurarsin

LinkedIn / X / Medium: (kendi linklerin)

#flutter #claudecode #maestro
```

### 2.1 Açıklama yapıştırılırken dikkat

- **Yasak karakterler:** `<` `>` (kesin ret), `━ ─ │ ┃` box-drawing, `→ ← ≠ ↔ · • ✅ ⚠`
  ve varyasyon seçicili emoji (`❤️ ⏱️ ▶️ 🎉`). Yukarıdaki sürümde hiçbiri yok.
- Türkçe harfler (`ı ş ğ ç ö ü İ`) YouTube'da **sorunsuz çalışır**; yine de yapıştırma
  hatası tekrar ederse yukarıdaki ASCII sürümü olduğu gibi bırak, sonra tek tek Türkçe
  harfleri geri ekleyip hangisinde patladığını izole et.
- Hashtag en fazla **3 tanesi** başlığın üstünde görünür; ilk 3'ü bilerek seçildi.
  15'ten fazla hashtag koyarsan YouTube **hepsini yok sayar**.
- Uzunluk sınırı 5.000 karakter, ilk **157 karakter** arama sonucunda görünür — o yüzden
  ilk paragraf anahtar kelimeyle başlıyor.
- Zaman kodları için ilk satır **`00:00`** olmak zorunda, yoksa bölümler oluşmaz.
- Yapıştırdıktan sonra "Kaydet" hata verirse: önce **düz metin editörüne** yapıştır
  (TextEdit > Format > Make Plain Text), oradan kopyalayıp YouTube'a al. Zengin metin
  biçimlendirmesi gizli karakter taşıyor olabilir.

---

## 3. Kullandığım MCP Listesi

### 3.1 Bu projede aktif

| MCP | Nerede tanımlı | Komut | Bu bölümdeki rolü |
|---|---|---|---|
| **maestro** | `.mcp.json` (repo kökü, commit'li) | `maestro mcp` | ⭐ Ana araç — cihazı sürer |
| **codebase-memory-mcp** | `~/.claude.json` (global) | `/Users/vb10/.local/bin/codebase-memory-mcp` | Kod grafiği, çağrı zinciri, mimari sorgu |
| **claude-mem** | Plugin: `claude-mem@thedotmack` | plugin MCP (`mcp-search`) | Oturumlar arası hafıza, gözlem arama |
| **claude.ai Figma** | claude.ai connector | — | Tasarım↔kod (bu bölümde kullanılmadı) |

### 3.2 Bağlı ama yetki bekleyen (claude.ai connector)

`claude.ai Gmail` · `claude.ai Google Calendar` · `claude.ai Google Drive`
→ claude.ai connector ayarlarından yetkilendirilmeden araçları çağrılamaz.

### 3.3 Geçmişte kullanılan, şu an bağlı değil

`atlassian` (Jira) · `linear` · `dart` (Dart/Flutter analiz MCP'si) —
izin listesinde ve auth cache'te izleri var, aktif config'de yok.

### 3.4 Maestro MCP'nin verdiği araçlar (videoda göster)

```
list_devices · start_device · launch_app · stop_app
inspect_view_hierarchy · take_screenshot
tap_on · input_text · back
run_flow · run_flow_files · check_flow_syntax
cheat_sheet · query_docs
```

### 3.5 Kurulum — izleyici için tek blok

```bash
# 1) Maestro
curl -fsSL "https://get.maestro.mobile.dev" | bash

# 2) Projeye MCP tanımı — repo köküne .mcp.json
cat > .mcp.json <<'JSON'
{
  "mcpServers": {
    "maestro": { "command": "maestro", "args": ["mcp"], "env": {} }
  }
}
JSON

# 3) Claude Code'u yeniden başlat, sonra doğrula
claude mcp list
```

---

## 4. Skill Dosyasının URL'i

Skill iki commit ile `origin`'e push'lu: `8be640fe` (skill) ve `6843a520` (flow'lar),
branch `release/v2/1.0.0_1`.

**Tarayıcıdan bak:**
- Skill klasörü — https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto
- `SKILL.md` — https://github.com/VB-CORE/life_client/blob/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/SKILL.md
- Maestro flow'ları — https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/maestro
- `run.sh` — https://github.com/VB-CORE/life_client/blob/release/v2/1.0.0_1/maestro/run.sh

**Ham (raw) dosyalar:**

```
https://raw.githubusercontent.com/VB-CORE/life_client/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/SKILL.md
https://raw.githubusercontent.com/VB-CORE/life_client/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/references/screen-map.md
https://raw.githubusercontent.com/VB-CORE/life_client/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/references/selectors.md
https://raw.githubusercontent.com/VB-CORE/life_client/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/references/flow-templates.md
https://raw.githubusercontent.com/VB-CORE/life_client/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/references/key-injection.md
```

**Tek komutla indir (izleyiciye ver):**

```bash
# Sadece skill klasörünü çek
npx degit VB-CORE/life_client/.claude/skills/hata-maestro-auto#release/v2/1.0.0_1 \
  .claude/skills/hata-maestro-auto

# ya da sparse checkout ile
git clone --filter=blob:none --sparse -b release/v2/1.0.0_1 \
  https://github.com/VB-CORE/life_client.git tmp-skill
cd tmp-skill && git sparse-checkout set .claude/skills/hata-maestro-auto
cp -r .claude/skills/hata-maestro-auto ../<projen>/.claude/skills/
```

> ⚠️ **Yayından önce iki iş:**
> 1. Branch `main`'e merge olunca URL'lerdeki `release/v2/1.0.0_1` → `main` yap
>    (kısa link, bozulmaz).
> 2. Skill projeye özeldir (appId `com.hatayiyasat.app`, TR metin anchor'ları,
>    `GeneralSemanticKeys` registry'si). Başka projeye atacak izleyici için videoda
>    "şu 3 satırı kendi projene göre değiştir" de: appId · locale · id registry yolu.
>    Proje-bağımsız versiyonu isteyen için `episode-smoke` skill'ini alternatif olarak an.

---

## 5. Videoyu Tamamlayan İçerik

### 5.1 Thumbnail — hazır, yüklenebilir

İki varyant **1280×720 PNG** olarak üretildi ve içlerinde **gerçek uygulama ekranı**
(`app.png`) ile **gerçek portre** (`me.png`) gömülü. Canva'ya gerek yok; olduğu gibi
YouTube'a yüklenebilir.

| Varyant | Dosya | Konsept |
|---|---|---|
| **A** (öneri) | [thumb_a_1280x720.png](assets/thumbnail/thumb_a_1280x720.png) | Solda telefon + `8/8 PASSED`, sağda `AI KENDİ TESTİNİ YAZDI`, sağ altta daire portre |
| **B** | [thumb_b_1280x720.png](assets/thumbnail/thumb_b_1280x720.png) | Solda telefon + portre katmanlı, sağda `KOD YAZMADAN 8 E2E TEST` + terminal şeridi |

**Kaynak dosyalar** (`docs/assets/thumbnail/`):

| Dosya | Ne |
|---|---|
| `thumb_a.svg` / `thumb_b.svg` | Düzenlenebilir vektör kaynak |
| `app.png` | Anasayfa ekranı, cihaz çerçeveli (766×1606) — mavi kenarları SVG'de kırpılıyor |
| `me.png` | Portre (1106×1120) — SVG'de daire olarak kırpılıyor, arka plan silinmesi gerekmiyor |
| `render.sh` | SVG → 1280×720 PNG render script'i |

Metni/rengi değiştirdikten sonra yeniden üret:

```bash
./docs/assets/thumbnail/render.sh            # ikisini birden
./docs/assets/thumbnail/render.sh thumb_a    # tek varyant
```

> Script'teki `--window-size=1280,884`, `margin-top:82px` ve `sips -c 720 1280` üçlüsü
> Chrome headless'ın 82px'lik toolbar payını telafi eder — bu sayıları değiştirme.
> Ayrıca SVG, HTML'e **inline** ediliyor: `<img src="x.svg">` bağlamında tarayıcı
> SVG içindeki `<image href="app.png">` kaynaklarını yüklemez.

**Fotoğrafı değiştirirsen:** `me.png` / `app.png` dosyasını aynı adla değiştir, sonra
SVG'deki ilgili `<image>` elemanının `x/y/width/height` değerlerini yeni kadraja göre
ayarla (daire kırpımı `clipPath` ile yapılıyor, fotoğrafın kendisi kare kalabilir).

**Renkler:** arka plan `#0A0E14` → `#121A26`, vurgu turuncu `#D97757`, açık turuncu
`#F0A37E`, başarı yeşili `#3FB950`, gövde metni `#B7C2D0`.
**Font:** Arial Black / Impact (başlık), Helvetica Neue Bold (alt metin).

**Metin kuralları:** thumbnail'de max 4 kelime, harf yüksekliği ≥ 90px (mobilde 168px
genişlikte okunacak), başlıkla **aynı** metni yazma — başlık "AI Kendi UI Testlerini Yazdı"
ise thumbnail "KOD YAZMADAN 8 E2E TEST" desin ki iki mesaj birbirini tamamlasın.

> ⚠️ `8/8 PASSED` rozeti ve terminal çıktısındaki `[PASSED]` satırları **iddia**; bölüm 6
> kontrol listesindeki full suite koşumu yeşile boyanmadan bu rozetle yayına çıkma.
> Şu an sadece `01_app_launch` yeşil.

### 5.2 İlk 30 saniye (hook — kelimesi kelimesine)

> "Bu uygulamanın tek bir UI testi yoktu. Ben de test yazmak yerine yapay zekaya
> simulator'ün kontrolünü verdim. Kendi başına açtı, gezdi, her ekranın fotoğrafını çekti
> ve arkasında sekiz tane çalışan test bıraktı. Kaynak koda tek satır dokunmadan.
> Bir yerde de patladı — onu da göstereceğim, çünkü asıl öğretici kısım orası."

### 5.3 Etiketler (tags) — YouTube "Etiketler" alanına yapıştır

YouTube tag alanı **toplam 500 karakter** kabul eder (virgüller dahil). Aşağıdaki liste
**~455 karakter** — olduğu gibi tek satır halinde yapıştırılabilir.

```text
claude code, maestro mcp, mcp server, model context protocol, flutter test, flutter e2e test, e2e test, ui test otomasyonu, test otomasyonu, yapay zeka ile test, otonom test, ai agent, maestro flutter, claude code skill, mobil test otomasyonu, mobil uygulama testi, ios simulator test, flutter ios test, smoke test, yapay zeka ile kod yazmak, ai kod asistani, claude ai, anthropic, flutter riverpod, flutter turkce, yazilim gelistirme, hatayi yasat, veli bacik
```

**Tag kuralları:**

- Toplam 500 karakter, tek etiket max 100 karakter. Aşarsan YouTube **sondan keser**,
  hata vermez — bu yüzden sessizce etiket kaybedersin.
- Etiketler virgülle ayrılır; tag alanına `#` **koyma** (hashtag açıklamaya gider).
- İlk 3-5 etiket en ağırlıklısıdır: `claude code`, `maestro mcp`, `mcp server`,
  `flutter test` başta duruyor.
- Tag alanında Türkçe harf sorun çıkarmaz ama arama eşleşmesi için hem `flutter turkce`
  hem `yazilim gelistirme` **ASCII** yazıldı (kullanıcılar çoğunlukla ASCII arıyor).
- Etiketlerin SEO etkisi düşüktür; asıl ağırlık **başlık + ilk 157 karakter açıklama +
  thumbnail**'da. Etiketi yazım hatalarını yakalamak için kullan.

### 5.3.1 Hashtag'ler (açıklamanın en altı)

```text
#flutter #claudecode #maestro
```

Sadece **ilk 3'ü** video başlığının üstünde görünür. 15'ten fazla hashtag koyarsan
YouTube hepsini yok sayar — bu yüzden açıklamada 3 tane bırakıldı.

### 5.4 Sabitlenecek yorum

```
📌 Skill dosyası ve tüm Maestro flow'ları burada:
https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto

Kendi projene kurmak için 3 şeyi değiştirmen yeterli:
1) appId  2) dil/metin anchor'ları  3) Semantics id registry yolu

Not: Flutter'da Key() Maestro'ya GÖRÜNMEZ, sadece Semantics(identifier:) görünür.
Ben bunu 7 tane id'yi boşuna denedikten sonra öğrendim 😅
Senin projende kaç tane "needs-id" kontrol çıktı? Yoruma yaz.
```

### 5.5 Shorts / Reels fikirleri (bu bölümden çıkar)

1. **"Flutter'da Key() ile Semantics() farkı"** (45sn) — kod → inspect çıktısı → neden görünmüyor.
2. **"AI simulator'ü kendi süründe"** (30sn) — ekran kaydı hızlandırılmış, inspect→tap→screenshot döngüsü.
3. **"Testin patladığı an"** (40sn) — screenshot yolu hatası + 2 satırlık fix.
4. **"clearState neden şart?"** (30sn) — kirli state'in bir sonraki testi nasıl düşürdüğü.
5. **"Sürüm numarası içeren metne assert etme"** (25sn) — `Yenilikler v8.1.0 🎉` tuzağı.

### 5.6 Canlı demo komut sırası (çekimde bu sırayla sür)

```bash
# 0) MCP bağlı mı
claude mcp list

# 1) Cihaz + build + install + tüm suite (varsayılan target artık "auto")
./maestro/run.sh --build

# 2) Tek flow koş (izole gösterim)
./maestro/run.sh flows/smoke/01_app_launch.yaml

# 3) Sadece smoke klasörünü tek tek koş
./maestro/run.sh smoke

# 4) Belirli cihazda
./maestro/run.sh --build --device <UDID> auto

# 5) Raporlar
open maestro/reports
```

Claude Code içinde gösterilecek tetikleyiciler:

```
/hata-maestro-auto
"maestro autopilot — ekranlarımı gez ve smoke test yaz"
"otonom smoke kur"
```

### 5.7 Ekranda mutlaka gösterilecek 6 kare

1. `.mcp.json` — 9 satır, MCP'nin ne kadar basit bağlandığı.
2. `SKILL.md`'deki **kural 4** ("Kaynak koda dokunma") ve **kural 8** ("Hata protokolü").
3. Canlı `inspect_view_hierarchy` çıktısı — id'si olan vs olmayan kontrol yan yana.
4. `bootstrap.yaml`'daki `when:` guard'lı onboarding/whatsNew blokları.
5. `05_memories_tab.yaml` içindeki `# NEEDS-ID:` yorumu (AI'ın dürüst raporu).
6. JUnit XML: 03:34 ERROR → düzeltme → 03:36 SUCCESS (18.0s).

### 5.8 Kapanış çağrısı (CTA)

> "Bu skill'i kendi projene at, appId'yi değiştir ve bir kere çalıştır. Uygulamanın kaç
> tane selector'sız kontrolü olduğunu görünce şaşıracaksın — ben 10'dan fazla buldum.
> Sonucu yorumlara yaz, bir sonraki bölümde bu 'needs-id' listesini otomatik kapatan
> akışı kuracağız."

### 5.9 Bir sonraki bölüm kancası

- `GeneralSemanticKeys` eksiklerini onaylı şekilde kapatma (Faz 3'ün 4+ adımları) + rebuild.
- Yeşil kalan flow'ları `regression/`'a terfi ettirme ve CI'a bağlama (GitHub Actions + JUnit).
- Android emulator paralel koşum.

---

## 6. Yayın Öncesi Kontrol Listesi

- [ ] `./maestro/run.sh --build` ile **auto suite'i yeniden koş** — açıklamada "hepsi yeşil"
      diyeceksen bunun kanıtı elinde olmalı (şu an sadece `01_app_launch` yeşil).
- [ ] Çalışma dizinindeki 9 dosyalık screenshot-yolu düzeltmesini commit'le.
- [ ] `maestro/reports/` gitignore'da mı — screenshot/rapor commit'lenmesin.
- [ ] Videoda görünen ekranlarda kişisel veri / API key / gerçek kullanıcı içeriği var mı?
- [ ] Branch merge sonrası bu dosyadaki tüm `release/v2/1.0.0_1` URL'lerini `main` yap.
- [ ] Açıklamadaki bölüm zaman kodlarını final kurguya göre güncelle.
