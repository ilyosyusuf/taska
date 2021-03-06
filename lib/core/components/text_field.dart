import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';

class MyTextField {
  static textField(
      {required String text,
      IconButton? iconButton,
      required TextEditingController controller,
      IconButton? phoneNumber,
      bool read = false,
      var onChanged,
      VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      readOnly: read,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: iconButton,
        prefixIcon: phoneNumber,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: ColorConst.kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
