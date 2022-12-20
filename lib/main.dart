import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

String nativeInfo = "";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///创建一个textfield controller
  final myController = TextEditingController();

  String textfiled = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  ///
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // Future<void> _getBatteryLevel(String info) async {
  //   String Info;
  //   try {
  //     final String result =
  //         await platform.invokeMethod('getBatteryLevel', {"data": info});
  //     Info = result;
  //   } on PlatformException catch (e) {
  //     Info = "Failed to get native info: '${e.message}'.";
  //   }
  //
  //   setState(() {
  //     nativeInfo = Info;
  //   });
  // }

  Future<void> getNativeInfo() async {
    String Info;
    try {
      final String result = await platform.invokeMethod('getNativeInfo');
      Info = result;
    } on PlatformException catch (e) {
      Info = "Failed to get native info: '${e.message}'.";
    }

    setState(() {
      //myController.text = Info;
      nativeInfo = Info;
    });
  }

  Future<void> returnFlutterInfo(String info) async {
    try {
      myController.text = "";
      await platform.invokeMethod('returnFlutterInfo', {"data": info});

    } on PlatformException catch (e) {}
  }

  Future<void> _jump() async {
    try {

        final String result = await platform.invokeMethod('openAct2');

    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    String _dataFromFlutter = "Android can ping you";


    return MaterialApp(routes: <String, WidgetBuilder>{
      '/first': (BuildContext context) {
        getNativeInfo();
                return Material(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Page 1'),
            ),
            body: Container(
                // padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                margin: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: nativeInfo,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              returnFlutterInfo(myController.text);
                              SystemNavigator.pop();
                            },
                            child: Text("Back")),
                        ElevatedButton(
                            onPressed: () {
                              returnFlutterInfo(myController.text);
                              _jump();
                              SystemNavigator.pop();
                            },
                            child: Text("Forward"))
                      ],
                    )
                  ],
                )),
          ),
        );
      },
      '/second': (BuildContext context) {
        getNativeInfo();
        return Material(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Page 2'),
            ),
            body: Container(
                // padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                margin: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          textfiled = myController.text;
                        });

                      },
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: nativeInfo,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        ElevatedButton(
                            onPressed: () {
                              returnFlutterInfo(textfiled);
                              SystemNavigator.pop();
                            },
                            child: Text("Back")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/third');
                            },
                            child: Text("Forward"))
                      ],
                    )
                  ],
                )),
          ),
        );
      },
      '/third': (BuildContext context) {
        getNativeInfo();
        return Material(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Page 3'),
            ),
            body: Container(
                // padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                margin: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          textfiled = myController.text;
                        });
                      },
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: nativeInfo,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Back"))
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    });
  }
}
