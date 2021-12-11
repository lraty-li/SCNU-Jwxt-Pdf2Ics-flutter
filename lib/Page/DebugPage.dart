import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ButonBuilder.dart';
import 'package:scnu_jwxt_pdf2ics/tools/GetLocalFilePath.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ShareFile.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ThemedPage.dart';

class DebugPage extends StatefulWidget {
  static const routeName = "DebugPage";

  const DebugPage({Key? key}) : super(key: key);

  @override
  _DebugPagePageState createState() => _DebugPagePageState();
}

class _DebugPagePageState extends State<DebugPage> {
  late final logFilePath;
  @override
  void initState() {
    super.initState();
    _loadLogText();
  }

  String _text = "Loading";

  Future<void> _loadLogText() async {
    var path = await getLocalPath();
    path = "$path/log.txt";
    logFilePath = path;
    String tempText = "";
    try {
      File file = File(path);
      final contents = await file.readAsBytes();

      // inspect(contents);

      //simply filt out control charater
      for (var i = 0; i < contents.length && i < 2000; i++) {
        if (contents[i] < 32 || contents[i] > 127) contents[i] = 32;
      }
      tempText = String.fromCharCodes(contents);
      //the log wont be redirect?
      // log(tempText);
    } catch (e) {
      // inspect(e);
      tempText = "**********  load failed  **********";
    }

    // var temp=[2,3];
    // print(temp[3]);

    setState(() {
      _text = tempText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
      body: ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade600,
                        border:
                            Border.all(color: Colors.grey.shade700, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                      child: Text(
                        _text,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade300),
                      ),
                    )),
                  ),
                )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: RoundButton(
                      onPressed: () async {
                        //send log file
                        await shareFile(context, logFilePath);
                      },
                      text: "分享日历文件",
                      textFontSize: 25,
                      icon: Icons.share,
                      iconSize: 30,
                    )),
              ],
            ),
          )),
    );
    return ThemedPage(
      home: _scaffold,
      routes: {},
    );
  }
}
