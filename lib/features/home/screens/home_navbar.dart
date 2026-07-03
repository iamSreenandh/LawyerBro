import 'package:flutter/material.dart';
import 'package:lawyer_bro/features/home/screens/app_drawer.dart';
import 'package:lawyer_bro/features/home/screens/home_page.dart';
import 'package:lawyer_bro/styles/app_colors.dart';
import 'package:lawyer_bro/styles/app_text_styles.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  int _selectedIndex = 0;

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.search_rounded, label: 'Search'),
    _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
    _NavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  // Placeholder pages — replace with real screen widgets as you build them
  static const List<Widget> _pages = [HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Hi.Sreenandh",
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.darkSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          SizedBox(width: 14),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade100,
            backgroundImage: AssetImage('assets/images/user_avatar.png'),
          ),
          SizedBox(width: 14),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: _AppNavBar(
        selectedIndex: _selectedIndex,
        items: _navItems,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom bottom nav bar
// ─────────────────────────────────────────────────────────────────────────────
class _AppNavBar extends StatelessWidget {
  const _AppNavBar({
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkSurface.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == selectedIndex;
              return _NavBarItem(
                item: items[i],
                selected: selected,
                onTap: () => onTap(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: selected ? AppColors.darkSurface : AppColors.textHint,
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              Text(
                item.label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.darkSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────────────────────
class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
