import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPref(Preferences key, int value) async {
  final _preferences = await SharedPreferences.getInstance();
  _preferences.setInt(preferenceKeyMap[key] ?? "noSuchKey", value);
  print("set $key to $value");
}
