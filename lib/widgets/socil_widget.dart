import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taska/providers/signin_provider.dart';

class SocialeWidget extends StatelessWidget {
  const SocialeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        childs(() {}, FadeInDown(child: Image.asset('assets/icons/facebook.png', width: 30))),
        childs(() {
          // context.read<LoginProvider>().signInWithGoogle(context);
        }, FadeInUp(child: Image.asset('assets/icons/google.png', width: 30))),
        childs(() {}, FadeInDown(child: Image.asset('assets/icons/apple.png', width: 30))),
      ],
    );
  }

  Container childs(VoidCallback onPressed, Widget icon) {
    return Container(
      width: 80,
      height: 60,
      child: IconButton(onPressed: onPressed, icon: icon),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
