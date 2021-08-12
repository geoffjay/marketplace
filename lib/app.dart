import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Text("test");
  }
}
