import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBarIconColor({
  required Brightness iconColor,
  Color statusBarColor = Colors.transparent,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: iconColor,
    ),
  );
}
