import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

Future<bool> shareFile(BuildContext context, String fileNamePath) async {
  final box = context.findRenderObject() as RenderBox?;

  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  //make sure got storage permission

  if (await Permission.storage.isGranted) {
    await Share.shareFiles(['$fileNamePath'],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    return true;
  }

  return false;
}
