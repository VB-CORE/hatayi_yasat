# WEB-35 — Web hata izleme

> Issue: [#516](https://github.com/VB-CORE/hatayi_yasat/issues/516) · Bağımlılık: WEB-42 ([#512](https://github.com/VB-CORE/hatayi_yasat/issues/512), Crashlytics facade'ı)

## Karar

Web'de hatalar **Firebase Analytics'e `app_error` event'i** olarak raporlanır.
Mobilde Crashlytics olduğu gibi kalır.

## Gerekçe

- `firebase_crashlytics` web'i desteklemiyor. WEB-42 facade'ı
  ([crashlytics_provider.dart](../lib/product/package/firebase/crashlytics/crashlytics_provider.dart))
  web'de `null` döner.
- Web'de Firebase Analytics zaten çalışıyor (`measurementId` tanımlı). Yeni paket, hesap veya
  anahtar gerekmiyor.
- Hatalar mevcut GA4 mülkünde, kullanıcı ve ekran verisiyle aynı yerde görünür.

## Değerlendirilen alternatif: Sentry

Tam stack trace, hata gruplama ve uyarı sağlar. Şimdilik seçilmedi çünkü `sentry_flutter`
paketi, Sentry hesabı ve DSN yönetimi gerekiyor. Analytics'teki hata hacmi ve içeriği yetersiz
kalırsa yeniden değerlendirilir.

## Nasıl çalışır

| Kaynak | Web'de yakalayan | Not |
|---|---|---|
| Framework hataları (build, layout, gesture) | `FlutterError.onError` | `reason` = hata bağlamı |
| Yakalanmamış async Dart hataları | `window` `error` event'i | Web engine `PlatformDispatcher.onError`'u hiç çağırmıyor |
| Yakalanmamış JS promise reddi | `window` `unhandledrejection` event'i | Firebase JS SDK gibi interop çağrıları |
| Yakalanmış hatalar (`FirebaseFailure` dalları) | `AnalyticsService.recordError` çağrı yerleri | Kod değişikliği gerekmedi |

- Binder: [error_handler_binder_web.dart](../lib/product/init/error_handler/error_handler_binder_web.dart)
- Event: [firebase_analytics_service.dart](../lib/core/service/analytics/firebase_analytics_service.dart) `_logErrorEvent`
- Mobil binder'ı ([error_handler_binder_io.dart](../lib/product/init/error_handler/error_handler_binder_io.dart))
  ve Crashlytics yolu değişmedi.

### `app_error` parametreleri

| Parametre | İçerik |
|---|---|
| `error_type` | Hatanın Dart tipi; `window` event'lerinde `String` |
| `error_message` | Hata mesajı |
| `is_fatal` | Yakalanmamış hatalarda `true` |
| `reason` | Bağlam: `window_error`, `unhandled_rejection` veya `FlutterError` bağlamı |
| `stack_top` | Stack'in ilk satırı ya da `dosya:satır:sütun` |

## Sınırlar

- GA4 parametre değerleri **100 karakterle** sınırlı. Değerler kırpılır, tam stack trace yok.
- Release web build'inde (dart2js) stack satırları minify edilmiş olur.
- Debug build'de Analytics kapalı. Test için `--dart-define=ANALYTICS_DEBUG=true` ile çalıştır.
- `ProjectDependency.setup()`'tan önce oluşan bir hata raporlanmaz, sadece konsola düşer.

## GA4'te görüntüleme

1. GA4 → Admin → Custom definitions: `error_type`, `error_message`, `reason`, `stack_top`
   için event-scoped custom dimension oluştur. Bu tek seferlik iş, **elle yapılmalı**.
2. Reports → Engagement → Events → `app_error`.
3. Anlık doğrulama için Admin → DebugView (`ANALYTICS_DEBUG=true` ile).
