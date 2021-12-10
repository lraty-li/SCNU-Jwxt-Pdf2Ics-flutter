import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:scnu_jwxt_pdf2ics/util/ConvertingConfigurationData.dart';
import 'package:scnu_jwxt_pdf2ics/util/confgEnums.dart';

// //ics文件设置
class ConvertingConstruction extends StatefulWidget {
  const ConvertingConstruction({Key? key}) : super(key: key);
  static const routeName = "ConvertingConfiguration ";
  @override
  _ConvertingConstructionState createState() => _ConvertingConstructionState();
}

class _ConvertingConstructionState extends State<ConvertingConstruction> {
  late bool _ifAlarm;

  late TextEditingController _textFieldControllerAlarMinutes;
  late TextEditingController _textFieldControllerCurrentTeachingWeek;
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
  Widget _buildDrowDownChooser(String title, List<String> itemList,
      drowDownChooserWidgeTypeEnum widgetType) {
    //TODO 优化，在类中存储？
    final convertingConfigurationDataState =
        context.read<ConvertingConfigurationDataState>();

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text("$title:"),
      DropdownButton<String>(
        value: convertingConfigurationDataState.getToDrowDownValue(widgetType),
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
            convertingConfigurationDataState.setByDrowDownValue(
                widgetType, newValue!);
          });
        },
        items: itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
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
    //TODO 优化，在类中存储？
    final convertingConfigurationDataState =
        context.read<ConvertingConfigurationDataState>();

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$title:"),
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
    //TODO 优化，在类中存储？
    final convertingConfigurationDataState =
        context.read<ConvertingConfigurationDataState>();

    _textFieldControllerAlarMinutes.text =
        convertingConfigurationDataState.alarMinutes.toString();
    _textFieldControllerCurrentTeachingWeek.text =
        convertingConfigurationDataState.currentTeachingWeek.toString();

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDrowDownChooser(
              "选择校区",
              convertingConfigurationDataState.campusStrs,
              drowDownChooserWidgeTypeEnum.campus),
          _buildDrowDownChooser(
            "事件标题格式",
            convertingConfigurationDataState.icalTitleTypeStrs,
            drowDownChooserWidgeTypeEnum.icalTitleType,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            //TODO 转换时禁用switch
            children: [
              Text("是否开启提醒:"),
              Switch(
                  value: _ifAlarm,
                  onChanged: (value) {
                    _ifAlarm = value;
                    convertingConfigurationDataState.setIfAlarm(_ifAlarm);
                    setState(() {});
                  }),
            ],
          ),
          if (_ifAlarm)
            _buildTextField(
                "提前多少分钟提醒", 150, "限制为0-150分钟", _textFieldControllerAlarMinutes),
          _buildTextField("当前教学周:", 25, "限制为0-25周",
              _textFieldControllerCurrentTeachingWeek),
        ],
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
