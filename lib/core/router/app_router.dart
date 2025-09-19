import 'package:cliploops/features/product/playlist_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cliploops/features/welcome/welcome_main.dart';
import 'package:cliploops/features/product/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: "/welcome", builder: (context, state) => const WelcomeMain()),
    GoRoute(path: "/", builder:(context, state) => const HomeScreen()),
    GoRoute(path: "/playlist", builder: (context, state) => const PlaylistScreen())
  ],
);
