import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GPS_denied_message extends StatelessWidget {
  const GPS_denied_message({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Permission Denied'),
      content: Text('Location permissions are denied. we cannot request permissions. choose locations from app setings and enable it'),
      actions: [
       TextButton(
        onPressed: () async {
          // فتح إعدادات التطبيق
          await openAppSettings(); //from permission handler message
          Navigator.of(context).pop(); // إغلاق الـ AlertDialog
        },
        child: Text('Open Settings'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // إغلاق الـ AlertDialog
        },
        child: Text('Cancel'),
      ),
      ],
    );
  }
}
