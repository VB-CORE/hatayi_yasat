# Flow starter'ları — life_client

Hepsi **başlangıç taslağıdır**. Hiçbir `<…>` yer tutucusunu olduğu gibi bırakma; her selector'ı
çalışan uygulamada `inspect_view_hierarchy` ile doğrulayıp yaz. Bu projede **login yoktur** —
credential/`.env` akışı geçersizdir.

---

## MCP araçları (Maestro 2.4.0 — 14 araç)

`list_devices` · `start_device` · `launch_app` · `take_screenshot` · `tap_on` · `input_text` ·
`back` · `stop_app` · `run_flow` · `run_flow_files` · `check_flow_syntax` ·
`inspect_view_hierarchy` · `cheat_sheet` · `query_docs`

> **`check_flow_syntax` dışında hepsi `device_id` ister.** Koşunun başında `list_devices`
> ile id'yi al, sonraki tüm çağrılarda aynı id'yi geçir.
> `run_flow` → satır içi YAML (`flow_yaml`), tekil ad-hoc adımlar için.
> `run_flow_files` → diskteki dosya (`flow_files`), suite koşumu için.

---

## `maestro/config.yaml`

```yaml
appId: com.hatayiyasat.app
flows:
  - flows/smoke/*
  - flows/regression/*
```

> Mevcut `config.yaml` ayrıca `testData`, `timeouts`, `screenSizes`, `selectors` blokları
> içeriyor. **Maestro bunları okumaz** — inert'tirler ve `${timeouts.network}` gibi
> referanslar çözülmez, flow'u patlatır. Yeni flow'larda kullanma.

---

## `flows/core/bootstrap.yaml` — bilinen ana ekrana ulaş

```yaml
# Uygulamayı açar, ilk açılış onboarding'ini ve sürüm sheet'ini geçer, Anasayfa'ya iner.
# clearState VARSAYILAN OLARAK KAPALI; izolasyon gereken flow'da çağıran tarafta aç.
appId: com.hatayiyasat.app
---
- launchApp

# İlk kurulumda onboarding görünür (kapatma butonunun id'si var).
- runFlow:
    when:
      visible:
        id: "onboardButton"
    commands:
      - tapOn:
          id: "onboardButton"

# Splash lottie'si + Firebase init + remote config bitene kadar bekle.
- extendedWaitUntil:
    visible:
      id: "mainTabView"
    timeout: 30000

# Sürüm değiştiyse "Yenilikler" sheet'i post-frame açılır.
- runFlow:
    when:
      visible:
        id: "whatsNewSheet"
    commands:
      - runFlow: dismiss_whats_new.yaml

# Anasayfa gerçekten yüklendi mi (Firestore sorgusu döndü mü).
- extendedWaitUntil:
    visible: "Mekanlar"
    timeout: 30000
```

## `flows/core/dismiss_whats_new.yaml`

Sheet'in kapatma butonu yoktur (`whats_new_sheet.dart` sadece başlık + liste render eder) —
aşağı sürükleyerek ya da scrim'e dokunarak kapanır. **Canlı doğrula**, kırılgan adımdır.

```yaml
appId: com.hatayiyasat.app
---
- swipe:
    from:
      id: "whatsNewSheet"
    direction: DOWN
- runFlow:
    when:
      visible:
        id: "whatsNewSheet"
    commands:
      - tapOn:
          point: "50%,5%"     # scrim — son çare
- assertNotVisible:
    id: "whatsNewSheet"
```

## `flows/core/goto-<ekran>.yaml` — ekran başına tek, önbelleklenmiş navigasyon

```yaml
appId: com.hatayiyasat.app
---
- tapOn:
    id: "<TAB_ID veya kararlı selector>"
- extendedWaitUntil:
    visible: "<EKRAN_ANCHOR>"
    timeout: 30000
```

Sekmeler için hazır eşleşmeler (`references/selectors.md`):

| goto | tap | anchor |
|---|---|---|
| `goto-home.yaml` | `id: homeTab` | `Mekanlar` |
| `goto-community.yaml` | `id: communityTab` | `Haberler` |
| `goto-memories.yaml` | `id: memoriesTab` | `Hatıralarımız Bizimle Yaşıyor` |
| `goto-favorite.yaml` | `id: favoriteTab` | `Favorinizi arayın` |

---

## Smoke flow iskeleti

```yaml
# flows/smoke/<ad>.yaml
appId: com.hatayiyasat.app
tags:
  - smoke
---
- runFlow: ../core/bootstrap.yaml

# … ekrana özel adımlar; her adımdan sonra canlı inspect ile doğrulanmış selector'lar …

- takeScreenshot: "../reports/smoke/<ad>"
```

Örnek — sekme turu (kritik yolun çekirdeği):

```yaml
appId: com.hatayiyasat.app
tags: [smoke]
---
- runFlow: ../core/bootstrap.yaml
- tapOn: { id: "communityTab" }
- extendedWaitUntil: { visible: "Haberler", timeout: 20000 }
- tapOn: { id: "memoriesTab" }
- extendedWaitUntil: { visible: "Hatıralarımız Bizimle Yaşıyor", timeout: 20000 }
- tapOn: { id: "favoriteTab" }
- extendedWaitUntil: { visible: "Favorinizi arayın", timeout: 20000 }
- tapOn: { id: "homeTab" }
- extendedWaitUntil: { visible: "Mekanlar", timeout: 20000 }
```

---

## Veriye bağlı assert kalıbı

Firestore canlıdır: liste boş dönebilir, isimler değişir. **İsme assert etme.** Bunun yerine
ya sabit UI etiketine ya da "boş durum görünmüyor" kalıbına bak:

```yaml
# "liste doldu" — boş-durum metninin YOKLUĞUYLA kanıtla
- extendedWaitUntil:
    visible: "Mekanlar"
    timeout: 30000
- assertNotVisible: "Sonuç Bulunamadı"
```

Bir karta girmen gerekiyorsa, adı ezberlemek yerine listedeki **ilk** kartı hedefle
(`index: 0`) ve detayda **sabit** etiketlere assert et:

```yaml
- tapOn:
    index: 0
    text: ".*"          # canlı inspect ile daralt
- extendedWaitUntil:
    visible: "İşletme Açıklaması"
    timeout: 20000
- assertVisible:
    id: "placeDetailCallButton"
- back
```

---

## Formlar

FAB speed dial formları (`Yeni İşletme Talebi` / `Yeni Proje Talebi` / `Yeni Burs Talebi`)
canlı Firestore'a yazar. Smoke'ta **formu aç, alanların render olduğunu doğrula, geri dön** —
**gönderme**. Gönderim testi ancak ayrı bir test ortamı bağlandığında yazılır.
