import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  // Helper method to determine the selected index based on the current route
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == '/playlist') {
      return 1;
    }
    // TODO: Add cases for other routes when you create them
    // if (location == '/all-songs') {
    //   return 2;
    // }
    // if (location == '/albums') {
    //   return 3;
    // }
    // if (location == '/folders') {
    //   return 4;
    // }
    // Default to the Home screen
    return 0;
  }

  // Helper method to handle navigation when an item is tapped
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/playlist');
        break;
      // TODO: Add navigation for other items
      // case 2:
      //   context.go('/all-songs');
      //   break;
      // case 3:
      //   context.go('/albums');
      //   break;
      // case 4:
      //   context.go('/folders');
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the currently selected index from the route
    final int currentIndex = _calculateSelectedIndex(context);

    return Container(
      height: 80,
      color: const Color(0xFF1C1C1C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 1. THE GRADIENT LINE WIDGET (no changes here)
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
          // 2. THE ROW OF NAVIGATION ITEMS
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, currentIndex, Icons.home, Icons.home_outlined, 'Home', 0),
                _buildNavItem(context, currentIndex, Icons.music_note, Icons.music_note_outlined, 'Playlist', 1),
                _buildNavItem(context, currentIndex, Icons.headphones, Icons.headphones_outlined, 'All Songs', 2),
                _buildNavItem(context, currentIndex, Icons.album, Icons.album_outlined, 'Albums', 3),
                _buildNavItem(context, currentIndex, Icons.folder, Icons.folder_outlined, 'Folders', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // This is now a regular method, not part of a State class
  Widget _buildNavItem(
    BuildContext context,
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
        // Use the navigation helper on tap
        onTap: () => _onItemTapped(index, context),
        // Removes the splash effect for a cleaner look
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: index == 0 ? Colors.transparent : Colors.grey.withAlpha(10),
                width: 1.0,
              ),
            ),
          ),
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