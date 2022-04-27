import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/services/firebase/fire_service.dart';

class AddProvider extends ChangeNotifier {
  List todos = [];
  Set setList = {};
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

  Future changeValue(int index, bool onTap) async {
    todos[index]['check'] = onTap;

    await FireService.store
        .collection('users')
        .doc('${FireService.auth.currentUser!.email}')
        .set(
      {"todos": todos},
      SetOptions(merge: true),
    );
    // print(todos[index]['check']);

    notifyListeners();
  }

  Future deleteTodos(int index) async {
    if (todos[index]['check']) {
    todos.removeAt(index);
    }
    await FireService.store.collection('users').doc('${FireService.auth.currentUser!.email}').update(
      {
        "todos": todos,
      },
    );
    SetOptions(merge: true);
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

  void searchIt(String text){
    setList.clear();
    for (var i = 0; i < todos.length; i++) {
      if(text.isEmpty){
        setList.clear();
        notifyListeners();
      }else if(todos[i]['title'].toString().toLowerCase().contains(text.toString().toLowerCase())){
        setList.add(todos[i]);
        notifyListeners();
      }
    }
  }
}
