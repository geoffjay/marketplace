import 'package:flutter/material.dart';

import 'app.dart';
import 'style.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _apps = <App>[];

  Widget _buildApp(App app) {
    return ListTile(
        title: Text(
          app.title,
          style: Style.LargeFont,
        )
    );
  }

  Widget _buildApps() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final index = i ~/ 2;
        if (index >= _apps.length) {
          _apps.addAll([App(title: "foo"), App(title: "bar")]);
        }

        return _buildApp(_apps[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildApps(),
    );
  }
}
