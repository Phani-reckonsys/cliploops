// player_screen.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_new/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

// Helper class to manage position data from different streams
class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(this.position, this.bufferedPosition, this.duration);
}

class PlayerScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const PlayerScreen({super.key, required this.audioPlayer});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // Stream to combine position, buffered position, and duration
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        widget.audioPlayer.positionStream,
        widget.audioPlayer.bufferedPositionStream,
        widget.audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: double.infinity,
        width: double.infinity,
        // Optional: Add a gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800.withOpacity(0.8), Colors.black],
          ),
        ),
        child: StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.currentSource == null) {
              return const Center(child: Text("Not playing", style: TextStyle(color: Colors.white)));
            }
            final metadata = state!.currentSource!.tag as SongModel;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // --- ALBUM ART ---
                _buildArtwork(metadata),
                const SizedBox(height: 30),
                // --- SONG AND ARTIST INFO ---
                Text(
                  metadata.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  metadata.artist ?? "Unknown Artist",
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 30),
                // --- PROGRESS SLIDER ---
                _buildProgressBar(),
                const SizedBox(height: 20),
                // --- PLAYBACK CONTROLS ---
                _buildControls(),
                const Spacer(),
                // --- BOTTOM ACTION BUTTONS ---
                _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildArtwork(SongModel metadata) {
    return QueryArtworkWidget(
      id: metadata.id,
      type: ArtworkType.AUDIO,
      artworkHeight: 250,
      artworkWidth: 250,
      artworkFit: BoxFit.cover,
      artworkBorder: BorderRadius.circular(12.0),
      nullArtworkWidget: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.music_note, color: Colors.white70, size: 100),
      ),
    );
  }

  Widget _buildProgressBar() {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data ?? PositionData(Duration.zero, Duration.zero, Duration.zero);
        return Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                trackHeight: 2.0,
              ),
              child: Slider(
                min: 0.0,
                max: positionData.duration.inMilliseconds.toDouble(),
                value: positionData.position.inMilliseconds.toDouble().clamp(0.0, positionData.duration.inMilliseconds.toDouble()),
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.3),
                onChanged: (value) {
                  widget.audioPlayer.seek(Duration(milliseconds: value.round()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(positionData.position), style: const TextStyle(color: Colors.white70)),
                  Text(_formatDuration(positionData.duration - positionData.position), style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Shuffle Button
        StreamBuilder<bool>(
          stream: widget.audioPlayer.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            return IconButton(
              icon: Icon(Icons.shuffle, color: snapshot.data == true ? Colors.redAccent : Colors.white),
              onPressed: () async => await widget.audioPlayer.setShuffleModeEnabled(!(snapshot.data ?? false)),
            );
          },
        ),
        // Previous Button
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
          onPressed: widget.audioPlayer.seekToPrevious,
        ),
        // Play/Pause Button
        StreamBuilder<PlayerState>(
          stream: widget.audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return const SizedBox(
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 64.0),
                onPressed: widget.audioPlayer.play,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.pause_circle_filled, color: Colors.white, size: 64.0),
                onPressed: widget.audioPlayer.pause,
              );
            }
          },
        ),
        // Next Button
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
          onPressed: widget.audioPlayer.seekToNext,
        ),
        // Repeat Button
        StreamBuilder<LoopMode>(
          stream: widget.audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? LoopMode.off;
            const icons = [Icon(Icons.repeat, color: Colors.white), Icon(Icons.repeat_one, color: Colors.redAccent), Icon(Icons.repeat, color: Colors.redAccent)];
            const cycleOrder = [LoopMode.off, LoopMode.one, LoopMode.all];
            final index = cycleOrder.indexOf(loopMode);
            return IconButton(
              icon: icons[index],
              onPressed: () {
                widget.audioPlayer.setLoopMode(cycleOrder[(index + 1) % cycleOrder.length]);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _actionCard(
            icon: Icons.download_for_offline_outlined,
            title: "Readymade tunes",
            subtitle: "Ready made tones from this song...",
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _actionCard(
            icon: Icons.cut,
            title: "Use Clip",
            subtitle: "You can crop any part of the song...",
          ),
        ),
      ],
    );
  }

  Widget _actionCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }
}