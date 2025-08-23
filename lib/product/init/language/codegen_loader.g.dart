// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _tr = {
  "project": {
    "name": "Hatay'ı Yaşat"
  },
  "validation": {
    "fullName": "Ad ve soyad boş bırakılamaz.",
    "phoneNumber": "Lütfen geçerli bir telefon numarası giriniz.",
    "address": "Adres boş bırakılamaz",
    "needs": "Lütfen ihtiyacınızı seçiniz",
    "plate": "Lütfen plaka giriniz",
    "kvkk": "Lütfen KVKK'yı kabul ediniz.",
    "surname": "Soyadınızı girmelisiniz",
    "confirmationText": "Onay metnini kabul ediniz",
    "generalText": "Boş geçilemez veya 3 karakterden az olamaz",
    "requiredField": "Bu alan boş bırakılamaz",
    "formRequired": "Lütfen formu doldurunuz",
    "photoRequired": "Lütfen fotoğraf ekleyiniz",
    "loseAllData": "Yaptığınız değişiklikler kaybolacak. Devam etmek istiyor musunuz?",
    "categoryEmpty": "Kategori seçiniz",
    "districtEmpty": "İlçe seçiniz",
    "emailFormat": "Lütfen mailinizi doğru giriniz",
    "studentEmailFormat": "Lütfen öğrenci mailinizi giriniz",
    "dateAfterNow": "Lütfen bugünden sonraki bir tarih giriniz",
    "pleaseAddImage": "Lütfen fotoğraf ekleyiniz",
    "pickATime": "Lütfen bir saat seçiniz.",
    "closeTimeMustBeAfterStartTime": "Kapanış saati açılış saatinden sonra olmalıdır."
  },
  "button": {
    "save": "Kaydet",
    "addPhoto": "Fotoğraf Ekle",
    "ok": "Tamam",
    "close": "Kapat",
    "allFilter": "Tümü",
    "clean": "Temizle",
    "selectedList": "Listele",
    "filter": "Filtrele",
    "withoutFilter": "Filtreleme yapmadan devam et",
    "iAmSure": "Evet, eminim",
    "cancel": "İptal",
    "clearAllSelection": "{} seçimi temizle",
    "showResult": "Sonucu göster",
    "sendRequest": "Talep Oluştur",
    "call": "Ara",
    "share": "Paylaş",
    "error": "Hata",
    "more": "Daha fazla",
    "understood": "Anladım"
  },
  "component": {
    "mapPicker": {
      "title": "Haritadan konum seç",
      "selectedLocationSave": "Seçtiğin konumu kaydet",
      "updateFromMap": "Haritadan konum güncelle"
    },
    "picker": {
      "camera": "Kamera",
      "gallery": "Galeri",
      "cropperTitle": "Düzenle"
    },
    "filter": {
      "districts": "İlçeler",
      "districtDescription": "Buradan ilçeleri seçip filtreleme yapabilirsiniz",
      "categories": "Kategoriler",
      "categoryDescription": "Buradan kategorileri seçip filtreleme yapabilirsiniz",
      "filterResult": "Filtreleme sonucu",
      "resultEmpty": "Seçtiğiniz filtreleme kriterlerine uygun sonuç bulunamadı."
    }
  },
  "requestCompany": {
    "title": "Yeni İşletme Talebi",
    "name": "İşletmenizin Adını Giriniz",
    "description": "İşletmenizin Açıklamasını Giriniz",
    "address": "İşletmenizin Adresini Giriniz",
    "phoneNumber": "Telefon Numaranızı Giriniz",
    "ownerName": "Adınızı ve Soyadınızı Giriniz",
    "district": "İlçe",
    "category": "Kategori",
    "chooseCategory": "Kategori Seçiniz",
    "chooseDistrict": "İlçe Seçiniz",
    "workingHours": "İşletmenizin Çalışma Saatlerini Giriniz",
    "start": "Başlangıç",
    "end": "Bitiş",
    "choosePhoto": "İşletmenizin Fotoğraflarını Giriniz"
  },
  "general": {
    "kvkk": "KVKK",
    "kvkkReadApproved": "'yı okudum, onaylıyorum.",
    "confirmationText": "Onay metnini kabul ediniz"
  },
  "settings": {
    "title": "Ayarlar",
    "languageTitle": "Dil",
    "currentLanguage": "Mevcut dil",
    "themeTitle": "{} Tema",
    "developersTitle": "Geliştiriciler",
    "seeDevelopers": "Tüm takımı gör",
    "aboutTitle": "Uygulama hakkında",
    "contactTitle": "Bize ulaşın",
    "versionNumberTitle": "Versiyon Numarası",
    "notificationTitle": "Bildirim",
    "notificationSetting": "Bildirim izni",
    "appReviewTitle": "Uygulamayı Değerlendirin",
    "themes": {
      "light": "Aydınlık",
      "dark": "Karanlık"
    }
  },
  "home": {
    "specialAgency": "Özel Kurumlar",
    "categories": "Kategoriler",
    "places": "Mekanlar",
    "search": "Ara",
    "notifications": "Bildirimler"
  },
  "message": {
    "emptySearch": "Sonuç Bulunamadı",
    "somethingWentWrong": "Bir şeyler yanlış gitti",
    "addedFavorite": "Favorilere eklendi",
    "emptyFavorite": "Favori listeniz boş"
  },
  "search": {
    "latestSearch": "Son Aramalar",
    "place": "Mekan ara",
    "minumumSearch": "'Arama yapabilmek için en az {} karakter girip klavyenizden Ara kısmına basınız."
  },
  "placeDetailView": {
    "owner": "İşletme Sahibi",
    "description": "İşletme Açıklaması",
    "address": "Adres Bilgisi",
    "phoneNumber": "Telefon Numarası",
    "district": "İlçe",
    "photos": "Fotoğraflar",
    "call": "Ara",
    "find_the_place": "Yol Tarifi Al",
    "workingHours": "Çalışma Saatleri",
    "openCloseHours": "Açılış ve Kapanış Saatleri",
    "nowOpen": "Şu an açık",
    "nowClose": "Şu an kapalı"
  },
  "campaignDetailsView": {
    "publisher": "Yayımcı (Kişi veya Kurum Adı)",
    "topic": "Proje Konusu",
    "phone": "Telefon Numarası",
    "description": "Proje Açıklaması",
    "expireDate": "Başlangıç Tarihi ve Saati",
    "photo": "Fotoğraflar",
    "publishedBy": "{} tarafından yayınlandı",
    "startDate": "Başlangıç Tarihi: {}",
    "time": "Saat: {}",
    "optionsDialogTitle": "Seçenekler",
    "optionsDialogContent": "Lütfen seçeneklerden yapmak istediğinizi seçiniz.",
    "seeOptionsButton": "Seçenekleri Görüntüle",
    "addReminderButton": "Takvime Hatırlatıcı Ekle",
    "redirectWhatsappButton": "Whatsapp'tan Mesaj Gönder"
  },
  "forceUpdate": {
    "title": "Bir Güncelleme Var",
    "message": "Yeni bir sürüm mevcut, güncellemeniz gerekiyor.",
    "updateButton": "Güncelle"
  },
  "networkCheck": {
    "message": "İnternet bağlantınızı kontrol edip yeniden deneyiniz.",
    "button": "Yeniden Dene"
  },
  "notification": {
    "snackbarButtonText": "Aç",
    "defaultMessage": "Bir işletme yeniden faaliyetlerine başladı.",
    "businessNotFoundErrorMessage": "İşletme bulunamadı",
    "campaignNotFoundErrorMessage": "Etkinlik bulunamadı",
    "newsNotFoundErrorMessage": "Haber bulunamadı",
    "placeNotFoundErrorMessage": "Mekan bulunamadı",
    "advertiseNotFoundErrorMessage": "İlan bulunamadı"
  },
  "developers": {
    "title": "Geliştiriciler",
    "seeProfileButtonText": "Profili Görüntüle"
  },
  "navigationTabs": {
    "home": "Anasayfa",
    "activities": "Etkinlikler",
    "news": "Haberler",
    "favorite": "Favoriler",
    "request": "Talep",
    "advertise": "İş İlanı",
    "community": "Topluluk"
  },
  "projectRequest": {
    "title": "Yeni Proje Talebi",
    "publisher": "Yayımcı (Kişi veya Kurum Adı) Giriniz",
    "phoneNumber": "Telefon Numaranızı Giriniz",
    "projectImage": "Proje Hakkında Fotoğraf Ekleyiniz",
    "name": "Proje Adını Giriniz",
    "topic": "Proje Konusunu Giriniz",
    "description": "Proje Açıklamasını Giriniz",
    "dateInputTitle": "Proje Tarihini Giriniz",
    "expireDate": "Başlangıç Tarihi ve Saati"
  },
  "dialog": {
    "phoneTitle": "Telefon ile arama yapmak ister misiniz?",
    "addressTitle": "Adresi haritada açmak ister misiniz?",
    "completeRequest": "Başvurunuz alındı. Sistem tarafından onaylandıktan sonra listede görüntüleyebileceksiniz.",
    "completeScholarshipRequest": "Talebiniz alındı. Başvurunuz değerlendirildikten sonra sizinle iletişime geçilecektir.",
    "permissionCameraLibrary": "Fotoğraflar veya Kamera için izine ihtiyacımız var. Lütfen ayarlara gidin ve izin verin",
    "permissionNotification": "Bildirim için izine ihtiyacımız var. Lütfen ayarlara gidin ve izin verin"
  },
  "specialAgency": {
    "title": "Özel Kurumlar",
    "agencyNumber": "Kurum Numarası",
    "agencyAddress": "Kurum Adresi"
  },
  "advertise": {
    "title": "İş adı:",
    "description": "İş açıklaması:",
    "gender": "Cinsiyet:",
    "owner": "İşveren:",
    "phone": "İletişim:",
    "callPhone": "İşvereni ara",
    "share": "İlanı paylaş",
    "role": "Pozisyon: ",
    "message": "Hatay'ı Yaşat uygulamasındaki iş ilanına göz at:",
    "openEventDetailPhone": "Merhaba {} etkinliğiniz hakkında bilgi almak istiyorum.' ",
    "jobDescription": "İş Açıklaması",
    "options": "Özellikler"
  },
  "notFound": {
    "forRefresh": "Yenilemek için buraya dokunun.",
    "notification": "Bildirim yok",
    "specialAgency": "Özel Kurumlar henüz girilmemiş.",
    "campaign": "Etkinlik bulunamadı",
    "developers": "Geliştiriciler henüz girilmemiş.",
    "towns": "Mekanlar henüz girilmemiş.",
    "news": "Haberler henüz girilmemiş.",
    "favoritePlaces": "Herhangi bir favori mekan bulunmamaktadır.",
    "advertise": "İş ilanı henüz girilmemiş.",
    "image": "Resim yüklenemedi.",
    "chainStore": "Zincir mağaza henüz girilmemiş.",
    "usefulLinks": "Faydalı linkler henüz girilmemiş.",
    "memories": "Henüz hatıra bulunamadı."
  },
  "months": {
    "jan": "Ocak",
    "feb": "Şubat",
    "mar": "Mart",
    "apr": "Nisan",
    "may": "Mayıs",
    "jun": "Haziran",
    "jul": "Temmuz",
    "aug": "Ağustos",
    "sep": "Eylül",
    "oct": "Ekim",
    "nov": "Kasım",
    "dec": "Aralık"
  },
  "genders": {
    "male": "Erkek",
    "female": "Kadın",
    "other": "Diğer"
  },
  "requestScholarship": {
    "title": "Yeni Burs Talebi",
    "phone": "Telefon Numaranızı Giriniz",
    "email": "E-posta Adresinizi Giriniz",
    "story": "Kendinizden Bahsediniz",
    "studentDocument": "Öğrenci Belgenizi Yükleyiniz",
    "pdfHint": "ad_soyad.pdf",
    "disableButtonTitle": "Yeni burs başvurusu yapmak için 1 gün beklemelisiniz",
    "error": {
      "serviceError": "Bir servis hatası oluştu",
      "undefinedError": "Belirlenemeyen bir hata oluştu",
      "fileSizeInfo": "Dosya boyutu en fazla {} olabilir",
      "fileSizeError": "Girilen dosya boyutunu kontrol edin",
      "noFileError": "Lütfen öğrenci belgenizi yükleyiniz"
    }
  },
  "fileUpload": {
    "upload": "Yükle",
    "update": "Güncelle"
  },
  "favorite": {
    "title": "Favoriler",
    "search": "Favorinizi arayın",
    "clearAllButton": "Tümünü Temizle",
    "noBusinessFound": "Aradığınız değere uygun bir işletme bulunamadı.",
    "clearAllDialog": {
      "content": "Tüm favorilerinizi silmek istediğinize emin misiniz?"
    },
    "deleteDialog": {
      "content": "Favoriden kaldırılacaktır. Devam etmek istediğinize emin misiniz?"
    }
  },
  "uploadShelter": {
    "title": "Barınak Ayrıntılarını Yükle"
  },
  "sorting": {
    "time": {
      "newest": "Yeniden eskiye",
      "oldest": "Eskiden yeniye"
    }
  },
  "utils": {
    "options": "{} seçenek"
  },
  "advertisementBoard": {
    "openUrl": "Linki Aç",
    "launchUrlError": "Link açılırken bir hata meydana geldi",
    "shareAdvertisementSubject": "Bu reklam vereni ziyaret et: {}"
  },
  "chain_stores": {
    "title": "Konteyner Çarşılar",
    "showAllSubBranches": "Tüm şubeleri göster {}",
    "subBranchesTitle": "{} Şubeleri ({})"
  },
  "whatsNew": {
    "title": "Yenilikler v8.0.0 🎉",
    "features": {
      "linkPage": "🤝 Mersin de artık bizimle birlikte.",
      "locationPinning": "📍 Yeni İşletmelere taleplerinde Mersin de konum pinleme özelliği eklendi."
    },
    "bugFixes": "🐞 Hata düzeltmeleri yapıldı."
  },
  "tourismView": {
    "onTapMarkerWindow": "Yol tarifi almak için tıklayın",
    "title": "Turistik Yerler"
  },
  "usefulLink": {
    "title": "Faydalı Linkler"
  },
  "sheet": {
    "changeCity": {
      "title": "Şehiri Değiştir",
      "description": "Seçiminiz sonrasında yeni mekanlar görüntülenecektir.",
      "showResult": "{} için sonuçları görüntüle"
    }
  },
  "main": {
    "home": "Ana Sayfa",
    "news": "Haberler",
    "campaign": "Etkinlikler",
    "advertisement": "İş İlanları",
    "settings": "Ayarlar",
    "memories": "Hatıralar"
  },
  "historyPage": {
    "welcomeTitle": "Hatıralar Sayfasına Hoş Geldiniz!",
    "welcomeDescription": "Bu sayfada güzel anılarınızı paylaşabilir ve diğer kullanıcıların hatıralarını görüntüleyebilirsiniz. Instagram benzeri bir deneyim sunar.",
    "addPhotoInfo": "Sağ alttaki + butonuna tıklayarak yeni hatıra ekleyebilirsiniz."
  }
};
static const Map<String,dynamic> _en = {
  "project": {
    "name": "Keep Hatay Alive"
  },
  "validation": {
    "fullName": "Name and surname cannot be empty.",
    "phoneNumber": "Please enter a valid phone number.",
    "address": "Address cannot be empty.",
    "needs": "Please select your needs.",
    "plate": "Please enter a license plate number.",
    "kvkk": "Please accept KVKK.",
    "surname": "Please enter your last name.",
    "confirmationText": "Please accept the confirmation text.",
    "generalText": "Cannot be empty or less than 3 characters.",
    "requiredField": "This field cannot be empty.",
    "formRequired": "Please fill out the form.",
    "photoRequired": "Please add a photo.",
    "loseAllData": "Your changes will be lost. Do you want to continue?",
    "categoryEmpty": "Please choose a category",
    "districtEmpty": "Please choose a district",
    "emailFormat": "Please enter your mail correctly",
    "studentEmailFormat": "Please enter your student mail",
    "dateAfterNow": "Please enter a date after today",
    "pleaseAddImage": "Please add an image",
    "pickATime": "Please pick a time.",
    "closeTimeMustBeAfterStartTime": "Close time must be after start time."
  },
  "button": {
    "save": "Save",
    "addPhoto": "Add Photo",
    "ok": "OK",
    "close": "Close",
    "allFilter": "All",
    "clean": "Clean",
    "selectedList": "List",
    "filter": "Filters",
    "withoutFilter": "Continue without filtering",
    "iAmSure": "Yes, I am sure",
    "cancel": "Cancel",
    "clearAllSelection": "{} clear selections",
    "showResult": "Show result",
    "sendRequest": "Create request",
    "call": "Call",
    "share": "Share",
    "error": "Error",
    "more": "More",
    "understood": "Understood"
  },
  "component": {
    "mapPicker": {
      "title": "Select your location",
      "selectedLocationSave": "Save for your selection",
      "updateFromMap": "Update your location"
    },
    "picker": {
      "camera": "Camera",
      "gallery": "Gallery",
      "cropperTitle": "Edit"
    },
    "filter": {
      "districts": "Districts",
      "districtDescription": "You can select and filter the districts here",
      "categories": "categories",
      "categoryDescription": "You can select and filter categories here",
      "filterResult": "Filter Result",
      "resultEmpty": "No results found with the filtering criteria you chose."
    }
  },
  "requestCompany": {
    "title": "New Business Request",
    "name": "Enter the name of your business",
    "description": "Enter the description of your business",
    "address": "Enter the address of your business",
    "phoneNumber": "Enter your phone number",
    "ownerName": "Enter your name and surname",
    "district": "District",
    "category": "Category",
    "chooseCategory": "Choose Category",
    "chooseDistrict": "Choose District",
    "workingHours": "Enter the working hours of your business",
    "start": "Start",
    "end": "End",
    "choosePhoto": "Enter photos of your business"
  },
  "general": {
    "kvkk": "KVKK",
    "kvkkReadApproved": " I have read and approved.",
    "confirmationText": "Please accept the confirmation text."
  },
  "settings": {
    "title": "Settings",
    "languageTitle": "Language",
    "currentLanguage": "Current language",
    "themeTitle": "{} Theme",
    "developersTitle": "Developers",
    "seeDevelopers": "See full team",
    "aboutTitle": "About the app",
    "contactTitle": "Contact us",
    "versionNumberTitle": "Version Number",
    "notificationTitle": "Notification permission",
    "notificationSetting": "Notification Settings",
    "appReviewTitle": "Rate the App",
    "themes": {
      "light": "Light",
      "dark": "Dark"
    }
  },
  "home": {
    "specialAgency": "Special Places",
    "categories": "Categories",
    "places": "Places",
    "search": "Search",
    "notifications": "Notifications"
  },
  "message": {
    "emptySearch": "No Results Found",
    "somethingWentWrong": "Something went wrong",
    "addedFavorite": "Added to favorites",
    "emptyFavorite": "Your favorites list is empty"
  },
  "search": {
    "latestSearch": "Latest Searches",
    "place": "Search for a place",
    "minumumSearch": "Please enter at least 3 characters to search then press search button from the keyboard"
  },
  "placeDetailView": {
    "owner": "Business Owner",
    "description": "Business Description",
    "address": "Address Description",
    "phoneNumber": "Phone Number",
    "district": "District",
    "photos": "Photos",
    "call": "Call",
    "find_the_place": "Find the place",
    "workingHours": "Working Hours",
    "openCloseHours": "Opening and Closing Hours",
    "nowOpen": "Now Open",
    "nowClose": "Now Close"
  },
  "campaignDetailsView": {
    "publisher": "Publisher (Person or Institution Name)",
    "topic": "Project Topic",
    "description": "Project Description",
    "phone": "Phone Number",
    "expireDate": "Start Date and Time",
    "photo": "Photos",
    "publishedBy": "published by {}",
    "startDate": "Start Date: {}",
    "time": "Time: {}",
    "optionsDialogTitle": "Options",
    "optionsDialogContent": "Please select what you want to do from the options.",
    "seeOptionsButton": "See Options",
    "addReminderButton": "Add Reminder to Calendar",
    "redirectWhatsappButton": "Send Message on Whatsapp"
  },
  "forceUpdate": {
    "title": "An Update is Available",
    "message": "A new version is available, you need to update.",
    "updateButton": "Update"
  },
  "networkCheck": {
    "message": "Please check your internet connection and try again.",
    "button": "Try Again"
  },
  "notification": {
    "snackbarButtonText": "Open",
    "defaultMessage": "A business has resumed operations.",
    "businessNotFoundErrorMessage": "Business not found",
    "campaignNotFoundErrorMessage": "Event not found",
    "newsNotFoundErrorMessage": "No news found",
    "placeNotFoundErrorMessage": "Place not found",
    "advertiseNotFoundErrorMessage": "Advertise not found"
  },
  "developers": {
    "title": "Developers",
    "seeProfileButtonText": "See Profile"
  },
  "navigationTabs": {
    "home": "Home",
    "activities": "Activities",
    "news": "News",
    "favorite": "Favorites",
    "request": "Request",
    "advertise": "Advertise",
    "community": "Community"
  },
  "projectRequest": {
    "title": "New Project Request",
    "publisher": "Enter Publisher (Person or Institution Name)",
    "phoneNumber": "Enter Your Phone Number",
    "projectImage": "Add a Photo About the Project",
    "name": "Enter the Project Name",
    "topic": "Enter the Project Subject",
    "description": "Enter Project Description",
    "dateInputTitle": "Enter Project Date",
    "expireDate": "Start Date and Time"
  },
  "dialog": {
    "phoneTitle": "Would you like to call by phone?",
    "addressTitle": "Would you like to open the address on the map?",
    "completeRequest": "Your application has been received. Once approved by the system, you will be able to view it in the list.",
    "completeScholarshipRequest": "Your request has been received. After your application is evaluated, you will get contacted.",
    "permissionCameraLibrary": "We need permission for photos and camera.Please go to the settings and let me",
    "permissionNotification": "We need a trail for notification.Please go to the settings and let me"
  },
  "specialAgency": {
    "title": "Special Agency",
    "agencyNumber": "Agency Number",
    "agencyAddress": "Agency Address"
  },
  "advertise": {
    "title": "Job name:",
    "description": "Job description:",
    "gender": "Gender:",
    "owner": "Employer:",
    "phone": "Contact:",
    "role": "Role:",
    "callPhone": "Call the employer",
    "share": "Share the job advertise",
    "message": "Check out the job posting on the Keep Hatay Alive application:",
    "openEventDetailPhone": "Hello, I want to get information about the event named {}",
    "jobDescription": "Job Description",
    "options": "Options"
  },
  "notFound": {
    "forRefresh": "Click here to refresh.",
    "notification": "No notifications",
    "specialAgency": "Special Agencies has not been entered yet.",
    "campaign": "Events has not been entered yet.",
    "developers": "Developers has not been entered yet.",
    "towns": "Towns has not been entered yet.",
    "news": "News has not been entered yet.",
    "favoritePlaces": "There is no any favorite places.",
    "advertise": "Job postings has not been entered yet.",
    "image": "Image could not be loaded.",
    "chainStore": "Chain stores has not been entered yet.",
    "usefulLinks": "Useful links has not been entered yet.",
    "memories": "No memories found yet."
  },
  "months": {
    "jan": "January",
    "feb": "February",
    "mar": "March",
    "apr": "April",
    "may": "May",
    "jun": "June",
    "jul": "July",
    "aug": "August",
    "sep": "September",
    "oct": "October",
    "nov": "November",
    "dec": "December"
  },
  "genders": {
    "male": "Male",
    "female": "Female",
    "other": "Other"
  },
  "requestScholarship": {
    "title": "New Scholarship Request",
    "phone": "Enter Your Phone Number",
    "email": "Enter Your Email Address",
    "story": "Tell Us About Yourself",
    "studentDocument": "Upload Your Student Certificate",
    "pdfHint": "name_surname.pdf",
    "disableButtonTitle": "You should wait 1 day to apply for a new scholarship",
    "error": {
      "serviceError": "A service error has occurred",
      "undefinedError": "An unidentified error occurred",
      "fileSizeInfo": "File size can be up to {}",
      "fileSizeError": "Check the entered file size",
      "noFileError": "Please upload your student document"
    }
  },
  "fileUpload": {
    "upload": "Upload",
    "update": "Update"
  },
  "favorite": {
    "title": "Favorites",
    "search": "Search for your favorite",
    "clearAllButton": "Clear All",
    "noBusinessFound": "No business found related to your search.",
    "clearAllDialog": {
      "content": "Are you sure you want to clear all your favorites?"
    },
    "deleteDialog": {
      "content": "It will be removed from the favorite. Are you sure you want to proceed?"
    }
  },
  "uploadShelter": {
    "title": "Upload Shelter Details"
  },
  "sorting": {
    "time": {
      "newest": "Newest to oldest",
      "oldest": "Oldest to newest"
    }
  },
  "utils": {
    "options": "{} option"
  },
  "advertisementBoard": {
    "openUrl": "Open Url",
    "launchUrlError": "An error occurred when launch url",
    "shareAdvertisementSubject": "Visit advertisement owner: {}"
  },
  "chain_stores": {
    "title": "Container Bazaars",
    "showAllSubBranches": "Show all sub-store {}",
    "subBranchesTitle": "{} Store ({})"
  },
  "whatsNew": {
    "title": "New in v8.0.0 🎉",
    "features": {
      "linkPage": "🤝 Mersin with us.",
      "locationPinning": "📍 Location pinning feature added for new businesses in Mersin."
    },
    "bugFixes": "🐞 Bug fixes."
  },
  "tourismView": {
    "onTapMarkerWindow": "Tap to get directions",
    "title": "Tourism Places"
  },
  "usefulLink": {
    "title": "Useful Links"
  },
  "sheet": {
    "changeCity": {
      "title": "Change City",
      "description": "After your selection, new places will be displayed.",
      "showResult": "Show results for {}"
    }
  },
  "main": {
    "home": "Home",
    "news": "News",
    "campaign": "Events",
    "advertisement": "Job Postings",
    "settings": "Settings",
    "memories": "Memories"
  },
  "historyPage": {
    "welcomeTitle": "Welcome to Memories Page!",
    "welcomeDescription": "On this page, you can share your beautiful memories and view other users' memories. It offers an Instagram-like experience.",
    "addPhotoInfo": "Click the + button in the bottom right to add new memories."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": _tr, "en": _en};
}
