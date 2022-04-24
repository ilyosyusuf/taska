import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';

class MyTextField{
  static textField(
      {required String text,
      IconButton? iconButton,
      required TextEditingController controller,
      IconButton? phoneNumber}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: iconButton,
        prefixIcon: phoneNumber,
        fillColor: ColorConst.kTextFieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      // validator: (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
    );
  }
}