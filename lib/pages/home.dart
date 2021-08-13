import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:marketplace/components/app.dart';
import 'package:marketplace/graphql/read_apps.dart';
import 'package:marketplace/models/app.dart';
import 'package:marketplace/pages/details.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  Widget _buildList() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          return Container();
        }

        Iterable<AppModel>? data = snapshot.data as Iterable<AppModel>;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                var app = App(
                  title: data.toList()[index].name,
                  openContainer: openContainer,
                );
                return app;
              },
            );
          },
        );
      },
      future: readApps(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String platform;

    if (kIsWeb) {
      platform = "web";
    } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      platform = "desktop";
    } else {
      platform = "mobile";
    }

    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (context) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title),
                  const SizedBox(height: 2),
                  Text(
                    platform,
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.black54,
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            body: _buildList(),
          ),
        );
      },
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: closedBuilder,
      openBuilder: (context, openContainer) => const DetailsPage(),
      tappable: false,
      transitionType: transitionType,
    );
  }
}
