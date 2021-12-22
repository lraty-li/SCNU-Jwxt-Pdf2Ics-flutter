import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scnu_jwxt_pdf2ics/tools/PreferenceSetter.dart';

//主题工具类
class LocalizationState extends ChangeNotifier {
  LocalizationState(int initLangID) {
    //read preference?
    _langID = initLangID;
  }

  //follow order in  supportedLocales of LocalizationApp
  // its generate automatically , no need to config it

  //for now
  // 0 en
  // 1 zh
  // 2 zh_Hant
  // 3 zh_Hant_HK
  // 4 zh_Hant_TW
  late int _langID;
  late Locale _locale;
  late List<Locale> supportedLocals;
//TODO 初始化为系统语言
  Future loadLangPref() async {
    final _preferences = await SharedPreferences.getInstance();
    _langID = (_preferences.getInt('langID') ?? 0);
  }

  void setLocalById() {
    _locale = supportedLocals[_langID];
  }

  void _setIdByLocal(Locale locale) {
    for (var i = 0; i < supportedLocals.length; i++) {
      //search language index and set it as langID
      if (supportedLocals[i].toString() == locale.toString()) {
        _langID = i;
        return;
      }
    }
  }

  void changeLocale(Locale newLocale) {
    _locale = newLocale;
    _setIdByLocal(newLocale);
    setPref(Preferences.languageID, _langID);
    notifyListeners();
  }

  Locale get local => _locale;
}
