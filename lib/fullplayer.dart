import 'package:flutter/material.dart';
import 'package:musicplayer/playermodel.dart';
import 'package:provider/provider.dart';

class FullPlayer extends StatelessWidget {
  final String songUrl;

  FullPlayer({required this.songUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Song Title',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Artist Name',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Slider(
            min: 0,
            max: context.watch<AudioPlayerModel>().duration.inSeconds.toDouble(),
            value: context.watch<AudioPlayerModel>().position.inSeconds.toDouble(),
            onChanged: (value) {
              final position = Duration(seconds: value.toInt());
              context.read<AudioPlayerModel>().seek(position);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(context.watch<AudioPlayerModel>().position)),
                Text(formatDuration(context.watch<AudioPlayerModel>().duration)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, size: 36),
                onPressed: () {
                  context.read<AudioPlayerModel>().skipBackward();
                },
              ),
              IconButton(
                icon: Icon(context.watch<AudioPlayerModel>().isPlaying ? Icons.pause : Icons.play_arrow, size: 36),
                onPressed: () {
                  if (context.read<AudioPlayerModel>().isPlaying) {
                    context.read<AudioPlayerModel>().pause();
                  } else {
                    context.read<AudioPlayerModel>().play(songUrl);
                    // context.read<AudioPlayerModel>().play(context.read<AudioPlayerModel>().currentSongUrl!);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, size: 36),
                onPressed: () {
                  context.read<AudioPlayerModel>().skipForward();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
