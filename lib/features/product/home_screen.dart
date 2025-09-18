import 'package:flutter/material.dart';

// --- DATA MODELS (remain the same) ---
class Album {
  final String imagePath;
  final String title;
  final String artist;
  Album({required this.imagePath, required this.title, required this.artist});
}

class Song {
  final String title;
  final String artist;
  Song({required this.title, required this.artist});
}
// --------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- STATE VARIABLES ---
  int _bottomNavIndex = 0; // For BottomNavigationBar
  // -----------------------

  // --- MOCK DATA (remains the same) ---
  final List<Album> _quickPicks = [
    Album(
      imagePath: 'assets/covers/cover1.png',
      title: 'Echoes of the Night',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover2.png',
      title: 'Whispers of the Heart',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover3.png',
      title: 'Chasing Stars',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover4.png',
      title: 'Serenade of the Sea',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover5.png',
      title: 'Melody of Dreams',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover6.png',
      title: 'Voices in the Wind',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover7.png',
      title: 'Dancing Shadows',
      artist: 'Artist Name',
    ),
    Album(
      imagePath: 'assets/covers/cover8.png',
      title: 'Rhythm of the Rain',
      artist: 'Artist Name',
    ),
  ];

  final List<Song> _playlist = [
    Song(title: 'Echoes of Tomorrow', artist: 'Artist Name'),
    Song(title: 'Whispers in the Wind', artist: 'Artist Name'),
  ];
  // ------------------

  // --- WIDGET BUILDERS (remain the same) ---
  Widget _buildAlbumCard(Album album) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              album.imagePath,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  width: 150,
                  color: Colors.white24,
                  child: const Icon(Icons.music_note, color: Colors.white70),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            album.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            album.artist,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSquareAlbumCard(Album album) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              album.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white24,
                  child: const Icon(Icons.music_note, color: Colors.white70),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                album.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
            ),
          ),
          if (onTap != null)
            InkWell(
              onTap: onTap,
              child: const Icon(Icons.chevron_right, color: Colors.white),
            ),
        ],
      ),
    );
  }
  // -----------------------

  // --- NEW: CUSTOM BOTTOM NAVIGATION BAR WIDGET ---
  // --- NEW: CUSTOM BOTTOM NAVIGATION BAR WIDGET ---
  Widget _buildCustomBottomNavBar() {
    // Helper to build each individual item (this function does not change)
    Widget buildNavItem(
      IconData selectedIcon,
      IconData unselectedIcon,
      String label,
      int index,
    ) {
      // ... same as before
      final bool isSelected = _bottomNavIndex == index;
      final Color color = isSelected ? Colors.red : Colors.grey;

      return Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              _bottomNavIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: index == 0
                      ? Colors.transparent
                      : Colors.grey.withAlpha(10),
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
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      // This is the main container for the nav bar background
      height: 80,
      color: const Color(0xFF1C1C1C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 1. THE GRADIENT LINE WIDGET
          Container(
            height: 1, // The thickness of the line
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // The gradient goes from left to right
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                // The colors go from transparent, to red in the middle, and back to transparent
                colors: [
                  Colors.transparent,
                  Colors.red.withOpacity(0.8),
                  Colors.red,
                  Colors.red.withOpacity(0.8),
                  Colors.transparent,
                ],
                // Stops control where the colors are placed along the gradient
                stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
              ),
            ),
          ),

          // 2. THE ROW OF NAVIGATION ITEMS
          // Expanded ensures the Row takes up the rest of the vertical space
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(Icons.home, Icons.home_outlined, 'Home', 0),
                buildNavItem(
                  Icons.music_note,
                  Icons.music_note_outlined,
                  'Playlist',
                  1,
                ),
                buildNavItem(
                  Icons.headphones,
                  Icons.headphones_outlined,
                  'All Songs',
                  2,
                ),
                buildNavItem(Icons.album, Icons.album_outlined, 'Albums', 3),
                buildNavItem(Icons.folder, Icons.folder_outlined, 'Folders', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -200,
          left: -200,
          width: 800,
          child: Image.asset('assets/top-background-2.png', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage("assets/dummy-avatar.png"),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Hello, Harsh",
                    style: TextStyle(
                      shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // --- BODY (remains the same) ---
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        "Quick Picks",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        itemCount: (_quickPicks.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildAlbumCard(_quickPicks[index * 2]),
                              if (index * 2 + 1 < _quickPicks.length)
                                _buildAlbumCard(_quickPicks[index * 2 + 1]),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: _buildSectionHeader("Playlist", onTap: () {}),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final song = _playlist[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.music_note,
                      color: Colors.white70,
                    ),
                    title: Text(
                      song.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      song.artist,
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  );
                }, childCount: _playlist.length),
              ),

              SliverToBoxAdapter(child: _buildSectionHeader("Albums")),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return _buildSquareAlbumCard(_quickPicks[index]);
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // --- REPLACED with custom widget ---
          bottomNavigationBar: _buildCustomBottomNavBar(),
        ),
      ],
    );
  }
}
