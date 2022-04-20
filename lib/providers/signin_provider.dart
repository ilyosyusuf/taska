import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/services/firebase/fire_service.dart';
import 'package:taska/widgets/my_messenger.dart';

class LoginProvider extends ChangeNotifier {

  String? email;

  Future signIn(BuildContext context, String emailController,
      String passwordController) async {
    try {
      await FireService.auth.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      email = emailController;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyMessenger.messenger(
            context, "Bunday Emaildagi akkount mavjud emas", Colors.red);
      } else if (e.code == 'wrong-password') {
        MyMessenger.messenger(context, "Noto'g'ri parol terildi", Colors.red);
      }
    }

  }

  Future signUp(BuildContext context, String emailController, String passwordController) async {
    try {
      await FireService.auth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/fillprofile', (route) => false);
      email = emailController;
      notifyListeners();
    } catch (e) {
      MyMessenger.messenger(context, "Error while sign in!", Colors.red);
    }
    notifyListeners();
  }

  Future saveToStore(BuildContext context, String emailController, String passwordController) async {
    try {
      await FireService.store.collection('users').doc('$emailController').set(
        {
          "email": emailController,
          "create_at": FieldValue.serverTimestamp(),
        }
      );
    } catch (e) {
      MyMessenger.messenger(context, "Error while sign in1", Colors.red);
    }
    notifyListeners();
  }

    Future updateProfile(BuildContext context, XFile file, String name, String username, String birth, String phone, String role) async {
    try {
        var image = await FireService.storage.ref().child('users').child('avatars').child(email.toString()).putFile(File(file.path));
        String downloadUrl = await image.ref.getDownloadURL();

      await FireService.store.collection('users').doc('$email').update(
        {
          "image_url": downloadUrl,
          "name": name,
          "username": username,
          "birth": birth,
          "phone": phone,
          "role": role,
          "todos": [],
        },
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        SetOptions(merge: true);
    } catch (e) {
      MyMessenger.messenger(context, "Error while updating!", Colors.red);
    }
    notifyListeners();
  }

  Future logOut(BuildContext context) async {
    try {
      await FireService.auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } on FirebaseAuthException catch (e) {
      print("Xatolik yuz berdi");
    }
  }

  // Future signInWithGoogle(BuildContext context) async {
  //   try{
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     email = FirebaseAuth.instance.signInWithCredential(credential).toString();
  //     print(googleUser);
  //             Navigator.pushNamedAndRemoveUntil(context, '/fillprofile', (route) => false);
  //   } catch (e){
  //     print(e);
  //     MyMessenger.messenger(context,"Error Google Sign In", Colors.red);
  //   }
  // }
}