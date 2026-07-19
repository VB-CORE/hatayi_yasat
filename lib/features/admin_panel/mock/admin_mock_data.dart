import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

// TODO(admin): Gerçek Firestore admin servisi bağlanınca bu dosya silinecek.
final class AdminMockData {
  AdminMockData._();

  static const int userCount = 48;

  static const List<String> _firstNames = [
    'Mehmet',
    'Zeynep',
    'Ahmet',
    'Ayşe',
    'Hasan',
    'Elif',
    'Mustafa',
    'Fatma',
    'Emre',
    'Selin',
    'Hüseyin',
    'Merve',
  ];

  static const List<String> _lastNames = [
    'Kaya',
    'Demir',
    'Yılmaz',
    'Şahin',
    'Çelik',
    'Aydın',
    'Öztürk',
    'Arslan',
    'Doğan',
    'Kılıç',
    'Koç',
    'Polat',
  ];

  static const List<String> _merchantUids = ['user_05', 'user_23'];

  static List<AppUser> buildUsers() => List.generate(userCount, (index) {
    final number = (index + 1).toString().padLeft(2, '0');
    final uid = 'user_$number';
    final displayName =
        '${_firstNames[index % _firstNames.length]} '
        '${_lastNames[index ~/ 4 % _lastNames.length]}';
    return AppUser(
      uid: uid,
      email: 'user$number@example.com',
      displayName: displayName,
      role: _merchantUids.contains(uid) ? UserRole.merchant : UserRole.user,
      canCreateGroup: index % 9 == 0,
      canCreateIssue: index % 7 == 0,
    );
  });

  static List<MerchantApplicationModel> buildApplications() => [
    MerchantApplicationModel(
      uid: 'user_07',
      businessName: 'Künefe Diyarı',
      applicantName: 'Mustafa Demir',
      createdAt: DateTime(2026, 7, 2),
    ),
    MerchantApplicationModel(
      uid: 'user_12',
      businessName: 'Habib-i Neccar Kitabevi',
      applicantName: 'Merve Yılmaz',
      createdAt: DateTime(2026, 7, 5),
    ),
    MerchantApplicationModel(
      uid: 'user_19',
      businessName: 'Defne Sabunevi',
      applicantName: 'Mustafa Çelik',
      createdAt: DateTime(2026, 7, 8),
    ),
    MerchantApplicationModel(
      uid: 'user_26',
      businessName: 'Uzun Çarşı Baharatçısı',
      applicantName: 'Zeynep Öztürk',
      createdAt: DateTime(2026, 7, 11),
    ),
    MerchantApplicationModel(
      uid: 'user_33',
      businessName: 'Asi Kenarı Kahvecisi',
      applicantName: 'Emre Doğan',
      createdAt: DateTime(2026, 7, 14),
    ),
  ];
}
