import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBarIconColor({required Brightness iconColor}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconColor,
    ),
  );
}
