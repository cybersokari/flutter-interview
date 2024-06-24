import 'package:flutter/material.dart';

enum MarkerState { hidden, icon, text }

class MapMarkerModel with ChangeNotifier {
  MarkerState markerState = MarkerState.hidden;

  void showIcon() {
    markerState = MarkerState.icon;
    notifyListeners();
  }

  void showText() {
    markerState = MarkerState.text;
    notifyListeners();
  }

  void hide() {
    markerState = MarkerState.hidden;
    notifyListeners();
  }
}
