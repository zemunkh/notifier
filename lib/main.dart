import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notifier/utils.dart';
import 'package:notifier/numberLogic.dart';


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
    /// Check how many files will be called by digit
    /// 1. Get the number of digits from input values
    /// 2. Assign one digit and one time calling number to audio files
    /// 3. Assign two time calling number to audio files
    /// 4. Assign those numbers to audio player section, which decides how many tracks will be called.
    List<String> audioFiles = <String>[]; 
    audioFiles = numberLogic(number);
    print('Files: #### $audioFiles');

    if(audioFiles.length == 1) {
      audioTools.loadFile(audioFiles[0], null).then( (_) {
        audioTools.playAudioLoop(audioFiles[0], null);
        audioTools.loadFile(audioFiles[0], null);
        //play music callback
        entries.insert(0, result);
        entries.removeLast();
      }); 
    } else if (audioFiles.length == 2) {
      print("##########  Two Files #######");
    }



        // print('### Audio file = $secondAudio');
        // audioTools.loadFile(firstAudio, secondAudio).then( (_) {
        //   audioTools.playAudioLoop(firstAudio, secondAudio);

        //   entries.insert(0, result);
        //   entries.removeLast();
        // });

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




