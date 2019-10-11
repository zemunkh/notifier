import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';


typedef void OnError(Exception exception);


void main() => runApp(new MyApp());

enum PlayerState { stopped, playing, paused }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Order App',
      home: OrderNotify(),
    );
  }
}

class OrderNotify extends StatefulWidget {
  @override
  _OrderNotifyState createState() => _OrderNotifyState();
}

class _OrderNotifyState extends State<OrderNotify> {
  final FocusNode _focusNode = FocusNode();
  String _message;

  List<String> entries = <String>[' ', ' ', ' ', ' ', ' ', ' '];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];
  final TextEditingController _myController = TextEditingController();

  String result = "";
  String starterAudio = 'ding.wav';

  bool doneStatus = false;

  AudioPlayer audioPlayer;
  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get isStopped => playerState == PlayerState.stopped;


  StreamSubscription _audioPlayerStateSubscription;

  // final Map<String, String> _nameToPath = {};
  String localFilePath;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    _focusNode.dispose();
    _myController.dispose();
    super.dispose();
  }

  String buffer = "";
  String audioFile = ''; 

  void _handleKeyEvent(RawKeyEvent event) {
    if(event.runtimeType.toString() == 'RawKeyUpEvent') {
      setState(() {
        if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          if(buffer.isNotEmpty) {
            result = buffer;
            _playAudioNotifier(result);
            audioFile = '$result.wav';
            print('I am Enter');
            // entries.insert(0, result);
            // entries.removeLast();
          }
          buffer = '';

        } else {
          var logicalKey = event.logicalKey.keyLabel;
          switch (logicalKey) {
            case '0':
              print('I am Zero');
              _message ='0';
              break;
            case '1':
              print('I am One');
              _message ='1';
              break;
            case '2':
              print('I am Two');
              _message ='2';
              break;
            case '3':
              print('I am Three');
              _message ='3';
              break;
            case '4':
              print('I am Four');
              _message ='4';
              break;
            case '5':
              print('I am Five');
              _message ='5';
              break;
            case '6':
              print('I am Six');
              _message ='6';
              break;
            case '7':
              print('I am Seven');
              _message ='7';
              break;
            case '8':
              print('I am Eight');
              _message ='8';
              break;
            case '9':
              print('I am Nine');
              _message ='9';
              break;
            default:
              print('I am Default');
              _message ='0';
              break;
          }
          buffer = buffer + _message;
        }
      });
    }
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s){
      if(s == AudioPlayerState.PLAYING) {
        print("Still Playing...");
      } else if(s == AudioPlayerState.STOPPED) {
        onComplete();
      }
    }, onError: (msg) {
      playerState = PlayerState.stopped;
    });
  }

  Future<ByteData> loadAsset(name) async {
    return await rootBundle.load('audio/$name');
  }

  Future loadFile(String name) async {
    final file = new File('${(await getTemporaryDirectory()).path}/$name');
    await file.writeAsBytes((await loadAsset(name)).buffer.asUint8List());
    print('Temp File Path: ${file.path}');

    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
  }


  Future play(String name) async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
    });
  }

  void onComplete() {
    setState((){
      playerState = PlayerState.stopped;
    });

    print("##### #### ### Ready to Play next audio");

    if(doneStatus == true) {
        // entries.insert(0, result);
        // entries.removeLast();
        loadFile(audioFile).then((_){
          play(audioFile);
          setState(() {
            // result = '';
            entries.insert(0, result);
            entries.removeLast();
          });
        });
        doneStatus = false;
        print("All audios are done.");
      }
  }

  void _playAudioNotifier(number) async {

    /// Check how many files will be called by digit
    /// 1. Get the number of digits from input values
    /// 2. Assign one digit and one time calling number to audio files
    /// 3. Assign two time calling number to audio files
    /// 4. Assign those numbers to audio player section, which decides how many tracks will be called.
    print('Files: #### $number.wav');

    if(!isPlaying) {
      loadFile(starterAudio).then((_){
        play(starterAudio);
        doneStatus = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    var ScreenHeight = MediaQuery.of(context).size.height;

    print('Screen Width: $ScreenWidth');
    print('Screen Height: $ScreenHeight');
    // double blockSize = ScreenWidth / 10;
    return Scaffold(
      // appBar: AppBar(title: Text('Order Notifier'),),
      body: Container(
        child: new Center(
          child: new Row(
            children: <Widget> [
              Expanded(
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFFCC00),
                            border: Border.all(width: 3.0, color: Colors.black87),
                          ),
                          child:  Center(
                            child: Text('Сая гарсан',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 0.0, color: Colors.black87),
                              top: BorderSide(width: 3.0, color: Colors.black87),
                              left: BorderSide(width: 0.0, color: Colors.black87),
                              bottom: BorderSide(width: 0.0, color: Colors.white),
                            ),
                          ),
                          child: Center(child: Text(result,
                            style: TextStyle(fontSize: 100,),),)
                        ),
                      ),
                      Expanded(
                        flex: 1,  /// text entry and submit section
                        child: Container(
                          child: RawKeyboardListener(
                            focusNode: _focusNode,
                            onKey: _handleKeyEvent,
                            child: AnimatedBuilder(
                              animation: _focusNode,
                              builder: (BuildContext context, Widget child) {
                                if(!_focusNode.hasFocus) {
                                  FocusScope.of(context).requestFocus(_focusNode);
                                }
                                return Container(
                                  child: Text(_message ?? ' ',
                                  style: TextStyle(color: Colors.white),),
                                ); ///new Text(_message ?? 'press key');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff5AC8FA),
                            border: Border.all(width: 3.0, color: Colors.black87)
                          ),
                          child:  Center(
                            child: Text('Гарсан',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 3.0, color: Colors.black87),
                              top: BorderSide(width: 3.0, color: Colors.black87),
                              left: BorderSide(width: 3.0, color: Colors.black87),
                              bottom: BorderSide(width: 3.0, color: Colors.black87),
                            ),
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: entries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 80,
                                // color: Colors.amber[colorCodes[index]],
                                child: Center(child: Text('${entries[index]}',
                                  style: TextStyle(fontSize: 80,
                                    color: Colors.blue[colorCodes[index]],
                                    fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
