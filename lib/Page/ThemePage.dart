import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ThemedPage.dart';
import 'package:scnu_jwxt_pdf2ics/util/ThemeState.dart';
import 'package:scnu_jwxt_pdf2ics/util/themeEnums.dart';

//** Deprecated Page */

class ThemePage extends StatefulWidget {
  static const routeName = "ThemePage";
  const ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  //TODO 遵循material 深色
  @override
  Widget build(BuildContext context) {
    Widget _scaffold = Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("主题与夜间模式"),

          // titleTextStyle:TextStyle(fontSize: 30)
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // var themeData = context.read<ThemeState>();
                  // themeData.changeThemeData(ThemeEnums.dark);
                },
                child: Text("Switch dark")),
            ElevatedButton(
                onPressed: () {
                  // var themeData = context.read<ThemeState>();
                  // themeData.changeThemeData(ThemeEnums.materialDark);
                },
                child: Text("Switch material dark")),
            ElevatedButton(
                onPressed: () {
                  // var themeData = context.read<ThemeState>();
                  // themeData.changeThemeData(ThemeEnums.light);
                },
                child: Text("Switch light")),
            ElevatedButton(
                onPressed: () {
                //   var themeData = context.read<ThemeState>();
                //   themeData.changeThemeData(ThemeEnums.followSystem);
                },
                child: Text("follow System")),
          ],
        ));
    return ThemedPage(
      home: _scaffold,
      routes: {},
    );
  }
}
