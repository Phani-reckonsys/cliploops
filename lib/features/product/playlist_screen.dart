import 'package:flutter/material.dart';
import 'package:cliploops/features/product/custom_bottom_navbar.dart'; // Assuming this is the correct path

// --- DATA MODEL ---
// A simple class to hold data for each playlist item
class PlaylistItem {
  final String imagePath;
  final String title;
  final int songCount;

  PlaylistItem({
    required this.imagePath,
    required this.title,
    required this.songCount,
  });
}

// --- SCREEN WIDGET ---
class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // --- STATE VARIABLES ---
  String _selectedFilter = 'All'; // To track the active filter chip

  // --- MOCK DATA ---
  // A list of playlist items to display on the screen
  final List<PlaylistItem> _playlists = [
    PlaylistItem(
      imagePath: 'assets/covers/cover1.png',
      title: 'Bollywood Songs',
      songCount: 12,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover2.png',
      title: 'Workout Playlist',
      songCount: 12,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover3.png',
      title: 'Hollywood',
      songCount: 12,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover4.png',
      title: 'Arjun Singh',
      songCount: 12,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover5.png',
      title: 'Favourites',
      songCount: 12,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover6.png',
      title: 'Road Trip Mix',
      songCount: 25,
    ),
    PlaylistItem(
      imagePath: 'assets/covers/cover7.png',
      title: 'Focus & Study',
      songCount: 18,
    ),
  ];

  // --- WIDGET BUILDERS ---

  /// Builds a single filter chip.
  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white54,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  /// Builds a single row in the playlist.
  Widget _buildPlaylistItem(PlaylistItem item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          item.imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.white24,
              child: const Icon(Icons.music_note, color: Colors.white70),
            );
          },
        ),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '${item.songCount} Songs',
        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white70),
        onPressed: () {
          // Handle more options tap
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Using the same background stack from your HomeScreen for consistency
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Playlist',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- FILTER CHIPS ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Favourites'),
                const SizedBox(width: 8),
                _buildFilterChip('Most played'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    // Handle filter tap
                  },
                ),
              ],
            ),
          ),

          // --- SEARCH BAR ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search your music',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                ),
                suffixIcon: Icon(
                  Icons.mic,
                  color: Colors.white.withOpacity(0.5),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // --- PLAYLIST ---
          Expanded(
            child: ListView.builder(
              itemCount: _playlists.length,
              itemBuilder: (context, index) {
                return _buildPlaylistItem(_playlists[index]);
              },
            ),
          ),
        ],
      ),
      // Using the same custom bottom navbar from your home scree
    );
  }
}
