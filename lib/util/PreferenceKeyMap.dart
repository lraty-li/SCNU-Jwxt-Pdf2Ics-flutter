// all Preferences key will load and write

enum Preferences {
  languageID,
  themeID,
  campusId,
  ifAlarmOn,
  alarmMinutes,
  icalEventTitleType,
  currentTeachingWeek
}

Map<Preferences, String> preferenceKeyMap = {
  Preferences.languageID: "langID",
  Preferences.themeID: "themeID",
  Preferences.campusId: "campusId",
  Preferences.ifAlarmOn: "ifAlarm",
  Preferences.alarmMinutes:"alarMinutes",
  Preferences.icalEventTitleType: "icalTitleType",
  Preferences.currentTeachingWeek: "currentTeachingWeek"
};
