
import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';

class LocalAudioTools {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Map<String, String> _nameToPath = {};

  Future loadFile(String name, String sname) async {
    final bytes = await rootBundle.load('assets/audio/$name');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(new Uint8List.view(bytes.buffer));
    if (await file.exists()) _nameToPath[name] = file.path;

    if(sname != null) {
      final sbytes = await rootBundle.load('assets/audio/$sname');
      final sdir = await getApplicationDocumentsDirectory();
      final sfile = File('${sdir.path}/$sname');

      await file.writeAsBytes(new Uint8List.view(sbytes.buffer));
      if (await file.exists()) _nameToPath[sname] = sfile.path;
    }
  }

  void playAudioLoop(String name, String sname) {
    // restart audio if it has finished
    // _audioPlayer.setCompletionHandler(() => playAudio(name));
    _audioPlayer.onPlayerStateChanged.listen((s){
      if(s == AudioPlayerState.COMPLETED) {
        print('Player Stopped');
        if(sname != null) {
          // playAudio(sname);
          // playAudio(sname);
        }
      }
    });
    playAudio(name);
    print('Audio is done!');
    
  }

  Future<Null> playAudio(String name) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(_nameToPath[name], isLocal: true);
  }
}