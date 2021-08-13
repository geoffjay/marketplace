import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    required this.title,
    required this.openContainer,
  });

  final String title;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return _InkWellOverlay(
      openContainer: openContainer,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black38,
              child: Center(
                child: Image.asset(
                  'assets/app_placeholder.png',
                  width: 100,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text('Dippity dorp'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Text('Dippity dip dip dorp.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black54,
                      inherit: false,
                    )),
          )
        ],
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.width,
    this.height,
    required this.openContainer,
    required this.child,
  });

  final double? width;
  final double? height;
  final VoidCallback openContainer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
