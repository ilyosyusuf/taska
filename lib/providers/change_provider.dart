import 'package:flutter/material.dart';
import 'package:taska/services/firebase/fire_service.dart';

class  ChangeProvider extends ChangeNotifier {
  Future changed(int index, bool isTrue)async{
    isTrue = !isTrue;
    notifyListeners();
  }


  //   Future checkDb(int index, bool onTap) async {
  //   await FireService.store.collection('todos').doc("${FireService.auth.currentUser!.email}").set(
  //     {"check": completed[index] = !completed[index]},
  //     SetOptions(merge: true),
  //   );
  //   notifyListeners();
  //   print(completed);
  //   print("ozgardi");
  // }
}