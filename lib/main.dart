import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:notifier/utils.dart';


var audioTools = LocalAudioTools();


void main() => runApp(new MyApp());

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
  
  final List<String> entries = <String>[];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];

  final TextEditingController _myController = TextEditingController();

  String result = "";

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  void _playAudioNotifier(number) async {
    // final url = 'https://incompetech.com/music/royalty-free/mp3-royaltyfree/Surf%20Shimmy.mp3';
    // final url = 'file:///assets/audio/oneone.mp3';
    // FlutterSound flutterSound = FlutterSound();
    String audioName;
    switch (number) {
      case '1':
        audioName = 'one.m4a';
        break;
      case '2':
        audioName = 'two.m4a';
        break;
      case '3':
        audioName = 'three.m4a';
        break;
      case '4':
        audioName = 'four.m4a';
        break;
      case '5':
        audioName = 'five.m4a';
        break;      
      default:
        audioName = 'one.m4a';
    }
    audioTools
      .loadFile(audioName)
      .then((_) => audioTools.playAudioLoop(audioName));
    audioTools.loadFile(audioName);
  }


  @override
  Widget build(BuildContext context) {
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
                        child: Center(
                          child: Text('Order is ready'),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Center(child: Text(result),)
                      ),
                      Expanded(
                        flex: 1,  /// text entry and submit section
                        child: new TextField(
                          decoration: new InputDecoration(
                            hintText: "Type here",
                            fillColor: Colors.white,
                          ),
                          controller: _myController,
                          onSubmitted: (String str){
                            setState((){
                              result = str;
                              // entries.add(result); play music callback
                              _playAudioNotifier(result);
                              _myController.clear();
                            });
                          }
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
                        child: Center(
                          child: Text('Taken Order'),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 30,
                              color: Colors.amber[colorCodes[index]],
                              child: Center(child: Text('Entry ${entries[index]}')),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
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




