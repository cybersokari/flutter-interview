import 'package:flutter/cupertino.dart';

class AnimationModel extends ChangeNotifier {
  bool sliderMoved = false;

  void moveSlider() {
    sliderMoved = true;
    notifyListeners();
  }
}
