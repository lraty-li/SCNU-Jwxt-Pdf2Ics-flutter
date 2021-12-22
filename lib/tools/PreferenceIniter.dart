import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceIniter
// load all user preference and store in initDataMap
{
  static late final Map<Preferences, int> initDataMap;

  static Future loadAllPref() async {
    Map<Preferences, int> tempMap = {};
    final _preferences = await SharedPreferences.getInstance();
    for (var i = 0; i < Preferences.values.length; i++) {
      tempMap[Preferences.values[i]] = _preferences
              .getInt(preferenceKeyMap[Preferences.values[i]] ?? "noSuchKey") ??
          0;
    }
    initDataMap = tempMap;
  }
}
