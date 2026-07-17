import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:busz/models/home_models.dart';
import 'package:flutter/material.dart';

class PromoService {
  static Future<List<Promo>> getPromotions() async {
    try {
      // Column names are camelCase in DB (Prisma without @map decorator)
      final response = await Supabase.instance.client
          .from('promotions')
          .select(
            'id, code, title, subtitle, "logoPath", "maxDiscount", "isActive"',
          )
          .eq('isActive', true)
          .order('createdAt', ascending: false)
          .limit(10);

      debugPrint(
        'PromoService: fetched ${(response as List).length} promotions',
      );

      final promos = response
          .map<Promo>(
            (e) => Promo(
              id: e['code'] as String? ?? '',
              title: e['title'] as String? ?? '',
              subtitle: e['subtitle'] as String? ?? '',
              logoPath: e['logoPath'] as String? ?? '',
              discountAmount: (e['maxDiscount'] as num?)?.toInt() ?? 0,
            ),
          )
          .where((p) => p.id.isNotEmpty)
          .toList();

      if (promos.isEmpty) {
        debugPrint('PromoService: no active promos, using mock data');
        return _mockPromos();
      }

      return promos;
    } catch (e) {
      debugPrint('PromoService error: $e');
      return _mockPromos();
    }
  }

  static List<Promo> _mockPromos() {
    return [
      Promo(
        id: 'SUMMER30',
        title: 'Giảm 30% mùa hè',
        subtitle: 'Áp dụng cho tất cả tuyến',
        logoPath:
            'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80',
        discountAmount: 50000,
      ),
      Promo(
        id: 'NEWUSER50',
        title: 'Ưu đãi khách hàng mới',
        subtitle: 'Giảm đến 50.000đ chuyến đầu',
        logoPath:
            'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?auto=format&fit=crop&w=800&q=80',
        discountAmount: 50000,
      ),
      Promo(
        id: 'WEEKEND20',
        title: 'Weekend Special',
        subtitle: 'Giảm 20% cuối tuần',
        logoPath:
            'https://images.unsplash.com/photo-1494515843206-f3117d3f51b7?auto=format&fit=crop&w=800&q=80',
        discountAmount: 30000,
      ),
    ];
  }
}
