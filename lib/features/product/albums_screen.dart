import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_new/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  // ### State Variables ###
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isLoading = true;
  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndFetchSongs();
  }
  
  @override
  void dispose() {
    // Release the player resources
    _audioPlayer.dispose();
    super.dispose();
  }

  // ### Core Logic ###

  /// Request storage permission and fetch local audio files.
  Future<void> _requestPermissionAndFetchSongs() async {
    // Request audio permission
    var status = await Permission.audio.request();

    if (status.isGranted) {
      // Query for songs if permission is granted
      List<SongModel> fetchedSongs = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      setState(() {
        _songs = fetchedSongs;
        _isLoading = false;
      });
    } else {
      // Handle the case where permission is denied
      print("Audio permission denied.");
      setState(() {
        _isLoading = false;
      });
      _showPermissionDeniedDialog();
    }
  }

  /// Creates a playlist and starts playing the selected song.
  void _onSongTapped(int index) async {
    // Don't do anything if the song list is empty
    if (_songs.isEmpty) return;

    // Create a playlist from the song list
    final playlist = ConcatenatingAudioSource(
      children: _songs.map((song) {
        return AudioSource.uri(
          Uri.parse(song.uri!),
          // The tag is crucial for the mini-player to display song info
          tag: song,
        );
      }).toList(),
    );

    try {
      // Set the playlist on the player
      await _audioPlayer.setAudioSource(
        playlist,
        initialIndex: index, // Start from the tapped song
      );
      // Start playback
      _audioPlayer.play();
    } catch (e) {
      print("Error setting audio source: $e");
    }
  }

  // ### UI Helper Methods ###

  /// Shows a dialog explaining why the permission is needed.
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'This app needs storage access to find music files. Please grant the permission in the app settings.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // From permission_handler package
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // ### Build Method ###
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Music'),
        backgroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[900],
      body: _buildSongList(),
      bottomNavigationBar: MiniPlayer(audioPlayer: _audioPlayer),
    );
  }

  Widget _buildSongList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_songs.isEmpty) {
      return const Center(
        child: Text(
          'No songs found.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (context, index) {
        final song = _songs[index];
        return ListTile(
          leading: QueryArtworkWidget(
            id: song.id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: const Icon(
              Icons.music_note,
              color: Colors.white,
            ),
          ),
          title: Text(
            song.title,
            style: const TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            song.artist ?? 'Unknown Artist',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => _onSongTapped(index),
        );
      },
    );
  }
}

// ===================================================================
// Mini Player Widget
// ===================================================================

class MiniPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MiniPlayer({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: StreamBuilder<SequenceState?>(
        stream: audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) {
            // Return an empty container if there's no song
            return const SizedBox.shrink();
          }
          final metadata = state!.currentSource!.tag as SongModel;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            leading: QueryArtworkWidget(
              id: metadata.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(Icons.music_note, color: Colors.white),
            ),
            title: Text(
              metadata.title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              metadata.artist ?? "Unknown Artist",
              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: _buildControls(),
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return const SizedBox(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            iconSize: 32.0,
            onPressed: audioPlayer.play,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.pause, color: Colors.white),
            iconSize: 32.0,
            onPressed: audioPlayer.pause,
          );
        }
      },
    );
  }
}