import 'package:flutter/material.dart';

class  ChangeProvider extends ChangeNotifier {
  Future changed(int index, bool isTrue)async{
    isTrue = !isTrue;
    notifyListeners();
  }
}