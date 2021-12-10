import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/tools/PreferenceSetter.dart';
import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';
import 'package:scnu_jwxt_pdf2ics/util/themeEnums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//主题工具类
class ThemeState extends ChangeNotifier {
  late List<String> themeStrs;
  late ThemeMode _themeMode;

  // 0 light
  // 1 dark
  // 2 material dark
  // 3 follow system
  // keep the order with [ThemeEnums]
  int _themeID;

  //this will storage witch dark mode data user use at last
  // the follow system's dark mode use it
  ThemeEnums _lastDarkMode = ThemeEnums.dark;

  void _setThemeModeByID() {
    ThemeEnums themeType = ThemeEnums.values[_themeID];

    switch (themeType) {
      case ThemeEnums.light:
        _themeMode = ThemeMode.light;
        break;
      case ThemeEnums.dark:
        _lastDarkMode = ThemeEnums.dark;
        _themeMode = ThemeMode.dark;
        break;
      case ThemeEnums.materialDark:
        _lastDarkMode = ThemeEnums.materialDark;
        _themeMode = ThemeMode.dark;
        break;
      case ThemeEnums.followSystem:
        _themeMode = ThemeMode.system;
        break;
    }
  }

  ThemeState(this._themeID) {
    _setThemeModeByID();
  }

  ThemeData _themeDataLight = ThemeData(
    brightness: Brightness.light,
  );
  ThemeData _themeDataMaterialDark = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(foregroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) return Colors.white60;
      return Colors.black;
    }), backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) return Color(0xFFD7B7FD);
      return Color(0xFFBB86FC);
    }))),
    brightness: Brightness.dark,
  );

  ThemeData _themeDataDark = ThemeData(
// MaterialStateProperty.all<Color>(Colors.blueGrey.shade600)

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(foregroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) return Colors.white60;
      return Colors.white;
    }), backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled))
        return Colors.blueGrey.shade800;
      return Colors.blueGrey.shade600;
    }))),
    brightness: Brightness.dark,
  );

  void loadLocalization(BuildContext context) {
    // all theme strings
    // keep the order with [ThemeEnums]
    themeStrs = [
      AppLocalizations.of(context)!.themeLight,
      AppLocalizations.of(context)!.themeDark,
      AppLocalizations.of(context)!.themeMaterialDark,
      AppLocalizations.of(context)!.themeFollowSystem,
    ];
  }

  void changeThemeData(String choosenThemeStr) {
    _themeID = themeStrs.indexOf(choosenThemeStr);

    _setThemeModeByID();
    setPref(Preferences.themeID, _themeID);

    notifyListeners();
  }

  // int get colorMode => _themeID; //获取颜色索引
  ThemeMode get themeMode => _themeMode; //获取模式索引
  ThemeData get themeDataLight => _themeDataLight;

  ThemeData get themeDataDark {
    if (_lastDarkMode == ThemeEnums.materialDark) return _themeDataMaterialDark;
    return _themeDataDark;
  }

  ThemeData getcurrThemeData(BuildContext context) {
    ThemeEnums themeType = ThemeEnums.values[_themeID];
    switch (themeType) {
      case ThemeEnums.light:
        return _themeDataLight;
      case ThemeEnums.dark:
        return _themeDataDark;
      case ThemeEnums.materialDark:
        return _themeDataMaterialDark;
      case ThemeEnums.followSystem:
        {
          var brightness = MediaQuery.of(context).platformBrightness;
          print(brightness);
          if (brightness == Brightness.dark) {
            if (_lastDarkMode == ThemeEnums.materialDark)
              return _themeDataMaterialDark;
            return _themeDataDark;
          } else {
            return _themeDataLight;
          }
        }
    }
  }
}
