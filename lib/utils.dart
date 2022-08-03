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
  final String day = DateFormat.d().format(date);
  final String month = DateFormat.MMMM().format(date);
  final String year = DateFormat.y().format(date);

  final String formatted = "$day $month, $year";

  return formatted;
}
