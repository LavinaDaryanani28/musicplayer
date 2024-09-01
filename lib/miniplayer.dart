import 'package:flutter/material.dart';
import 'package:musicplayer/playermodel.dart';
import 'package:provider/provider.dart';

import 'fullplayer.dart';

class MiniPlayer extends StatelessWidget {
  final String songUrl;

  MiniPlayer({required this.songUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullPlayer(songUrl:songUrl)));
      },
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(
              Icons.music_note,
              color: Colors.white,
              size: 40.0,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Song Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                context.watch<AudioPlayerModel>().isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                if (context.read<AudioPlayerModel>().isPlaying) {
                  context.read<AudioPlayerModel>().pause();
                } else {
                  context.read<AudioPlayerModel>().play(songUrl);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
