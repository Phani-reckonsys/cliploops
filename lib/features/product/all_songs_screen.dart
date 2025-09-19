import 'package:flutter/material.dart';

// --- DATA MODEL ---
// A simple class to hold data for each song item
class SongItem {
  final String title;
  final String artist;
  final String duration; // e.g., "3:20"

  SongItem({required this.title, required this.artist, required this.duration});
}

// --- SCREEN WIDGET ---
class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  // --- STATE VARIABLES ---
  String _selectedFilter = 'All'; // To track the active filter chip

  // --- MOCK DATA ---
  final List<SongItem> _allSongs = [
    SongItem(
      title: 'Whispers of the Night Sky',
      artist: 'Luna Starfire',
      duration: '3:20',
    ),
    SongItem(
      title: 'Dancing with Shadows and Light',
      artist: 'Celeste Moonshadow',
      duration: '3:20',
    ),
    SongItem(
      title: 'Echoes from the Heart of the Ocean',
      artist: 'Orion Nightingale',
      duration: '3:45',
    ),
    SongItem(
      title: 'Journey Through the Celestial Realm',
      artist: 'Seraphina Starlight',
      duration: '4:12',
    ),
    SongItem(
      title: 'Rhythms of the Enchanted Forest',
      artist: 'Astra Dreamweaver',
      duration: '2:58',
    ),
    SongItem(
      title: 'Chasing Stars in the Moonlight',
      artist: 'Nova Skydancer',
      duration: '3:30',
    ),
    SongItem(
      title: 'Melodies of the Forgotten Dreamers',
      artist: 'Lyra Sunwhisper',
      duration: '4:05',
    ),
    SongItem(
      title: 'Whispers of the Ancient Woods',
      artist: 'Elden Thornbark',
      duration: '3:22',
    ),
    SongItem(
      title: 'Echoes of the Distant Stars',
      artist: 'Nova Starfall',
      duration: '5:22',
    ),
    SongItem(
      title: 'Tales from the Wandering Shadows',
      artist: 'Mira Nightshade',
      duration: '4:58',
    ),
    SongItem(
      title: 'Crimson Sunset Serenade',
      artist: 'Zephyr Bloom',
      duration: '3:15',
    ),
    SongItem(
      title: 'Starlight Symphony',
      artist: 'Ember Echo',
      duration: '4:00',
    ),
    SongItem(
      title: 'Mystic River Flow',
      artist: 'Glimmer Glade',
      duration: '2:45',
    ),
    SongItem(
      title: 'Emerald Forest Dreams',
      artist: 'River Song',
      duration: '3:50',
    ),
    SongItem(
      title: 'Silent Sea Whispers',
      artist: 'Jade Frost',
      duration: '4:30',
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

  /// Builds a single song item in the list.
  Widget _buildSongItem(BuildContext context, SongItem song, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      leading: SizedBox(
        width: 30, // Adjust width to fit the number
        child: Text(
          '${index + 1}.', // Song number
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              song.artist,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            song.duration,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white70),
        onPressed: () {
          // Handle more options tap
        },
      ),
      onTap: () {
        // Handle song tap (e.g., play song)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Note: The Stack and Positioned for the background are now in MainShell.
    // This screen only builds its content.
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Important for background to show through
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading:
            false, // Handled by MainShell's PopScope if needed
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () {
        //     // This is usually for navigating back within the current tab's stack.
        //     // For top-level tabs, you might not have a back action here,
        //     // or it could navigate to the root of the current branch.
        //     // Given this is a top-level tab, removing the back button is common.
        //     // If you had sub-routes within AllSongs, then this would navigate within it.
        //     // For now, let's keep it simple, similar to PlaylistScreen.
        //     // context.go('/'); // Or simply remove it if this is a root tab.
        //     Navigator.of(
        //       context,
        //     ).pop(); // Go back within the current branch's stack
        //   },
        // ),
        title: const Text(
          'All Songs',
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
                hintText: 'Search your Song', // Changed hint text
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

          // --- ALL SONGS LIST ---
          Expanded(
            child: ListView.builder(
              itemCount: _allSongs.length,
              itemBuilder: (context, index) {
                return _buildSongItem(context, _allSongs[index], index);
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar is in the MainShell now
    );
  }
}
