import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentMethodModel {
  final String id;
  final String type;
  final String info;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.info,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      type: json['type'] as String,
      info: json['info'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'info': info};
  }
}

class PaymentMethodService {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _tableName = 'user_payment_methods';

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final userId = _supabase.auth.currentUser?.id;

    final query = _supabase.from(_tableName).select();
    final response = userId != null
        ? await query
              .eq('user_id', userId)
              .order('created_at', ascending: false)
        : await query.order('created_at', ascending: false);

    return (response as List)
        .map((json) => PaymentMethodModel.fromJson(json))
        .toList();
  }

  Future<void> addPaymentMethod(String type, String info) async {
    final userId = _supabase.auth.currentUser?.id;

    final data = {'type': type, 'info': info};

    if (userId != null) {
      data['user_id'] = userId;
    }

    await _supabase.from(_tableName).insert(data);
  }

  Future<void> deletePaymentMethod(String id) async {
    await _supabase.from(_tableName).delete().eq('id', id);
  }
}
