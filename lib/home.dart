import 'package:flutter/material.dart';

import 'app.dart';
import 'graphql/read_apps.dart';
import 'style.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _buildApp(App app) {
    return ListTile(
        title: Text(
      app.title,
      style: Style.LargeFont,
    ));
  }

  Widget _buildApps() {
    return FutureBuilder(
      builder: (context, appSnapshot) {
        if (appSnapshot.connectionState == ConnectionState.none ||
            appSnapshot.data == null) {
          return Container();
        }

        Iterable<AppModel>? data = appSnapshot.data as Iterable<AppModel>;
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            App app = App(title: data.toList()[index].name);
            return _buildApp(app);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
      future: readApps(),
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
