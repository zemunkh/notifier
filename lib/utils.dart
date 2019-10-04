
import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';

class LocalAudioTools {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Map<String, String> _nameToPath = {};

  Future loadFile(String name) async {
    final bytes = await rootBundle.load('assets/audio/$name');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(new Uint8List.view(bytes.buffer));
    if (await file.exists()) _nameToPath[name] = file.path;
  }

  void playAudioLoop(String name) {
    // restart audio if it has finished
    // _audioPlayer.setCompletionHandler(() => playAudio(name));
    print('Audio is done!');
    playAudio(name);
  }

  Future<Null> playAudio(String name) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(_nameToPath[name], isLocal: true);
  }
}