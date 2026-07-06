import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';

final class DiscountCouponMock {
  const DiscountCouponMock._();

  static final DateTime _now = DateTime.now();

  static final List<DiscountCouponModel> mockDiscountCoupons = [
    DiscountCouponModel(
      documentId: 'coupon_1',
      storeId: 'store_1',
      desc: 'Yaz indirimi',
      discountRate: 20,
      storeName: 'Defne Kahve',
      createdBy: 'user_1',
      expiresAt: _now.add(const Duration(days: 30)),
      usageCount: 25,
      usageLimit: 10000,
      createdAt: _now,
      updatedAt: _now,
    ),
    DiscountCouponModel(
      documentId: 'coupon_1',
      storeId: 'store_1',
      desc: 'İndirim kuponu',
      discountRate: 20,
      storeName: 'Defne Kahve',
      createdBy: 'user_1',
      expiresAt: _now.add(const Duration(days: 30)),
      usageCount: 25,

      createdAt: _now,
      updatedAt: _now,
    ),
    DiscountCouponModel(
      documentId: 'coupon_2',
      storeId: 'store_2',
      desc: 'Kahve molası',
      discountRate: 15,
      storeName: 'Antakya Coffee',
      createdBy: 'user_2',
      expiresAt: _now.subtract(const Duration(days: 45)),
      usageCount: 10,
      usageLimit: 50,
      createdAt: _now,
      updatedAt: _now,
    ),
    DiscountCouponModel(
      documentId: 'coupon_3',
      storeId: 'store_3',
      desc: 'Tatlı indirimi',
      discountRate: 10,
      storeName: 'Mozaik Tatlı',
      createdBy: 'user_3',
      expiresAt: _now.add(const Duration(days: 60)),
      usageCount: 25,
      usageLimit: 25,
      createdAt: _now,
      updatedAt: _now,
    ),
  ];
}
