import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/lottie_provider.dart';
import 'package:taska/widgets/elevated_button_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var allVariables = context.watch<SplashProvider>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: allVariables.images[allVariables.index]),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      allVariables.textInfo[allVariables.index],
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.100,
                        child: Text(
                          allVariables.lorem,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.3),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.050,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.010),
                              child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: __ == allVariables.index
                                      ? ColorConst.kPrimaryColor
                                      : Colors.blue.shade100,
                                ),
                              ),
                            );
                          },
                          itemCount: allVariables.textInfo.length - 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeInLeft(
                            child: ElevatedButtonWidget(
                              onPressed: () {
                                context.read<SplashProvider>().onTap(context);
                              },
                              text: "next",
                            ),
                          ),
                          FadeInRight(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/signup', (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 15.0,
                                primary: ColorConst.kSecondButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                              ),
                              child: Text(
                                "skip",
                                style:
                                    TextStyle(color: ColorConst.kPrimaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
