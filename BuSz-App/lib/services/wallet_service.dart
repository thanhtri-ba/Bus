import 'package:busz/models/home_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class WalletService {
  static final _supabase = Supabase.instance.client;

  static Future<Wallet> getMyWallet() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return Wallet(balanceStr: '0 ₫');

    try {
      final response = await _supabase
          .from('wallets')
          .select()
          .eq('userId', user.id)
          .maybeSingle();

      if (response == null) return Wallet(balanceStr: '0 ₫');
      return Wallet.fromJson(response);
    } catch (e) {
      debugPrint('Error getting wallet: $e');
      return Wallet(balanceStr: '0 ₫');
    }
  }
}
