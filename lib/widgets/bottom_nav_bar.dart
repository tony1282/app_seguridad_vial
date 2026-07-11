import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, -2)),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run_outlined),
            activeIcon: Icon(Icons.directions_run),
            label: 'Actividad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_outlined),
            activeIcon: Icon(Icons.watch),
            label: 'Reloj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
      ),
    );
  }
}
