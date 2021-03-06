import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/widgets/box_decoration_widget.dart';
import 'package:taska/widgets/elevated_button_widget.dart';
import 'package:taska/widgets/login_textwidget.dart';
import 'package:taska/widgets/socil_widget.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkValue = false;
  bool isShown = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: LogInTextWidget(
              first: "Create your",
              second: "Account",
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        FadeInLeft(
                          child: Container(
                            decoration: MyBoxDecoration.decor,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "Enter Email",
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        FadeInRight(
                          child: Container(
                            decoration: MyBoxDecoration.decor,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: isShown,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    isShown = !isShown;
                                  },
                                ),
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: checkValue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onChanged: (v) {
                                checkValue = !checkValue;
                              },
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButtonWidget(
                      onPressed: () {
                        context.read<LoginProvider>().signUp(context,
                            emailController.text, passwordController.text);
                        context.read<LoginProvider>().saveToStore(context,
                            emailController.text, passwordController.text);
                      },
                      text: "Sign Up"),
                  const SizedBox(height: 65),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                      )),
                      Text("or continue with"),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SocialeWidget(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Allready have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/signin', (route) => false);
                          },
                          child: Text("Sign In"))
                    ],
                  )
                ],
              )))
        ],
      ),
    );
  }
}
