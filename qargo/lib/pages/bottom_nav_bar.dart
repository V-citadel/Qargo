import 'package:flutter/material.dart';

class QargoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const QargoBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  static const Color _deepGreen = Color(0xFF218C5A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarIcon(
                icon: Icons.home,
                selected: currentIndex == 0,
                color: _deepGreen,
                onTap: () => onTap(0),
              ),
              _NavBarIcon(
                icon: Icons.grid_view,
                selected: currentIndex == 1,
                color: _deepGreen,
                onTap: () => onTap(1),
              ),
              _NavBarIcon(
                icon: Icons.pie_chart_outline,
                selected: currentIndex == 2,
                color: _deepGreen,
                onTap: () => onTap(2),
              ),
              _NavBarIcon(
                icon: Icons.settings,
                selected: currentIndex == 3,
                color: _deepGreen,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const _NavBarIcon({
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
            color: selected ? color : color.withOpacity(0.3),
          ),
          const SizedBox(height: 2),
          if (selected)
            Container(
              width: 24,
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
