# Bildirim Okundu/Okunmadı Durumu — Cihaz-Lokal Tasarım

**Tarih:** 2026-08-04
**Branch:** `feature/notification-redesign`
**İlgili commit:** `58f20284` (bildirimler ekranının issue #417'ye göre yeniden yazımı — bu tasarım o commit'teki mantık hatasını düzeltiyor)

## Problem

Bildirimler koleksiyonu (`notifications`) global ve tek: tüm kullanıcılar aynı Firestore dokümanlarını okuyor. Mevcut implementasyon `AppNotificationModel.read` alanını Firestore'da tutuyor ve `markAsRead`/`markAllAsRead` bu alana `true` yazıyor. `firestore.rules` da her signed-in kullanıcının `read` alanını `false→true` çevirmesine izin veriyor. Sonuç: bir kullanıcı bir bildirimi okuyunca **o bildirim tüm kullanıcılar için okunmuş sayılıyor** — kişiye özel okundu takibi yok.

`SharedCache.getLastNotificationSeenTime()` / `updateNotificationLastSeenTime()` bu sorunu çözmek için zaten yazılmış (cihaz-lokal `SharedPreferences` tabanlı) ama hiçbir yerde çağrılmıyor — ölü kod.

Ayrıca `AppNotificationModel`'de `id` ve `targetId` olmak üzere iki ayrı "hedef" alanı var; navigasyon kodu `targetId`'yi kullanıyor, `id` hiç kullanılmıyor.

## Kapsam

Sadece `hatayi_yasat` reposu. `life_shared` paketine (model tanımının yaşadığı sibling repo) **dokunulmuyor** — `read` ve `targetId` alanları modelde tanımlı kalıyor, sadece app katmanında kullanılmıyor/yazılmıyor.

## Çözüm

Okundu/okunmadı durumu tamamen cihaz-lokal hesaplanır: bildirimin `createdAt`'ı, `SharedCache.getLastNotificationSeenTime()`'ın döndürdüğü son-görülme zamanıyla kıyaslanır. Firestore'daki `read` alanına artık hiç yazılmaz/okunmaz.

### Bileşen değişiklikleri

1. **`NotificationsState`** — `locallyReadIds: Set<String>` alanı korunur, anlamı değişir: artık "Firestore yazması onaylanana kadar geçici overlay" değil, **bu oturumda karta dokunularak okundu işaretlenen id'lerin kalıcı olmayan (session-only) kümesi**.

2. **`NotificationsViewModel`**
   - `unreadStream()`: filtre `!item.read` yerine
     `item.createdAt.isAfter(SharedCache.instance.getLastNotificationSeenTime() ?? DateTime.fromMillisecondsSinceEpoch(0)) && !locallyReadIds.contains(item.documentId)`
     olur. Null last-seen (hiç açılmamış) → epoch → tüm geçmiş bildirimler ilk girişte unread.
   - `markAsRead(item)`: Firestore `updateFields(read: true)` çağrısı ve revert-on-failure mantığı kaldırılır; sadece `state.copyWith(locallyReadIds: {...locallyReadIds, item.documentId})`.
   - `markAllAsRead(unreadItems)`: `await SharedCache.instance.updateNotificationLastSeenTime()` + görünen tüm id'leri `locallyReadIds`'e ekleyerek anlık UI güncellemesi. Buton AppBar'da kalır (kaldırılmıyor).
   - **Ekrandan çıkışta otomatik "hepsi okundu":** `updateNotificationLastSeenTime()` ekran/provider dispose olduğunda çağrılır. Kesin mekanizma (view'ı `ConsumerStatefulWidget`'a çevirip `dispose()`'da çağırmak, ya da provider `autoDispose` ise `ref.onDispose` kullanmak) implementation sırasında mevcut `NotificationsViewMixin`/provider scope'una bakılarak netleştirilir.

3. **`notification_tile.dart`** — `isUnread = !item.read` yerine ViewModel/provider'dan gelen unread bilgisi kullanılır; `item.read`'e artık hiç bakılmaz.

4. **`notifications_view_model.dart` navigasyonu** — `openNotification()` içinde `item.targetId` yerine `item.id` kullanılır. `targetId` alanına dokunulmaz, sadece kullanılmaz.

5. **`firestore.rules`** — `notifications/{document}` altındaki `read: false→true` update izni artık kullanılmayan bir yazma yetkisi bırakıyor; güvenlik yüzeyini daraltmak için kaldırılır.

6. **`main_app_bar.dart`** (`_NotificationButton`) — aynı `unreadStream()`'i tükettiği için otomatik doğru davranır, ayrı değişiklik gerekmez.

### Veri akışı

Ekrana giriş → `unreadStream()` her bildirimi `createdAt` vs `lastSeenTime` ile kıyaslar → karta dokunma → `locallyReadIds`'e ekle (anlık UI, kalıcı değil) → ekrandan çık (pop/dispose) → `updateNotificationLastSeenTime()` → sonraki girişte `lastSeenTime` güncel olduğu için o ana kadarki tüm bildirimler okunmuş görünür.

## Test

Bu katman için mevcut projede birim test yok, CLAUDE.md da zorunlu kılmıyor. Doğrulama: `dart analyze` yeşil + emulator/cihazda manuel akış (ilk giriş unread sayısı, karta dokunma, ekrandan çıkıp geri girme, mark-all-read butonu, `item.id` ile navigasyonun place/event/memory'e doğru gitmesi).

## Kapsam dışı

- `life_shared` paketinde model değişikliği (read/targetId alanlarının silinmesi) — ayrı, cross-repo bir iş.
- Bu katman için otomatik birim test yazımı (istenirse ayrı iş olarak eklenebilir).
