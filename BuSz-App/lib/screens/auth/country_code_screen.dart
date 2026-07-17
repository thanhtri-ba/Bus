import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

class CountryCodeScreen extends StatefulWidget {
  const CountryCodeScreen({super.key});

  @override
  State<CountryCodeScreen> createState() => _CountryCodeScreenState();
}

class _Country {
  final String name;
  final String code;
  final String flag;
  final bool isPopular;

  const _Country({
    required this.name,
    required this.code,
    required this.flag,
    this.isPopular = false,
  });
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  String _searchQuery = '';

  final List<_Country> _allCountries = const [
    _Country(name: 'Indonesia', code: '+62', flag: '🇮🇩', isPopular: true),
    _Country(name: 'United States', code: '+1', flag: '🇺🇸', isPopular: true),
    _Country(name: 'Japan', code: '+81', flag: '🇯🇵', isPopular: true),
    _Country(name: 'Afghanistan', code: '+93', flag: '🇦🇫'),
    _Country(name: 'Albania', code: '+355', flag: '🇦🇱'),
    _Country(name: 'Algeria', code: '+213', flag: '🇩🇿'),
  ];

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.trim().toLowerCase();

    final filteredCountries = _allCountries.where((c) {
      return c.name.toLowerCase().contains(query) || c.code.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: AppColors.surfacePrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Symbols.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select region',
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.borderLight, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textHint,
                  ),
                  prefixIcon: const Icon(
                    Symbols.search_rounded,
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: query.isEmpty
                ? _buildDefaultList()
                : _buildFilteredList(filteredCountries),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultList() {
    final popular = _allCountries.where((c) => c.isPopular).toList();
    popular.sort((a, b) => a.name.compareTo(b.name));

    final others = _allCountries.where((c) => !c.isPopular).toList();
    others.sort((a, b) => a.name.compareTo(b.name));

    final Map<String, List<_Country>> groupedOthers = {};
    for (var c in others) {
      final firstLetter = c.name.isNotEmpty ? c.name[0].toUpperCase() : '';
      if (!groupedOthers.containsKey(firstLetter)) {
        groupedOthers[firstLetter] = [];
      }
      groupedOthers[firstLetter]!.add(c);
    }

    final sortedKeys = groupedOthers.keys.toList()..sort();

    final List<Widget> children = [];

    if (popular.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            'Popular',
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
      children.addAll(
        popular.map(
          (c) => _buildItem(
            context,
            c.name,
            c.code,
            c.flag,
            c.name == 'United States',
          ),
        ),
      );
    }

    for (var key in sortedKeys) {
      if (key.isEmpty) continue;
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            key,
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
      children.addAll(
        groupedOthers[key]!.map(
          (c) => _buildItem(context, c.name, c.code, c.flag, false),
        ),
      );
    }

    return ListView(children: children);
  }

  Widget _buildFilteredList(List<_Country> filtered) {
    if (filtered.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    final sortedFiltered = List<_Country>.from(filtered)
      ..sort((a, b) => a.name.compareTo(b.name));

    return ListView(
      children: sortedFiltered
          .map((c) => _buildItem(context, c.name, c.code, c.flag, false))
          .toList(),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String name,
    String code,
    String flag,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        context.pop(code);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              code,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            if (isSelected)
              const Icon(
                Symbols.check_rounded,
                color: AppColors.primary,
                size: 20,
              )
            else
              const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
