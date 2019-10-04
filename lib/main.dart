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
  
  List<String> entries = <String>['1', '2', '3', '4', '5', '6'];
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
    String firstAudio;
    String secondAudio;
    var digit;
    
    digit = number.toString();

    // for(int i=0; i<number.length; i++){
    //   digit.add(number[i]);
    //   print(' ###  Number in Digits: $digit');
    // }
    // var demo = number.toString();
    // digit = digit[1];
    print('RESULT: $digit');

    switch (digit[1]) {
      case '0':
        if(digit[0] == '1') {
          firstAudio = 'ten.m4a';
        } else if (digit[0] == '2') {
          firstAudio = 'twenty.m4a';
        } else if (digit[0] == '3') {
          firstAudio = 'thirty.m4a';
        }
        break;     
      case '1':
        firstAudio = 'one.m4a';
        break;
      case '2':
        firstAudio = 'two.m4a';
        break;
      case '3':
        firstAudio = 'three.m4a';
        break;
      case '4':
        firstAudio = 'four.m4a';
        break;
      case '5':
        firstAudio = 'five.m4a';
        break;
      case '6':
        firstAudio = 'six.m4a';
        break;     
      case '7':
        firstAudio = 'seven.m4a';
        break;     
      case '8':
        firstAudio = 'eight.m4a';
        break;   
      case '9':
        firstAudio = 'nine.m4a';
        break;           
      default:
        firstAudio = 'one.m4a';
    }
    switch (digit[0]) {
      case '1':
        secondAudio = 'tenMore.m4a';
        break;
      case '2':
        secondAudio = 'twentyMore.m4a';
        break;
      case '3':
        secondAudio = 'thirtyMore.m4a';
        break;
      case '4':
        secondAudio = 'tenMore.m4a';
        break;
      case '5':
        secondAudio = 'tenMore.m4a';
        break; 
      case '6':
        secondAudio = 'tenMore.m4a';
        break; 
      case '7':
        secondAudio = 'tenMore.m4a';
        break; 
      case '8':
        secondAudio = 'tenMore.m4a';
        break; 
      case '9':
        secondAudio = 'tenMore.m4a';
        break;      
      default:
        secondAudio = '';
    }

    audioTools
      .loadFile(secondAudio)
      .then( (_) {
        audioTools.playAudioLoop(secondAudio);
        
          audioTools.loadFile(firstAudio);
         //play music callback
          entries.insert(0, result);
          entries.removeLast();

      }); 
    
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
                        child: Center(child: Text(result,
                          style: TextStyle(fontSize: 100.0,),),)
                      ),
                      Expanded(
                        flex: 1,  /// text entry and submit section
                        child: new TextField(
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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




