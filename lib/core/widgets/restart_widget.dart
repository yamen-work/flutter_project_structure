import 'package:flutter/material.dart';

import '../../main.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({super.key, required this.child});

  late Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? selectedLanguage = prefs.getString('localization');
    setState(() {
      key = UniqueKey();
      widget.child = MyApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}