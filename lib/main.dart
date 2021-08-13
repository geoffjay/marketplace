import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:marketplace/pages/home.dart';

void main() => runApp(Marketplace());

class Marketplace extends StatelessWidget {
  final theme = ThemeData(
    primarySwatch: Colors.blueGrey,
  );

  Widget _buildWeb(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      theme: theme,
      home: Home(title: 'Marketplace'),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      theme: theme,
      home: Home(title: 'Marketplace'),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      theme: theme,
      home: Home(title: 'Marketplace'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWeb(context);
    } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return _buildDesktop(context);
    } else {
      return _buildMobile(context);
    }
  }
}
