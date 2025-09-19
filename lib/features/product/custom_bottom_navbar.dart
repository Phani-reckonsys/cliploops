// lib/features/product/custom_bottom_navbar.dart (Updated)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavbar({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    // Use the navigationShell to switch tabs
    navigationShell.goBranch(
      index,
      // navigate to the initial location of the branch if we're already on that tab
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // The current index comes directly from the navigationShell
    final int currentIndex = navigationShell.currentIndex;

    return Container(
      height: 85,
      padding: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF1C1C1C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Gradient line remains the same
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.red.withOpacity(0.8),
                  Colors.red,
                  Colors.red.withOpacity(0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  currentIndex,
                  Icons.home,
                  Icons.home_outlined,
                  'Home',
                  0,
                ),
                _buildNavItem(
                  currentIndex,
                  Icons.music_note,
                  Icons.music_note_outlined,
                  'Playlist',
                  1,
                ),
                _buildNavItem(
                  currentIndex,
                  Icons.headphones,
                  Icons.headphones_outlined,
                  'All Songs',
                  2,
                ),
                _buildNavItem(
                  currentIndex,
                  Icons.album,
                  Icons.album_outlined,
                  'Albums',
                  3,
                ),
                _buildNavItem(
                  currentIndex,
                  Icons.folder,
                  Icons.folder_outlined,
                  'Folders',
                  4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int currentIndex,
    IconData selectedIcon,
    IconData unselectedIcon,
    String label,
    int index,
  ) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected ? Colors.red : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          // ... rest of the styling is the same
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : unselectedIcon,
                color: color,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
