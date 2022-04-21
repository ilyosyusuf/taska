import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';

class AddProvider extends ChangeNotifier {
  List todos = [];
  Future addToDb(BuildContext context, XFile file, String email, String title, String more) async {
      var image = await FireService.storage.ref().child('users').child('todos').child(title.trim()).putFile(File(file.path));
      String downloadUrl = await image.ref.getDownloadURL();

    todos.add({
      "image_todos": downloadUrl,
      "title": title,
      "more": more,
      "time": DateTime.now(),
    });
    await FireService.store.collection('users').doc('$email').set(
      {
        "todos": todos
      },
      SetOptions(merge: true),
    );
    print("qoshildi");
    notifyListeners();
  }

  Future addToList()async{
    await FireService.store.collection('users').doc('${FireService.auth.currentUser!.email}').get().then((value){
      todos = value.data()!['todos'];
      print(todos);
    });
    
  }


}
