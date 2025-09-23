// --- MINI PLAYER WIDGET ---
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_new/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MiniPlayer({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    // Listen to the player's state to know what song is playing
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        // If there's no song, hide the player
        if (state?.currentSource == null) {
          return const SizedBox.shrink();
        }
        // Get the song metadata from the tag
        final metadata = state!.currentSource!.tag as SongModel;

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            border: const Border(top: BorderSide(color: Colors.black, width: 1.0)),
          ),
          child: ListTile(
            leading: const Icon(Icons.music_note, color: Colors.white),
            title: Text(
              metadata.title,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              metadata.artist ?? "Unknown Artist",
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: _buildControls(),
          ),
        );
      },
    );
  }

  // Builds the play/pause/loading controls
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
            child: CircularProgressIndicator(color: Colors.white),
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