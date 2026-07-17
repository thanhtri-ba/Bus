import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/shared/pref_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/services/user_service.dart';
import 'package:busz/services/wallet_service.dart';
import 'package:busz/services/loyalty_service.dart';
import 'package:busz/models/home_models.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;
  Wallet? _wallet;
  Loyalty? _loyalty;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        UserService.getProfile(),
        WalletService.getMyWallet(),
        LoyaltyService.getLoyalty(),
      ]);
      if (mounted) {
        setState(() {
          _profile = results[0] as UserProfile?;
          _wallet = results[1] as Wallet?;
          _loyalty = results[2] as Loyalty?;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String get _displayName => _profile?.name ?? 'Khách';
  String get _initial =>
      _displayName.isNotEmpty ? _displayName[0].toUpperCase() : 'B';
  String get _tierName => _loyalty?.tierName ?? 'Thành Viên Mới';
  String get _walletBalance => _wallet?.balanceStr ?? '0 ₫';
  int get _loyaltyPoints => _loyalty?.points ?? 0;

  Color get _tierColor {
    final tier = _tierName.toLowerCase();
    if (tier.contains('vàng') || tier.contains('gold'))
      return const Color(0xFFFFB547);
    if (tier.contains('bạc') || tier.contains('silver'))
      return AppColors.gray500;
    if (tier.contains('kim') || tier.contains('platinum'))
      return const Color(0xFF8B5CF6);
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : const Color(0xFFF4F7FB);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: bg,
        body: RefreshIndicator(
          onRefresh: _loadData,
          color: AppColors.primary,
          displacement: 80,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // ── Hero Header & Stats ───────────────────────────
              SliverToBoxAdapter(child: _buildHeaderAndStats(context, isDark)),

              // ── Quick Actions ──────────────────────────────────
              SliverToBoxAdapter(child: _buildQuickActions(context, isDark)),

              // ── Settings sections ─────────────────────────────
              SliverToBoxAdapter(child: _buildSections(context, isDark)),

              // ── Logout ─────────────────────────────────────────
              SliverToBoxAdapter(child: _buildLogout(context)),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HEADER & STATS (Combined into one Stack so Stats Card is on top)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeaderAndStats(BuildContext context, bool isDark) {
    return Stack(
      children: [
        // 1) The Teal Background Header
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0C2340), Color(0xFF0796A8)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(right: -40, top: -40, child: _circle(200, 0.05)),
                  Positioned(left: -60, bottom: 0, child: _circle(180, 0.04)),

                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        16,
                        20,
                        90,
                      ), // Increased padding to prevent avatar overlap
                      child: Column(
                        children: [
                          // Top bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tài khoản',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push(RouteNames.settings),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Symbols.settings_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Avatar + Name + Edit
                          Row(
                            children: [
                              // Avatar
                              Container(
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _initial,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Name and Tier
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _isLoading
                                        ? Container(
                                            height: 28,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          )
                                        : Text(
                                            _displayName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                    const SizedBox(height: 8),
                                    // Tier badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Symbols.workspace_premium_rounded,
                                            size: 14,
                                            color: _tierColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _tierName,
                                            style: TextStyle(
                                              color: _tierColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Edit button
                              GestureDetector(
                                onTap: () =>
                                    context.push(RouteNames.editProfile),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Symbols.edit_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Invisible space to take up the bottom half of the stats card
            const SizedBox(height: 54),
          ],
        ),

        // 2) The Stats Card positioned exactly at the bottom center of the Stack
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildStatItem(
                  '💰',
                  _isLoading ? '...' : _walletBalance,
                  'Ví BusZ',
                ),
                _buildStatDivider(),
                _buildStatItem(
                  '⭐',
                  _isLoading ? '...' : '$_loyaltyPoints',
                  'Điểm thưởng',
                ),
                _buildStatDivider(),
                _buildStatItem('🎫', '0', 'Chuyến đi'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _circle(double size, double opacity) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withValues(alpha: opacity),
    ),
  );

  Widget _buildStatItem(String emoji, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.gray600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 44, color: AppColors.gray200);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // QUICK ACTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildQuickActions(BuildContext context, bool isDark) {
    final actions = [
      (
        icon: Symbols.wallet_rounded,
        label: 'Nạp tiền',
        color: AppColors.primary,
        onTap: () {},
      ),
      (
        icon: Symbols.confirmation_number_rounded,
        label: 'Vé của tôi',
        color: const Color(0xFF8B5CF6),
        onTap: () => context.go(RouteNames.bookings),
      ),
      (
        icon: Symbols.local_offer_rounded,
        label: 'Khuyến mãi',
        color: AppColors.warning,
        onTap: () => context.push(RouteNames.promos),
      ),
      (
        icon: Symbols.support_agent_rounded,
        label: 'Hỗ trợ',
        color: const Color(0xFF16A34A),
        onTap: () {},
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((a) {
          return Expanded(
            child: GestureDetector(
              onTap: a.onTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isDark ? 0.2 : 0.05,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: a.color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(a.icon, color: a.color, size: 22),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    a.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSections(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSectionGroup(
            title: 'Tài khoản',
            isDark: isDark,
            items: [
              _buildTile(
                Symbols.person_rounded,
                'Chỉnh sửa thông tin',
                AppColors.primary,
                () => context.push(RouteNames.editProfile),
              ),
              _buildDivider(isDark),
              _buildTile(
                Symbols.location_on_rounded,
                'Địa chỉ của tôi',
                const Color(0xFF16A34A),
                () => context.push(RouteNames.myAddress),
              ),
              _buildDivider(isDark),
              _buildTile(
                Symbols.credit_card_rounded,
                'Phương thức thanh toán',
                const Color(0xFFFFB547),
                () => context.push(RouteNames.paymentMethods),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildSectionGroup(
            title: 'Hành trình',
            isDark: isDark,
            items: [
              _buildTile(
                Symbols.history_rounded,
                'Lịch sử đặt vé',
                const Color(0xFF0796A8),
                () => context.push(RouteNames.bookingHistory),
              ),
              _buildDivider(isDark),
              _buildTile(
                Symbols.favorite_rounded,
                'Tuyến đường yêu thích',
                const Color(0xFFEC4899),
                () => context.push(RouteNames.favoriteRoutes),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildSectionGroup(
            title: 'Cài đặt chung',
            isDark: isDark,
            items: [
              _buildTile(
                Symbols.security_rounded,
                'Đổi mật khẩu',
                const Color(0xFFEF4444),
                () => context.push(RouteNames.changePassword),
              ),
              _buildDivider(isDark),
              _buildTile(
                Symbols.settings_rounded,
                'Cài đặt ứng dụng',
                AppColors.gray600,
                () => context.push(RouteNames.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionGroup({
    required String title,
    required bool isDark,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Symbols.chevron_right_rounded,
              color: AppColors.gray400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      indent: 60,
      endIndent: 16,
      color: isDark ? AppColors.darkBorder : AppColors.gray200,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOGOUT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: OutlinedButton(
        onPressed: () => _showLogoutDialog(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: BorderSide(
            color: AppColors.error.withValues(alpha: 0.3),
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.logout_rounded, size: 20),
            SizedBox(width: 8),
            Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Đăng xuất',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Hủy',
              style: TextStyle(
                color: AppColors.gray600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              // Log out properly
              try {
                await Supabase.instance.client.auth.signOut();
              } catch (e) {
                // Ignore
              }
              await PrefHelper.setAccessToken('');
              await PrefHelper.setRefreshToken('');

              if (!context.mounted) return;
              context.go(RouteNames.auth);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
