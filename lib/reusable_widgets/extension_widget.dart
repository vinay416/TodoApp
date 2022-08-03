import 'package:flutter/cupertino.dart';

extension CustomContext on BuildContext {
  double h(double pixel) {
    return MediaQuery.of(this).size.height * (pixel / 1000);
  }

  double w(double pixel) {
    return MediaQuery.of(this).size.width * (pixel / 1000);
  }

  bool get isPortrait {
    return MediaQuery.of(this).orientation == Orientation.portrait;
  }
}
