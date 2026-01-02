# Firebase Emulator Data

Bu klasör Firebase emulator'lar için örnek data içerir.

## Kullanım

### 1. Örnek Data'yı Emulator Formatına Çevir

`data/example_scheme.json` dosyasını Firebase emulator formatına çevirmek için:

```bash
# Flutter script kullanarak
flutter pub run emulatorImport

# Veya doğrudan Node.js ile
node scripts/import_example_data.js
```

Bu komut `emulator-data/` klasörüne Firebase emulator'ın kullanabileceği formatta data oluşturur.

### 2. Emulator'ı Başlat

Data import edildikten sonra emulator'ı başlat:

```bash
# Flutter script kullanarak
flutter pub run emulator

# Veya doğrudan Firebase CLI ile
firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data
```

### 3. Tam İşlem Akışı

```bash
# 1. Örnek data'yı import et
flutter pub run emulatorImport

# 2. Emulator'ı başlat (data otomatik yüklenecek)
flutter pub run emulator

# 3. Emulator kapatıldığında değişiklikler otomatik kaydedilir
```

## Data Yapısı

`example_scheme.json` dosyası şu koleksiyonları içerir:

- `approvedAdvertise` - Onaylanmış reklamlar
- `touristicPlaces` - Turistik yerler
- `adBoard` - İlan panosu
- `regionalCities` - Bölgesel şehirler
- `regionalTowns` - Bölgesel ilçeler
- `adminList` - Admin listesi
- `approvedCampaigns` - Onaylanmış kampanyalar
- `unApprovedCampaigns` - Onay bekleyen kampanyalar
- `specialAgency` - Özel ajanslar
- `news` - Haberler
- `memories` - Anılar
- `towns` - İlçeler
- `allowedAdminClaims` - İzin verilen admin yetkileri
- `approvedApplications` - Onaylanmış başvurular
- `unApprovedApplications` - Onay bekleyen başvurular
- `notifications` - Bildirimler
- `developers` - Geliştiriciler
- `logs` - Log kayıtları
- `categories` - Kategoriler
- `scholarship` - Burslar
- `chainStores` - Zincir mağazalar
- `usefulLinks` - Faydalı linkler

## Data Formatı

Firebase emulator'lar Firestore export formatını kullanır:

```
emulator-data/
  firestore_export/
    all_namespaces/
      all_kinds/
        <collection_name>/
          <document_id>.json
```

Her JSON dosyası Firestore document formatında olmalıdır.

## Notlar

- Emulator başlatıldığında `--import=./emulator-data` ile data yüklenir
- Emulator kapatıldığında `--export-on-exit=./emulator-data` ile değişiklikler kaydedilir
- Yeni data eklemek için `example_scheme.json` dosyasını düzenleyip tekrar import edin
- Mevcut emulator data'sını silmek için `emulator-data/` klasörünü silebilirsiniz

## Sorun Giderme

### Data import edilmiyor

1. Node.js'in yüklü olduğundan emin olun: `node --version`
2. Script'in çalıştırılabilir olduğundan emin olun: `chmod +x scripts/import_example_data.js`
3. `data/example_scheme.json` dosyasının geçerli JSON olduğundan emin olun

### Emulator data'yı görmüyor

1. `emulator-data/` klasörünün var olduğundan emin olun
2. `firebase.json` dosyasında `importOnStart` ayarının doğru olduğundan emin olun
3. Emulator'ı tamamen kapatıp yeniden başlatın

