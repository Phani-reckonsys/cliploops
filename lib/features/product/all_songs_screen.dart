import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_new/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'player_screen.dart'; // Make sure the path is correct

// --- SCREEN WIDGET ---
class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  // --- STATE VARIABLES ---
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _selectedFilter = 'All';
  bool _isLoading = true;
  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndFetchSongs();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // --- DATA FETCHING & PLAYBACK LOGIC ---

  Future<void> _requestPermissionAndFetchSongs() async {
    var status = await Permission.audio.request();

    if (status.isGranted) {
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
      print("Audio permission denied.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _playSong(int index) async {
    if (_songs.isEmpty) return;
    final song = _songs[index];
    try {
      await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(song.uri!), tag: song),
      );
      _audioPlayer.play();
    } catch (e) {
      print("Error setting audio source: $e");
    }
  }

  String _formatDuration(int? milliseconds) {
    if (milliseconds == null) return '--:--';
    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // --- WIDGET BUILDERS ---

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white54),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }

  Widget _buildSongItem(BuildContext context, SongModel song, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      leading: QueryArtworkWidget(
        id: song.id,
        type: ArtworkType.AUDIO,
        artworkFit: BoxFit.cover,
        artworkBorder: BorderRadius.circular(8.0),
        nullArtworkWidget: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.music_note, color: Colors.white70),
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              song.artist ?? "Unknown Artist",
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _formatDuration(song.duration),
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white70),
        onPressed: () {},
      ),
      onTap: () => _playSong(index),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_songs.isEmpty) return const Center(child: Text('No songs found on this device.', style: TextStyle(color: Colors.white70)));
    return ListView.builder(
      itemCount: _songs.length,
      itemBuilder: (context, index) => _buildSongItem(context, _songs[index], index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('All Songs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Favourites'),
                const SizedBox(width: 8),
                _buildFilterChip('Most played'),
                const Spacer(),
                IconButton(icon: const Icon(Icons.filter_list, color: Colors.white), onPressed: () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search your Song',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                suffixIcon: Icon(Icons.mic, color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: MiniPlayer(audioPlayer: _audioPlayer),
    );
  }
}

// --- MINI PLAYER WIDGET ---
// In AllSongsScreen.dart

// --- MINI PLAYER WIDGET ---
class MiniPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MiniPlayer({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.currentSource == null) return const SizedBox.shrink();
        final metadata = state!.currentSource!.tag as SongModel;

        return GestureDetector( // <-- WRAP WITH GESTURE DETECTOR
          onTap: () {
            // Navigate to the full player screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerScreen(audioPlayer: audioPlayer),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: const Border(top: BorderSide(color: Colors.black, width: 1.0)),
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: metadata.id,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.cover,
                artworkBorder: BorderRadius.circular(4.0),
                nullArtworkWidget: const Icon(Icons.music_note, color: Colors.white),
              ),
              title: Text(metadata.title, style: const TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(metadata.artist ?? "Unknown Artist", style: TextStyle(color: Colors.white.withOpacity(0.7)), maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: _buildControls(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildControls() {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
          return const SizedBox(width: 32.0, height: 32.0, child: CircularProgressIndicator(color: Colors.white));
        } else if (playing != true) {
          return IconButton(icon: const Icon(Icons.play_arrow, color: Colors.white), iconSize: 32.0, onPressed: audioPlayer.play);
        } else {
          return IconButton(icon: const Icon(Icons.pause, color: Colors.white), iconSize: 32.0, onPressed: audioPlayer.pause);
        }
      },
    );
  }
}
