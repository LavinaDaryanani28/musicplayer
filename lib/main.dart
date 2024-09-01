import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/playermodel.dart';
import 'package:provider/provider.dart';

import 'miniplayer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioPlayerModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Mini-Player with Expand and Sync'),
          ),
          body: Center(
            child: MiniPlayer(songUrl: 'https://audio.jukehost.co.uk/vkosBJSkrfUSxeaGc0iQzsNeF7S7sTJP'),
          ),
        ),
      ),
    );
  }
}

