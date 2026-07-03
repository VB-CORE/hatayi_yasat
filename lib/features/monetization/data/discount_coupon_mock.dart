import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';

final class DiscountCouponMock {
  const DiscountCouponMock._();

  static final DateTime _now = DateTime.now();

  static final List<DiscountCouponModel> _items = [
    DiscountCouponModel(
      documentId: 'coupon_1',
      code: 'HATAY20',
      name: 'Yaz indirimi',
      discountRate: 20,
      storeId: 'store_1',
      storeName: 'Defne Kahve',
      createdBy: 'user_1',
      isActive: true,
      expiresAt: _now.add(const Duration(days: 30)),
      createdAt: _now,
      updatedAt: _now,
    ),
    DiscountCouponModel(
      documentId: 'coupon_2',
      code: 'KAHVE15',
      name: 'Kahve molası',
      discountRate: 15,
      storeId: 'store_2',
      storeName: 'Antakya Coffee',
      createdBy: 'user_2',
      isActive: true,
      expiresAt: _now.add(const Duration(days: 45)),
      createdAt: _now,
      updatedAt: _now,
    ),
    DiscountCouponModel(
      documentId: 'coupon_3',
      code: 'TATLI10',
      name: 'Tatlı indirimi',
      discountRate: 10,
      storeId: 'store_3',
      storeName: 'Mozaik Tatlı',
      createdBy: 'user_3',
      isActive: false,
      expiresAt: _now.add(const Duration(days: 60)),
      createdAt: _now,
      updatedAt: _now,
    ),
  ];

  static List<DiscountCouponModel> get mockDiscountCoupons =>
      List.unmodifiable(_items);

  static DiscountCouponModel add(DiscountCouponModel coupon) {
    final now = DateTime.now();

    final item = coupon.copyWith(
      documentId: coupon.documentId.isEmpty
          ? 'coupon_${now.microsecondsSinceEpoch}'
          : coupon.documentId,
      createdAt: coupon.createdAt ?? now,
      updatedAt: now,
    );

    _items.add(item);
    return item;
  }

  static DiscountCouponModel? update(DiscountCouponModel coupon) {
    final index = _items.indexWhere(
      (item) => item.documentId == coupon.documentId,
    );
    if (index == -1) return null;

    final item = coupon.copyWith(updatedAt: DateTime.now());
    _items[index] = item;
    return item;
  }

  static bool delete(String documentId) {
    final index = _items.indexWhere((item) => item.documentId == documentId);
    if (index == -1) return false;
    _items.removeAt(index);
    return true;
  }
}
