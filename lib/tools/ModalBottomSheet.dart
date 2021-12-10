import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scnu_jwxt_pdf2ics/util/ThemeState.dart';

popModalBottomSheet(BuildContext context, List<ListTile> listTileList) {
  showModalBottomSheet(
      backgroundColor: Color(0x00),
      context: context,
      builder: (BuildContext context) {
        return Consumer<ThemeState>(
          builder: (context, themeState, child) => Theme(
              data: themeState.getcurrThemeData(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Stack(children: [
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                          // color: Color(0xff4a6572),
                          color: themeState
                              .getcurrThemeData(context)
                              .primaryColor),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Icon(
                          Icons.reorder_rounded,
                          size: 25,
                          color:
                              themeState.getcurrThemeData(context).secondaryHeaderColor,
                        ),
                      ),
                    )
                  ]),
                  Container(
                    height: listTileList.length * 64,
                    child: Material(
                      child: ListView.separated(
                        itemCount: listTileList.length,
                        itemBuilder: (context, index) {
                          return listTileList[index];
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                    ),
                  ),
                  Material(
                    child: Container(
                      height: 64,
                      child: ListView(
                        children: [
                          ListTile(
                              // title: Text("Hi"),
                              )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      });
}
