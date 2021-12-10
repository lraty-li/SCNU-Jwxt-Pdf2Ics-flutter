import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:scnu_jwxt_pdf2ics/tools/PreferenceIniter.dart';
import 'package:scnu_jwxt_pdf2ics/tools/PreferenceSetter.dart';
import 'package:scnu_jwxt_pdf2ics/util/PreferenceKeyMap.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'confgEnums.dart';

/// campusId  校区ID
/// alarMinutes 提前多少分钟提醒
/// icalTitleType 日历事件标题类型
/// currentTeachingWeek 当前教学周
class ConvertingConfigurationDataState extends ChangeNotifier {
  ConvertingConfigurationDataState() {
    _loadPreference();
  }

  ///校区ID
  //0 石牌
  //1 大学城
  //2 南海
  //3 汕头
   int _campusId = 1; //校区
   campusIdEnum campus = campusIdEnum.ShiPai;
   late List<String> campusStrs;

   bool ifAlarm = false;
   int alarMinutes = 0; //提前多少分钟提醒

  //  0 课程名
  //  1 课程名+地点
  //  2 课程名+教师名称
  //  3 课程名+地点+教师名称
   int icalTitleTypeId = 0; //日历事件标题类型
   icalTitleTypeEnum icalTitleType = icalTitleTypeEnum.CourseTitle;
   late List<String> icalTitleTypeStrs;

   int currentTeachingWeek = 0; //当前教学周
  ConvertingConfigurationData() {
    //keep the order
  }

   void loadLocalization(BuildContext context) {
    //保持顺序
    campusStrs = [
      AppLocalizations.of(context)!.shiPai,
      AppLocalizations.of(context)!.daXueCheng,
      AppLocalizations.of(context)!.nanHai,
      AppLocalizations.of(context)!.shanWei
    ];
    icalTitleTypeStrs = [
      AppLocalizations.of(context)!.icalEventTitleType0,
      AppLocalizations.of(context)!.icalEventTitleType1,
      AppLocalizations.of(context)!.icalEventTitleType2,
      AppLocalizations.of(context)!.icalEventTitleType3
    ];
  }

//读取用户配置
   _loadPreference() {
    _campusId = PreferenceIniter.initDataMap[Preferences.campusId] ?? 0;
    ifAlarm = (PreferenceIniter.initDataMap[Preferences.ifAlarmOn] ?? 0) == 1
        ? true
        : false;
    alarMinutes = PreferenceIniter.initDataMap[Preferences.alarmMinutes] ?? 0;
    icalTitleTypeId =
        PreferenceIniter.initDataMap[Preferences.icalEventTitleType] ?? 0;
    icalTitleType = icalTitleTypeEnum.values[icalTitleTypeId];

    currentTeachingWeek =
        PreferenceIniter.initDataMap[Preferences.currentTeachingWeek] ?? 0;

    // ifAlarm = ((_preferences.getInt('ifAlarm') ?? 0) == 1 ? true : false);
    // alarMinutes = (_preferences.getInt('alarMinutes') ?? 0);
    // icalTitleTypeId = (_preferences.getInt('icalTitleType') ?? 0);
    // icalTitleType = icalTitleTypeEnum.values[icalTitleTypeId];
    // currentTeachingWeek = (_preferences.getInt('currentTeachingWeek') ?? 0);
  }

  // 根据widget类型 返回数据
   String getToDrowDownValue(drowDownChooserWidgeTypeEnum widgetType) {
    switch (widgetType) {
      case drowDownChooserWidgeTypeEnum.campus:
        return _getCampusStr();

      case drowDownChooserWidgeTypeEnum.icalTitleType:
        return _geticalTitleType();
    }
  }

  // 根据下拉菜单选中返回值，设置对应选项
   void setByDrowDownValue(
      drowDownChooserWidgeTypeEnum widgetType, String newValue) {
    switch (widgetType) {
      case drowDownChooserWidgeTypeEnum.campus:
        {
          _setCampus(newValue);
          return;
        }

      case drowDownChooserWidgeTypeEnum.icalTitleType:
        {
          _seticalTitleType(newValue);
          return;
        }
    }
  }

   String _getCampusStr() {
    return campusStrs[_campusId];
  }

   void _setCampus(String value) {
    _campusId = campusStrs.indexOf(value);
    setPref(Preferences.campusId, _campusId);
  }

   String _geticalTitleType() {
    return icalTitleTypeStrs[icalTitleTypeId];
  }

   void _seticalTitleType(String value) {
    icalTitleTypeId = icalTitleTypeStrs.indexOf(value);
    icalTitleType = icalTitleTypeEnum.values[icalTitleTypeId];
    setPref(Preferences.icalEventTitleType, icalTitleTypeId);
  }

   void setAlarMinutes(int minutes) {
    alarMinutes = minutes;
    setPref(Preferences.alarmMinutes, minutes);
  }

   void setCurrentTeachingWeek(int week) {
    currentTeachingWeek = week;
    setPref(Preferences.currentTeachingWeek, week);
  }

   void setIfAlarm(bool alarmSwitch) {
    ifAlarm = alarmSwitch;
    setPref(Preferences.ifAlarmOn, ifAlarm ? 1 : 0);
  }
}
