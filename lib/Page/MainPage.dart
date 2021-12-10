import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scnu_jwxt_pdf2ics/Page/DebugPage.dart';
import 'package:scnu_jwxt_pdf2ics/Page/PdfLoadedPage.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ButonBuilder.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ModalBottomSheet.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ThemedPage.dart';
import 'package:scnu_jwxt_pdf2ics/util/ConvertingConfigurationData.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:scnu_jwxt_pdf2ics/util/LocalizationState.dart';
import 'package:scnu_jwxt_pdf2ics/util/ThemeState.dart';

import '../ExpandableFab.dart';

@immutable
class MainPage extends StatelessWidget {
  static const routeName = "MainPage";
  const MainPage({Key? key}) : super(key: key);

  void _pushRoute(BuildContext context, String routeName) {
    // showDialog<void>(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text("Hi"),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: const Text('CLOSE'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    Navigator.pushNamed(context, routeName);
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    if (result != null) {
      var _path = result.files.single.path;
      print("path is $_path");
      //pdf 路径放入路由参数
      //TODO 为了routeName 引入整个库？
      Navigator.pushNamed(context, PdfLoadedPage.routeName, arguments: _path);
    } else {
      // chose fail or do nothing?
      //todo
    }
  }

  @override
  Widget build(BuildContext context) {
    //读取本地化
    final convertingConfigurationDataState =
        context.read<ConvertingConfigurationDataState>();
    convertingConfigurationDataState.loadLocalization(context);

    final themeState = context.read<ThemeState>();
    themeState.loadLocalization(context);

    const double _iconSize = 40;

    var _scaffold = Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo，去除语义
              ExcludeSemantics(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        fit: BoxFit.contain,
                        height: 150,
                        image: AssetImage('images/PDF.png')),
                    Icon(Icons.east, size: 50),
                    Image(
                        fit: BoxFit.contain,
                        width: 150,
                        image: AssetImage('images/ICAL.png')),
                  ],
                ),
              ),
              // padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: RoundButton(
                  onPressed: () => {_pickFile(context)},
                  text: AppLocalizations.of(context)!.start,
                  textFontSize: 25,
                  icon: Icons.folder_open,
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Semantics(
          value: "菜单按钮",
          child: ExpandableFab(
            //最大弹出元素高度
            distance: 400.0,
            children: [
              ActionButton(
                onPressed: () {
                  //TODO 取消用户数据静态类？
                  final localizationState = context.read<LocalizationState>();

                  List<ListTile> listListTiles = [];
                  var appSupportedLocales = AppLocalizations.supportedLocales;
                  appSupportedLocales.forEach((element) {
                    //收集 语言描述
                    AppLocalizations.delegate
                        .load(element)
                        .then((value) => listListTiles.add(ListTile(
                              title: Text(value.langSelfDescr),
                              onTap: () {
                                localizationState.changeLocale(element);
                              },
                            )));
                  });

                  popModalBottomSheet(context, listListTiles);
                },
                icon: Icons.g_translate,
                iconSize: _iconSize,
                text: "语言",
              ),
              ActionButton(
                onPressed: () {
                  var themeState = context.read<ThemeState>();
                  List<ListTile> listListTiles = [];

                  themeState.themeStrs
                      .forEach((element) => listListTiles.add(ListTile(
                            title: Text(element),
                            onTap: () {
                              themeState.changeThemeData(element);
                            },
                          )));

                  popModalBottomSheet(context, listListTiles);
                },
                icon: Icons.dark_mode,
                iconSize: _iconSize,
                text: AppLocalizations.of(context)!.theme,
              ),
              ActionButton(
                onPressed: () => _pushRoute(context, DebugPage.routeName),
                icon: Icons.code,
                iconSize: _iconSize,
                text: "调试",
              ),
              ActionButton(
                onPressed: () => _pushRoute(context, DebugPage.routeName),
                icon: Icons.qr_code,
                iconSize: _iconSize,
                text: "扫码上传",
              ),
              ActionButton(
                onPressed: () => _pushRoute(context, DebugPage.routeName),
                icon: Icons.info,
                iconSize: _iconSize,
                text: "关于",
              ),
            ],
          ),
        ));

    return ThemedPage(home: _scaffold, routes: {});
  }
}