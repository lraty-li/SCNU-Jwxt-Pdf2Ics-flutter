import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:scnu_jwxt_pdf2ics/tools/LocalizationApp.dart';
import 'package:scnu_jwxt_pdf2ics/tools/PreferenceIniter.dart';
import 'package:scnu_jwxt_pdf2ics/util/ConvertingConfigurationData.dart';
import 'package:provider/provider.dart';
import 'package:scnu_jwxt_pdf2ics/util/LocalizationState.dart';
import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';

// import 'Page/SettingPage.dart';
// import 'Page/ConvertingConfiguration.dart';

import 'util/ThemeState.dart';

//custom git package , check pubspec
import 'package:native_dup2/native_dup2.dart';
import 'package:ffi/src/utf8.dart';

//TODO 接受外部intent

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      //强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

//********************************************************** */
// this will redirect all console output to log.txt
  // var path = await getLocalPath();
  // path = "$path/log.txt";
  // // 3 is the file descriptor of android std output?
  // int result = nativeRunDup2(path.toNativeUtf8(), 3);

  // if (result < 0) {
  //   print("fail to runDup2");
  //   print(result);
  // }
//********************************************************** */

  //load all user data
  PreferenceIniter.loadAllPref().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWrapper(child: LocalizationApp());
  }
}

class ProviderWrapper extends StatelessWidget {
  final Widget child;
  ProviderWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    //TODO doc 提示 初次编译 下载ndk 耗时
    //TODO 使用单一来源控制样式
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => LocalizationState(
              PreferenceIniter.initDataMap[Preferences.languageID] ?? 0),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeState(
              PreferenceIniter.initDataMap[Preferences.themeID] ?? 0),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ConvertingConfigurationDataState(),
        ),
      ],
      child: child,
    );
  }
}
