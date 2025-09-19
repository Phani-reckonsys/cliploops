// your_router_file.dart (Updated)

// Add imports for the new screens
import 'package:cliploops/features/product/all_songs_screen.dart';
import 'package:cliploops/features/product/albums_screen.dart';
import 'package:cliploops/features/product/folders_screen.dart';

import 'package:cliploops/features/product/playlist_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cliploops/features/welcome/welcome_main.dart';
import 'package:cliploops/features/product/home_screen.dart';
import 'package:cliploops/features/product/main_shell.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: "/welcome", builder: (context, state) => const WelcomeMain()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),

        // Branch 1: Playlist
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/playlist', builder: (context, state) => const PlaylistScreen()),
          ],
        ),

        // --- ADD THE MISSING BRANCHES ---

        // Branch 2: All Songs
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/all-songs', builder: (context, state) => const AllSongsScreen()),
          ],
        ),

        // Branch 3: Albums
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/albums', builder: (context, state) => const AlbumsScreen()),
          ],
        ),

        // Branch 4: Folders
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/folders', builder: (context, state) => const FoldersScreen()),
          ],
        ),
      ],
    ),
  ],
);