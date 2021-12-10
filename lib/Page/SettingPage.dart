import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/tools/ThemedPage.dart';

//** Deprecated Page */


class _Item {
  _Item({
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
}

class SettigPage extends StatelessWidget {
  static const routeName = "SettigPage";
  final List options = [
    ["语言", Icons.g_translate],
    ["主题与深色模式", Icons.dark_mode],
    ["项目地址", Icons.code]
  ];

  //list item
  late final List<_Item> listItems = [];

  @override
  Widget build(BuildContext context) {
    options.forEach((element) {
      listItems.add(_Item(title: element[0], icon: element[1]));
    });

    var _settingScaffold = Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("设置"),
          titleTextStyle: TextStyle(fontSize: 25)),
      body: _buildSettingListView(),
    );
    return ThemedPage(
      home: _settingScaffold,
      routes: {
      },
    );
  }

  Widget _buildSettingListView() {
    return ListView.separated(
        itemCount: listItems.length,
        itemBuilder: (context, i) {
          return _buildRow(listItems[i], context);
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
        padding: const EdgeInsets.all(16.0));
  }

  Widget _buildRow(_Item item, BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        // style: _biggerFont,
      ),
      leading: Icon(item.icon),
      onTap: () {
        Navigator.pushNamed(context, "ThemePage");
      },
    );
  }
}
