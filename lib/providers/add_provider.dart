import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';
import 'package:taska/services/firebase/home_service.dart';

class AddProvider extends ChangeNotifier {
  List todos = [];
  // bool onTap = false;
  Future addToDb(BuildContext context, XFile file, String email, String title,
      String more, String date, String time) async {
    var image = await FireService.storage
        .ref()
        .child('users')
        .child('todos')
        .child(title.trim())
        .putFile(File(file.path));
    String downloadUrl = await image.ref.getDownloadURL();

    todos.add({
      "image_todos": downloadUrl,
      "title": title,
      "more": more,
      "time_written": DateTime.now(),
      "date": date,
      "time": time,
      "check": false,
    });

    await FireService.store.collection('users').doc('$email').set(
      {"todos": todos},
      SetOptions(merge: true),
    );
    print("qoshildi");
    // print(todos[2]['check'] = true);
    notifyListeners();
  }

  // Future checkTrue(int index) async {
  //   // onTap = !onTap;
  //   // todos[index]['check'] = false;
  //   // FireHome.myData['todos'][index]['check'] = true;
  //   //  print(FireHome.myData['todos'][index]['check']);
  //   await FireService.store.collection('users').doc('${FireService.auth.currentUser!.email}').set(
  //     {"todos": todos},
  //     SetOptions(merge: true),
  //   );
  //   notifyListeners();
  // }


  Future changeValue(int index, bool onTap)async{
    todos[index]['check'] = onTap;
    
        await FireService.store.collection('users').doc('${FireService.auth.currentUser!.email}').set(
      {"todos": todos},
      SetOptions(merge: true),
    );

    print(todos[index]['check']);

    notifyListeners();
  }

  Future addToList() async {
    await FireService.store
        .collection('users')
        .doc('${FireService.auth.currentUser!.email}')
        .get()
        .then((value) {
      todos = value.data()!['todos'];
      print(todos);
    });
  }
}
