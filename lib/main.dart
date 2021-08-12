import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(Marketplace());

class Marketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Marketplace'),
    );
  }
}
