import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/src/provider.dart';
import 'package:scnu_jwxt_pdf2ics/util/ThemeState.dart';
import 'package:url_launcher/url_launcher.dart';

ShowLicense(BuildContext Uppercontext, ThemeData themeData) {
  final themeState = Uppercontext.read<ThemeState>();
  ThemeData themeData = themeState.getcurrThemeData(Uppercontext);
  TapGestureRecognizer _projUrl = TapGestureRecognizer();
  showDialog(
      context: Uppercontext,
      builder: (_) => Theme(
          data: themeData,
          child: AlertDialog(
            title: Text(AppLocalizations.of(Uppercontext)!.about),
            content: SingleChildScrollView(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${AppLocalizations.of(Uppercontext)!.projLocation}\n\n\n",
                    style: TextStyle(color: Colors.blue),
                    recognizer: _projUrl
                      ..onTap = () {
                        launch("https://github.com/lraty-li/SCNU-Jwxt-Pdf2Ics-flutter");
                        print("hi");
                      }),
                TextSpan(
                    text:
                        """This product includes software developed at The Apache Software Foundation (http://www.apache.org/).
\nincludes \n PdfBox-Android Apache2.0 license \n(https://github.com/TomRoush/PdfBox-Android)  

\nModify and directly use code from flutter-pdf-text MIT license \n(https://github.com/AlessioLuciani/flutter-pdf-text)""")
              ])),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(Uppercontext)!.showLicense),
                onPressed: () {
                  Navigator.of(Uppercontext).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext _) {
                        return Theme(
                            data: themeData,
                            child: LicensePage(
                                applicationName: "SCNU_Jwxt_Pdf2Ics",
                                applicationIcon: Icon(
                                  Icons.transform,
                                )));
                      },
                    ),
                  );
                }, //关闭对话框
              ),
              TextButton(
                child: Text(AppLocalizations.of(Uppercontext)!.close),
                onPressed: () {
                  // ... 执行删除操作
                  Navigator.of(Uppercontext).pop(true); //关闭对话框
                },
              ),
            ],
          )));
}
