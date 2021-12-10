// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/util/ThemeState.dart';
import 'package:provider/provider.dart';

class ThemedPage extends StatelessWidget {
  const ThemedPage({Key? key, required this.home, required this.routes})
      : super(key: key);
  final Widget home;
  final Map<String, Widget Function(BuildContext)> routes;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, themeState, child) => MaterialApp(
        //显示语义
        // showSemanticsDebugger: true,
        home: home,
        theme: themeState.themeDataLight,
        darkTheme: themeState.themeDataDark,
        themeMode: themeState.themeMode,
        routes: routes,
      ),
    );
  }
}
