import 'package:flutter/material.dart';

class MyBoxDecoration {
  static get decor => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      );
}
