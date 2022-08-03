import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

String getFormattedDate(DateTime date) {
  final String todoDate = DateFormat.yMMMMd().format(date);
  return todoDate;
}
