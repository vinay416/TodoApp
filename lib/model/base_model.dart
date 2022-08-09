import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  State _state = State.view;

  State get state => _state;

  void setState(State state) {
    _state = state;
    notifyListeners();
  }
}

enum State {
  loading,
  view,
}
