import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String? currentSongUrl;

  AudioPlayerModel() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });
  }

  void play(String url) async {
    if (currentSongUrl != url) {
      currentSongUrl = url;
      await _audioPlayer.play(UrlSource(url));
    } else {
      await _audioPlayer.resume();
    }
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void skipForward() {
    final newPosition = position + Duration(seconds: 10);
    seek(newPosition);
  }

  void skipBackward() {
    final newPosition = position - Duration(seconds: 10);
    seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
