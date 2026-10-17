# Firebase Hosting güvenlik header’ları (WEB-36, #511)

Ölçüm tarihi: 2026-10-18 · yerel Flutter 3.47.2 · `flutter build web --release` (dart2js, CanvasKit) · CI’daki pin hâlâ Flutter 3.44.9.

Header’lar sunucu tarafındadır. Derlemenin 3.47.2 ile yapılması, `firebase.json` içindeki header değerlerini değiştirmez. CanvasKit bu sürümde de `www.gstatic.com/flutter-canvaskit/<engine>/` adresinden gelir.

## 1. Eklenen header’lar

Hepsi `source: "**"` bloğuna, mevcut `Cache-Control: no-cache` satırının yanına eklendi. `/icons/**` ve `/favicon.png` cache kurallarına dokunulmadı.

| Header | Değer | Ne işe yarar |
|---|---|---|
| `X-Content-Type-Options` | `nosniff` | Tarayıcının MIME türünü tahmin etmesini kapatır. |
| `Referrer-Policy` | `strict-origin-when-cross-origin` | Aynı origin’de tam URL gider; çapraz origin’de yalnızca origin gider. |
| `X-Frame-Options` | `SAMEORIGIN` | Uygulamayı başka origin’ler çerçeveleyemez. |
| `Content-Security-Policy-Report-Only` | aşağıdaki politika | İhlali engellemez, raporlar. |

Firebase aynı istekte farklı header anahtarlarını birleştirir. Aynı anahtarda son eşleşen kural kazanır. Bu yüzden `/favicon.png` hâlâ `Cache-Control: public, max-age=86400` döner ve dört güvenlik header’ını da taşır. `/`, `/index.html` ve `/flutter_bootstrap.js` için `Cache-Control` `no-cache` kalır.

### Neden `SAMEORIGIN`

Web girişi `signInWithPopup` kullanır (`lib/core/service/auth/sign_in_strategy/sign_in_strategy_web.dart`). Firebase Auth oturum penceresi aynı origin’deki `/__/auth/iframe` belgesine dayanır. `SAMEORIGIN` başka sitelerin uygulamayı çerçevelemesini kapatır ve bu iframe’in aynı origin’den açılmasına izin verir.

`frame-ancestors 'self'` politikada durur. CSP report-only olduğu için tıklama kaçırmayı bugün fiilen kapatan header `X-Frame-Options`’tır.

## 2. CSP neden zorunlu değil

Zorunlu bir `Content-Security-Policy` bu açılışta uygulamayı düşürür. Report-only ölçümünde iki direktif olmadan ihlal oluştu:

| Çıkarılınca ihlal | Adet | Kaynak |
|---|---|---|
| `script-src 'unsafe-inline'` | 9 | FlutterFire’ın enjekte ettiği `ff_trigger_firebase_*` yükleyicileri (`firebase-app`, Firestore, Functions, Analytics, App Check, Auth, Messaging, Remote Config, Storage) |
| `script-src 'wasm-unsafe-eval'` | 2 | `blockedURI: wasm-eval`. CanvasKit `chromium/canvaskit.wasm` derlemesi |

`unsafe-eval` ayrıca denendi: politika bu anahtar olmadan açılınca `eval` ihlali oluşmadı. Bu yüzden politikada yok.

`style-src 'unsafe-inline'` duruyor. `web/index.html` splash rengi için satır içi `<style>` taşıyor.

`img-src` içinde `https:` duruyor. Mekan, haber ve profil görselleri tek bir host’a bağlı değil.

Bu üçü (`unsafe-inline` script, `wasm-unsafe-eval`, `https:` img) kalkmadan politika zorunlu moda alınamaz. Hash veya nonce, FlutterFire’ın çalışma anında yazdığı script’lere uygulanamıyor.

## 3. Açılışta görülenler ve buna göre sıkılaştırma

`/onboard` açılışı, yerel derlemeye eklenen bir `securitypolicyviolation` dinleyicisiyle ölçüldü. Dinleyici repoya girmez.

İlk taslakta iki script eksikti. İkisi de report-only ihlali olarak düştü, sonra `script-src`’ye eklendi:

- `https://accounts.google.com/gsi/client`
- `https://www.googletagmanager.com/gtag/js?id=G-866ZZMXD84` (Firebase Analytics)

Aynı açılışta fiilen giden diğer adresler:

| Tür | Adres |
|---|---|
| Script | kendi origin: `web_support.js`, `flutter_bootstrap.js`, `main.dart.js` |
| Script + Wasm | `www.gstatic.com/flutter-canvaskit/<engine>/chromium/canvaskit.js` ve `.wasm` |
| Script | `www.gstatic.com/firebasejs/12.19.0/firebase-*.js` |
| Font | `fonts.gstatic.com` Roboto woff2 |
| Fetch | `firebase.googleapis.com` webConfig, `firestore.googleapis.com` Listen |
| Fetch | `www.google-analytics.com/g/collect` |

Ölçümden sonra çıkarılanlar:

- `style-src https://fonts.googleapis.com`. Roboto, CSS üzerinden değil doğrudan `fonts.gstatic.com` font dosyası olarak indi.
- `connect-src https://*.analytics.google.com`. Collect isteği `www.google-analytics.com`’a gitti; bunu `https://*.google-analytics.com` karşılıyor.
- `script-src 'unsafe-eval'`. İhlal yok.

Sıkılaştırılmış politikayla `/onboard` yeniden açıldı: `securitypolicyviolation` sayısı **0**, ekranda karşılama kartı ve “Başlayalım” duruyor. Beyaz ekran yok.

## 4. Politikada olup bu oturumda gitmeyenler

Bunlar açılışta istek üretmedi. Kod bu host’lara gidebildiği için listede kaldılar; report-only olduklarından fazla bir host uygulamayı bozmaz, eksik bir host ise o akışta konsola ihlal yazar.

| Host | Neden duruyor |
|---|---|
| `appleid.apple.com` | Web’de Apple ile `signInWithPopup` |
| `apis.google.com`, `www.google.com` | Google oturum penceresi ve App Check |
| `www.recaptcha.net`, `recaptcha.google.com` | `firebase-app-check.js` yüklendi; bu localhost oturumunda reCAPTCHA isteği çıkmadı |
| `maps.googleapis.com` | Harita ekranları. Web harita desteği WEB-24 |
| `https://*.cloudfunctions.net` | Callable arama fonksiyonları |
| `https://*.firebaseio.com`, `wss://*.firebaseio.com` | `firebase_options.dart` içindeki Realtime Database URL’si |
| `https://*.firebaseapp.com` | Auth yardımcı iframe’i |
| `worker-src blob:` | Bu CanvasKit açılışında worker oluşmadı. Motorun blob worker’ı için duruyor |

## 5. Zorunlu CSP’ye geçmek için kalan engel

1. FlutterFire satır içi `ff_trigger_firebase_*` script’lerini bırakmalı ya da nonce desteklemeli.
2. `wasm-unsafe-eval` bir host değil, CanvasKit’in derleme izni. Zorunlu politikada da kalmak zorunda.
3. `img-src https:` ancak görseller sabit bir host listesine alınırsa daralır.

O güne kadar zorunlu kontrol seti üç header’dır: `nosniff`, `strict-origin-when-cross-origin`, `SAMEORIGIN`. CSP raporları konsolda izlenir.

## 6. Nasıl ölçüldü

`firebase.json` içindeki hosting bloğu `"target": "app"` taşıyor. Emülatör bu hedefi uygulamıyor (WEB-06’daki durum). Ölçüm, aynı header ve rewrite bloğunun `target` olmadan kopyalandığı yerel bir config ile yapıldı. Bu kopya commit edilmedi.

`curl -I` sonuçları:

| Yol | `Cache-Control` | Dört güvenlik header’ı |
|---|---|---|
| `/`, `/index.html`, `/flutter_bootstrap.js` | `no-cache` | var |
| `/favicon.png` | `public, max-age=86400` | var |

## 7. Doğrulanmayanlar

- Google veya Apple popup girişi. Yetkili domain ve OAuth origin konsol ayarı WEB-30’da; localhost bu listeye girmez.
- Üretimde `/__/auth/` yanıtlarının bu header’ları miras alıp almadığı. Reserved URL’ler Hosting kuralının dışında kalabilir. `SAMEORIGIN` seçimi, kural onlara da uygulanırsa iframe’in kırılmaması içindir.
- Zorunlu CSP. Bilerek açılmadı.
- CI’daki Flutter 3.44.9 ile ayrı bir web derlemesi. Header metni derleyiciden bağımsız.
