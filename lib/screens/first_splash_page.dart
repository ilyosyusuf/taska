import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstSplashPage extends StatefulWidget {
  const FirstSplashPage({Key? key}) : super(key: key);

  @override
  State<FirstSplashPage> createState() => _FirstSplashPageState();
}

class _FirstSplashPageState extends State<FirstSplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/splash', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FadeInLeft(
                child: LottieBuilder.asset('assets/lotties/todo.json'),
                duration: Duration(seconds: 2),
              ),
            ),
          ),
          Expanded(
            // flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: FadeInUp(
                        child: Image.asset('assets/images/maintaska.png'),
                        duration: Duration(seconds: 2),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: FadeInLeft(
                    child: LottieBuilder.asset('assets/lotties/loading.json'),
                    duration: Duration(seconds: 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
