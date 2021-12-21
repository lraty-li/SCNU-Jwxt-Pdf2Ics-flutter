import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:scnu_jwxt_pdf2ics/util/ConvertingConfigurationData.dart';
import 'package:scnu_jwxt_pdf2ics/util/confgEnums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//ics文件设置
class ConvertingConfiguration extends StatefulWidget {
  static const routeName = "ConvertingConfiguration ";
  late final BuildContext upperContext;
  // ConvertingConfiguration({Key? key,required upperContext}) : super(key: key);

  //让AppLocalizations.of获得有本地化委托的context
  ConvertingConfiguration({required parentContext}) {
    upperContext = parentContext;
  }
  @override
  _ConvertingConfigurationState createState() =>
      _ConvertingConfigurationState(upperContext);
}

class _ConvertingConfigurationState extends State<ConvertingConfiguration> {
  late bool _ifAlarm;
  late final upperContext;

  late TextEditingController _textFieldControllerAlarMinutes;
  late TextEditingController _textFieldControllerCurrentTeachingWeek;

  _ConvertingConfigurationState(this.upperContext);
  @override
  void initState() {
    super.initState();

    //TODO 检查多余调用 load locale
    final convertingConfigurationDataState =
        context.read<ConvertingConfigurationDataState>();

    _ifAlarm = convertingConfigurationDataState.ifAlarm;

    //绑定变化监听，合法变化就设置用户配置
    _textFieldControllerAlarMinutes = TextEditingController(text: "0");
    _textFieldControllerAlarMinutes.addListener(() {
      if (_textFieldControllerAlarMinutes.text != "")
        convertingConfigurationDataState
            .setAlarMinutes(int.parse(_textFieldControllerAlarMinutes.text));
    });
    _textFieldControllerCurrentTeachingWeek = TextEditingController(text: "0");
    _textFieldControllerCurrentTeachingWeek.addListener(() {
      if (_textFieldControllerCurrentTeachingWeek.text != "")
        convertingConfigurationDataState.setCurrentTeachingWeek(
            int.parse(_textFieldControllerCurrentTeachingWeek.text));
    });
  }

  @override
  void dispose() {
    _textFieldControllerAlarMinutes.dispose();
    _textFieldControllerCurrentTeachingWeek.dispose();
    super.dispose();
  }

  //TODO 焦点 bug，复现：输入数字同时点击下拉选单
  /// 构建下拉选单
  /// 参数：
  ///    title 选单左侧文字
  ///    itemList 选单选项
  ///    widgetType 将要构建的类型(选择校区/日历标题格式)
  Widget _buildDrowDownChooser(
      String title,
      List<String> itemList,
      drowDownChooserWidgeTypeEnum widgetType,
      ConvertingConfigurationDataState dataState) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          DropdownButton<String>(
            value: dataState.getToDrowDownValue(widgetType),
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            // style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 1,
              color: Colors.blueGrey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dataState.setByDrowDownValue(widgetType, newValue!);
              });
            },
            items: itemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, overflow: TextOverflow.fade),
              );
            }).toList(),
          )
        ]);
  }

/*
  构建一个仅允许数字输入的输入框
  参数:
  title 选单左侧文字
  inputFormatterMax 可输入最大值
  limitHintText 提示可输入最大值
  controller 输入域控制器，用于绑定监听事件
  返回:
  输入框
*/
  Widget _buildTextField(String title, int inputFormatterMax,
      String limitHintText, TextEditingController controller) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200, 100)),
              //TODO:不友好的反馈,没有超出限制提醒,只是阻挡输入
              child: TextField(
                autofocus: false,
                inputFormatters: [
                  NumericalRangeFormatter(max: inputFormatterMax)
                ],
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '$limitHintText',
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final convertConfigDataState =
        context.read<ConvertingConfigurationDataState>();

    _textFieldControllerAlarMinutes.text =
        convertConfigDataState.alarMinutes.toString();
    _textFieldControllerCurrentTeachingWeek.text =
        convertConfigDataState.currentTeachingWeek.toString();

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDrowDownChooser(
                AppLocalizations.of(upperContext)!.choosingCampus,
                convertConfigDataState.campusStrs,
                drowDownChooserWidgeTypeEnum.campus,
                convertConfigDataState),
            _buildDrowDownChooser(
                AppLocalizations.of(upperContext)!.icalEventTitleType,
                convertConfigDataState.icalTitleTypeStrs,
                drowDownChooserWidgeTypeEnum.icalTitleType,
                convertConfigDataState),
            Row(
              mainAxisSize: MainAxisSize.min,
              //TODO 转换时禁用switch
              //TODO AnimatedList elegant push down
              children: [
                Text(AppLocalizations.of(upperContext)!.ifAlarm),
                Switch(
                    value: _ifAlarm,
                    onChanged: (value) {
                      _ifAlarm = value;
                      convertConfigDataState.setIfAlarm(_ifAlarm);
                      setState(() {});
                    }),
              ],
            ),
            if (_ifAlarm)
              _buildTextField(
                  AppLocalizations.of(upperContext)!.alarmMinutes,
                  150,
                  AppLocalizations.of(upperContext)!.numRangeLimit(
                      0, 150, AppLocalizations.of(upperContext)!.minutes),
                  _textFieldControllerAlarMinutes),
            _buildTextField(
                AppLocalizations.of(upperContext)!.currTeachingWeek,
                25,
                AppLocalizations.of(upperContext)!.numRangeLimit(
                    0, 25, AppLocalizations.of(upperContext)!.week),
                _textFieldControllerCurrentTeachingWeek),
          ],
        ),
      ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  //自定义过滤器
  final int max;

  NumericalRangeFormatter({required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    }

    try {
      int.parse(newValue.text);
    } catch (e) {
      return oldValue;
    }
    int newValueInt = int.parse(newValue.text);
    if (newValueInt > max) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
