# Esnaf Paneli — Manuel Test Senaryoları

> Geçici doküman. Emülatör üzerinde elle test için; iş bitince silinebilir.

Beklenen değerler `mobile-emulator-kit/seed_merchant.mjs` verisine göre birebir yazıldı.

## Hazırlık

```bash
kill 92998                                    # port 3000'i tutan eski emülatör (varsa)
cd mobile-emulator-kit && ./start-emulator.sh
node seed_merchant.mjs                        # ikinci terminal
cd .. && flutter run
```

Hesaplar (şifre hepsinde `123456`):

| Hesap | Rol |
|---|---|
| `merchant@hatay.test` | Onaylı esnaf — Künefeci Saim Usta'nın sahibi |
| `other@hatay.test` | Başka mekanın (Antakya Kahvaltı Evi) sahibi |
| `ayse@ / mehmet@ / zeynep@hatay.test` | Yorum bırakmış ziyaretçiler |
| `admin@hatay.test` | `adminList/config` içinde |

Emülatör UI: http://localhost:3002 · Auth 3000 · Firestore 3004 · Storage 3005

---

## A · Erişim ve yetki

| # | Adım | Beklenen |
|---|---|---|
| A1 | `merchant@hatay.test` ile gir → Profil | "Esnaf Panelim" bannerı **Onaylandı** durumunda görünür |
| A2 | Bannera bas | Esnaf Paneli açılır, alt menüde 4 sekme: Panel / Yorumlar / Vitrin / Mekan |
| A3 | Çıkış yap, `ayse@hatay.test` ile gir → Profil | Banner "başvuru yap" halinde; panele erişilemez |
| A4 | `other@hatay.test` ile gir → panele gir | **Antakya Kahvaltı Evi** açılır — Künefeci Saim Usta'nın verisi görünmemeli |
| A5 | Emülatör UI'dan `approvedApplications/store_kunefeci_saim.ownerId` değerini `uid_baska` yap, paneli yeniden aç | "Bu panele erişim yetkiniz yok" ekranı. **Sonra değeri `uid_merchant`'a geri al** |

## B · Panel özeti

| # | Adım | Beklenen |
|---|---|---|
| B1 | Panel sekmesi | Başlık "Künefeci Saim Usta", kategori "Tatlıcı", yeşil **Onaylı** rozeti, ★ 4.0 |
| B2 | Özet kartları | Görüntülenme **1248** · Puan **4.0** · Yorum **3** |
| B3 | Yönet listesi | "Yorumları yönet" satırında **2** rozeti + "2 yorum yanıtı bekliyor" |
| B4 | "İndirim kuponları" satırına bas | İndirim Kuponları sayfası açılır (Aktif 1 / Pasif 1) |

## C · Yorum yönetimi ve yanıt

| # | Adım | Beklenen |
|---|---|---|
| C1 | Yorumlar sekmesi | Varsayılan filtre "Yanıt bekleyen (2)"; Ayşe ve Mehmet listelenir |
| C2 | "Tümü (3)" | Zeynep de gelir, altında gri "Senin yanıtın" bloğu var |
| C3 | "Yanıtlandı (1)" | Sadece Zeynep |
| C4 | Ayşe'nin yorumunda **Yanıtla** → metin yaz → Yanıtla | "Yanıtın yayınlandı", kart "Yanıtlandı" olur, filtre sayıları 1/3/2'ye döner |
| C5 | Panel sekmesine dön | Rozet **1**, alt menüdeki Yorumlar rozeti de 1 |
| C6 | Zeynep'in kartında **Yanıtı kaldır** → Eminim | "Yanıtın kaldırıldı"; yorum ve 3★ puanı yerinde kalır, kart tekrar "Yanıt bekliyor" |
| C7 | Çıkış → `ayse@hatay.test` → mekana git → Yorumlar sekmesi | Kendi yorumunun altında **İşletme yanıtı** bloğu görünür (C4'te yazdığın metin) |
| C8 | Ayşe kendi yorumunu sil (⋮ → Sil) | Yorum listeden kalkar, esnafın yanıtı da onunla birlikte gider |

## D · Mekan bilgisi düzenleme

| # | Adım | Beklenen |
|---|---|---|
| D1 | Mekan sekmesi | 3 fotoğraf, ilkinde **Kapak** etiketi; ad/kategori/açıklama/telefon/adres/saatler dolu gelir |
| D2 | Mekan adını "Künefeci Saim Usta 1949" yap → Kaydet | "Mekan bilgileri güncellendi"; Panel sekmesindeki başlık da değişir |
| D3 | Kategoriyi "Kahvaltı" seç → Kaydet | Panel başlığındaki kategori değişir |
| D4 | Fotoğraf ekle (+) ve bir tanesini sil → Kaydet | Kaydedilir; mekan detayında galeri güncellenir |
| D5 | Tüm fotoğrafları sil → Kaydet | "En az bir fotoğraf gerekli." — kayıt yapılmaz |
| D6 | Açıklamayı boşalt → Kaydet | Alan altında doğrulama hatası, kayıt yapılmaz |
| D7 | **Yorumlara açık** anahtarını kapat → Kaydet → mekan detayı | Yorum listesi ve "Yorum ekle" butonu hiç görünmez. Sonra tekrar aç |

## E · Vitrin (kampanya / duyuru / etkinlik)

| # | Adım | Beklenen |
|---|---|---|
| E1 | Vitrin sekmesi | 3 kart: Künefe Festivali İndirimi · Bayramda çalışma saatleri · Künefe atölyesi (sonuncusu **Pasif**) |
| E2 | En alttaki kartı sürükleyip en üste taşı | Sıra anında değişir |
| E3 | Emülatörü Ctrl+C ile kapat → `./start-emulator.sh` → uygulamayı aç | Sıra **korunmuş** olmalı (kalıcılık) |
| E4 | **Önizleme** | Sadece yayındaki 2 kart, ziyaretçi görünümüyle. Pasif atölye kartı **görünmemeli** |
| E5 | **+** → tür "Duyuru", başlık/açıklama, görsel ekle, Yayınla | Liste başına eklenir, "Vitrin güncellendi" |
| E6 | Bitiş tarihi **dün** olan bir modül oluştur → Önizleme | Editörde görünür, önizlemede görünmez |
| E7 | Bir kartın anahtarını kapat | "Pasif" yazısına döner, önizlemeden düşer |
| E8 | Bir kartı sil → Eminim | Listeden kalkar |
| E9 | Ana akış → Künefeci Saim Usta → Hakkında | **Kampanya ve duyurular** bölümü en üstte, yayındaki kartlar aynı sırada |
| E10 | Tüm modülleri pasifleştir → mekan detayı | Bölüm tamamen kaybolur (boş başlık kalmaz) |

## F · Kuponlar

| # | Adım | Beklenen |
|---|---|---|
| F1 | Panel > İndirim kuponları | **Aktif (1)**: Künefe %20 · **Pasif (1)**: Kış kampanyası %10 |
| F2 | Aktif kupondaki ✎ ikonu | Form "Kuponu Düzenle" başlığıyla, alanlar dolu açılır |
| F3 | Oranı %30 yap → Kaydet | "Kupon güncellendi", kartta %30 |
| F4 | Limiti boşalt → Kaydet | Kullanım satırı "4 Kullanıldı" (limitsiz) olur |
| F5 | **+ Yeni** ile kupon oluştur | Aktif listeye eklenir |
| F6 | Pasif sekmesindeki kupon | **Kullandır** butonu görünmez (süresi geçmiş kupon kullandırılamaz) |

## G · QR ile kullandırma

Okutmak için ikinci cihaz şart değil: `hatayiyasat://user/uid_ayse` veya `hatayiyasat://user/uid_mehmet` metnini herhangi bir QR üreticiyle ekranda oluşturup kameraya gösterebilirsin. Gerçek akış için ikinci cihazda `ayse@hatay.test` ile girip Profil > QR sayfasını aç.

| # | Adım | Beklenen |
|---|---|---|
| G1 | Aktif kuponda **Kullandır** | Kamera açılır, altta "Kullanıcının QR kodunu kameraya gösterin" |
| G2 | **Mehmet**'in QR'ını okut | Yeşil **Kupon tanımlandı**; geri dönünce kullanım sayısı 4 → **5** |
| G3 | "Yeni QR okut" → aynı QR'ı tekrar okut | Kırmızı **Hakkı dolu** + kullanım tarihi; sayaç artmaz |
| G4 | **Ayşe**'nin QR'ını okut | Doğrudan **Hakkı dolu** (seed'de 2 gün önce kullanmış) |
| G5 | Rastgele bir QR okut (ör. bir web sitesi QR'ı) | "Bu QR bir kullanıcı kodu değil." |
| G6 | Emülatör UI'dan kuponun `usageLimit`'ini `usageCount` ile eşitle → Kullandır | "Kuponun kullanım limiti dolmuş." |
| G7 | `other@hatay.test` ile gir, kendi kuponunu oluştur, Mehmet'in QR'ını okut | Çalışır — kuponlar mekan bazında bağımsız |

## H · Güvenlik

17'si otomatik test edildi:

```bash
cd mobile-emulator-kit/rules-test && npm install && ./run.sh
```

Elle doğrulamak istersen (Emülatör UI'da `merchant@hatay.test` oturumuyla):

- `approvedApplications/store_kunefeci_saim.isApproved` → false yapma **reddedilir**
- `.ownerId` başkasına devretme **reddedilir**
- Başka mekanın (`store_antakya_kahvalti`) herhangi bir alanı **yazılamaz**
- `votes/uid_zeynep.score` değiştirme **reddedilir** (sadece `merchantReply` yazılabilir)
- `coupons/coupon_kunefe_20/redemptions/uid_ayse` ikinci kez oluşturma **reddedilir**

---

## Kapsam dışı (eksik değil, bilerek yapılmadı)

- Dashboard'da **favori sayısı ve haftalık grafik yok** — sunucuda karşılığı yok, mock veri konmadı.
- Fotoğraflarda **sürükle-bırak sıralama yok** — kapağı değiştirmek için silip yeniden ekle.
- Kampanyanın **kullanıcı tarafındaki QR gösterimi** ayrı iş.
- Dart tarafında **unit test yok** (kurallar test edildi).
