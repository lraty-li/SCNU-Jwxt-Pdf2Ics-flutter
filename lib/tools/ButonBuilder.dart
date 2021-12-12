import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  //TODO add padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
  RoundButton(
      {Key? key,
      this.onPressed,
      this.icon,
      this.iconSize,
      required this.text,
      this.textFontSize,
      this.padding})
      : super(key: key);

  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconSize;
  final text;
  final double? textFontSize;

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(15)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                icon,
                size: iconSize,
              ),
            ),
            ConstrainedBox(
              //TODO how auto?
              constraints: BoxConstraints(maxHeight: 100, maxWidth: 300),
              child: Text(text, style: TextStyle(fontSize: textFontSize)),
            ),
          ],
        ));
    if (padding == null)
      return button;
    else
      return Padding(
        padding: padding as EdgeInsetsGeometry,
        child: button,
      );
  }
}
