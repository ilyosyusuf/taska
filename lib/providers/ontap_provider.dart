import 'package:flutter/cupertino.dart';

class OnTapProvider extends ChangeNotifier{
  bool onTap = false;
  void onTapped(){
    onTap = !onTap;
    notifyListeners();
  }
}