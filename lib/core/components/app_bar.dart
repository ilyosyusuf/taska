import 'package:flutter/material.dart';

class MyAppBar {
  static myAppBar({IconButton? iconButton}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: AssetImage('assets/images/taska.png')))),
              SizedBox(
                width: 10.0,
              ),
              const Text(
                "Taska",
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'mainFont',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          iconButton != null ? iconButton : SizedBox(),
        ],
      ),
    );
  }
}
