import 'package:supabase_flutter/supabase_flutter.dart';

class AddressModel {
  final String id;
  final String title;
  final String address;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.address,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      title: json['title'] as String,
      address: json['address'] as String,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'is_default': isDefault,
    };
  }
}

class AddressService {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _tableName = 'user_addresses';

  Future<List<AddressModel>> getAddresses() async {
    final userId = _supabase.auth.currentUser?.id;

    final query = _supabase.from(_tableName).select();
    final response = userId != null
        ? await query
              .eq('user_id', userId)
              .order('created_at', ascending: false)
        : await query.order('created_at', ascending: false);

    return (response as List)
        .map((json) => AddressModel.fromJson(json))
        .toList();
  }

  Future<void> addAddress(String title, String address) async {
    final userId = _supabase.auth.currentUser?.id;

    final existing = await getAddresses();
    final isDefault = existing.isEmpty;

    final data = {'title': title, 'address': address, 'is_default': isDefault};

    if (userId != null) {
      data['user_id'] = userId;
    }

    await _supabase.from(_tableName).insert(data);
  }

  Future<void> deleteAddress(String id) async {
    await _supabase.from(_tableName).delete().eq('id', id);
  }
}
