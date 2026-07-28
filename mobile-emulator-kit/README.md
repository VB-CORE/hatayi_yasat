# Mobile Emulator Kit

Mobile app'i gerçek production'a dokunmadan, sahte ama gerçekçi verilerle
çalıştırmak için gereken her şey bu klasörde. Ayrı bir Firebase hesabına ya
da bu private repoya erişime ihtiyacınız yok.

## 1) Gereksinimler

- **Node.js** (18+): https://nodejs.org
- **Firebase CLI**: `npm install -g firebase-tools`
- **Java 17 veya 21** (Firestore emulator için gerekli): `brew install openjdk@21`

Kurulum bittiğinde terminalden kontrol edin:

```bash
node -v
firebase --version
java -version
```

## 2) Emulator'ü başlat

Bu klasörün içindeyken:

```bash
./start-emulator.sh
```

İlk çalıştırmada `seed-data/` klasöründeki örnek veri set otomatik olarak
içeri aktarılır (baseline). Emulator'ü durdurup tekrar başlattığınızda
(Ctrl+C ile durdurun), üzerine eklediğiniz/değiştirdiğiniz her şey
`emulator-data/` klasörüne kaydedilir ve bir sonraki çalıştırmada oradan
devam eder — baseline veri hiç bozulmaz.

Emulator ayaktayken:

- **Emulator UI**: http://localhost:3002 (Firestore/Auth/Storage verisini
  tarayıcıdan görüp düzenleyebilirsiniz)
- **Auth**: port 3000
- **Firestore**: port 3004
- **Storage**: port 3005

> Not: Bu kitte **Cloud Functions emulator'ü yok**. Uygulama içinde bir
> Cloud Function çağıran bir akış test ediyorsanız o çağrı başarısız olur —
> bu bilinen ve beklenen bir durum.

## 3) Ekstra test kullanıcısı / admin eklemek (opsiyonel)

Emulator ayaktayken, başka bir terminalden:

```bash
./seed_emulator.sh                     # varsayılan admin email ile
./seed_emulator.sh ornek@gmail.com     # farklı bir admin email ile
```

Bu script `adminList/config` ve birkaç örnek kullanıcıyı Firestore'a yazar.
Emulator'ü tekrar başlatınca kaybolmaz (yukarıdaki `emulator-data/` mekanizması
sayesinde).

## 3.1) Esnaf paneli test verisi

Esnaf panelini (`features/merchant_panel`) denemek için onaylı bir esnaf
hesabı, sahibi olduğu mekan, vitrin modülleri ve yorumlar gerekiyor:

```bash
node seed_merchant.mjs
```

Açılan hesaplar — şifre hepsinde `123456`:

| Hesap | Rol |
|---|---|
| `merchant@hatay.test` | Onaylı esnaf, **Künefeci Saim Usta**'nın sahibi (`ownerId`) |
| `other@hatay.test` | Başka bir mekanın sahibi — yetki guard'ının negatif testi |
| `admin@hatay.test` | `adminList/config` içinde |
| `ayse@ / mehmet@ / zeynep@hatay.test` | Yorum bırakmış ziyaretçiler |

Panele giriş: `merchant@hatay.test` ile giriş yap → **Profil > Esnaf Panelim**.

## 4) Mobile app'i emulator'e bağlamak

App tarafında (`AppConstants.useEmulator = true` + debug build) şu portlara
bağlanacak şekilde ayarlı olmalı:

| Servis    | Port |
|-----------|------|
| Auth      | 3000 |
| Firestore | 3004 |
| Storage   | 3005 |

Host adresi çalıştırdığınız platforma göre değişir:

- **iOS Simulator**: `127.0.0.1` (`localhost` **kullanmayın** — bazı Mac'lerde
  `localhost` önce IPv6 (`::1`) adresine çözülüyor, emulator process'leri ise
  sadece IPv4 üzerinde dinliyor; bu da `firebase_auth/internal-error` ve
  Firestore `unavailable` hatalarına yol açıyor. `127.0.0.1` bu belirsizliği
  ortadan kaldırır.)
- **Android Emulator**: `10.0.2.2` (Android emülatöründe `localhost`,
  emülatörün kendisini işaret eder, host makineyi değil)
- **Fiziksel telefon**: emulator'ü çalıştırdığınız Mac'in **LAN IP**'si
  (örn. `192.168.1.23`) — telefon ve Mac aynı Wi-Fi'da olmalı.
  Mac'in IP'sini görmek için: `ipconfig getifaddr en0`

`firebase.json` içinde tüm emulator'lar `0.0.0.0` üzerinden dinlediği için
fiziksel cihaz bağlantısı ek bir ayar gerektirmeden çalışır — Mac'in güvenlik
duvarı ilk bağlantıda izin isteyebilir, izin verin.

## Klasör içeriği

```
firebase.json          Emulator port/host konfigürasyonu
.firebaserc             Firebase proje referansı (sadece emulator için, gerçek erişim gerektirmez)
firebase/                Firestore & Storage security rules + index tanımı
seed-data/               Emulator ilk açılışta bunu içeri aktarır (baseline, değişmez)
start-emulator.sh        Emulator'ü başlatan script
seed_emulator.sh         Ekstra admin/kullanıcı eklemek için script
seed_merchant.mjs        Esnaf paneli test verisi (onaylı esnaf + mekan + yorum + vitrin)
rules-test/              Firestore güvenlik kuralı testleri (`npm install && ./run.sh`)
emulator-data/           (ilk çalıştırmadan sonra oluşur) sizin local session'ınız
```
