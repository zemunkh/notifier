import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


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


Future<Null> _playAudioNotifier(number) async {

  AssetsAudioPlayer _assetsAudioPlayer;

  _assetsAudioPlayer = AssetsAudioPlayer();

  final List<String> orders = [];
  print('Passed value: $number');

  _assetsAudioPlayer.open(
    AssetsAudio(
      asset: "oneone.mp3",
      folder: "assets/audio/",
    ),
  );
  _assetsAudioPlayer.play();
}