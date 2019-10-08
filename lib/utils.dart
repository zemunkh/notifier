
import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';



class LocalAudioTools {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Map<String, String> _nameToPath = {};
  final Map<String, String> _nameToPath0 = {};
  final Map<String, String> _nameToPath1 = {};


  Future loadFile(String name) async {
    final bytes = await rootBundle.load('assets/audio/$name');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(new Uint8List.view(bytes.buffer));
    if (await file.exists()) _nameToPath[name] = file.path;
  }

  Future loadTwoFile(String name0, String name1) async {
    final bytes0 = await rootBundle.load('assets/audio/$name0');
    final dir0 = await getApplicationDocumentsDirectory();
    final file0 = File('${dir0.path}/$name0');

    await file0.writeAsBytes(new Uint8List.view(bytes0.buffer));
    if (await file0.exists()) _nameToPath0[name0] = file0.path;


    final bytes1 = await rootBundle.load('assets/audio/$name1');
    final dir1 = await getApplicationDocumentsDirectory();
    final file1 = File('${dir1.path}/$name1');

    await file1.writeAsBytes(new Uint8List.view(bytes1.buffer));
    if (await file1.exists()) _nameToPath1[name1] = file1.path;
  }

  bool playAudioLoop(String name) {
    // restart audio if it has finished
    // _audioPlayer.setCompletionHandler(() => playAudio(name));
    playAudio(name);
    // playerState = AudioPlayerState.COMPLETED;
    print('Audio is done!');
    return true;
  }



  Future<Null> playAudio(String name) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(_nameToPath[name], isLocal: true);
  }

  Future<Null> playTwoAudio(String name0, String name1) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(_nameToPath0[name0], isLocal: true);

    // await _audioPlayer.stop();
    // await _audioPlayer.play(_nameToPath1[name1], isLocal: true);
    // playAudio(name1);
  }
}