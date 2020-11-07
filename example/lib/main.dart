import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magic_button/magic_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class LoginButtonStyle extends ButtonMagic {}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var Mmagic = LoginButtonStyle();
  final StreamController<ButtonMagic> _streamController =
      StreamController<ButtonMagic>.broadcast(onListen: () {
    print("object");
  });

  void _incrementCounter() {
    setState(() {
      _counter++;
      Mmagic.isEnable = _counter % 2 == 0 ? true : false;
      Mmagic.isActiviting = false;
      _streamController.sink.add(Mmagic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getButton(),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getButton() {
    return MagicButton(
      title: '登录',
      stream: _streamController.stream,
      enable: TextStyle(color: Colors.white),
      disable: TextStyle(color: Colors.grey),
      action: () => btnClick(context),
    );
  }

  btnClick(BuildContext context) {
    Mmagic.isActiviting = true;
    _streamController.sink.add(Mmagic);
    print("按钮点击");
  }
}
