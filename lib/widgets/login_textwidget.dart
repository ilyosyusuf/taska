import 'package:flutter/material.dart';

class LogInTextWidget extends StatelessWidget {
  String first;
  String second;
  LogInTextWidget({Key? key, required this.first, required this.second})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            first,
            style: TextStyle(fontSize: 40),
          ),
          Text(
            second,
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
