import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({ Key? key }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
    TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "Enter Email",
                              fillColor: ColorConst.kTextFieldColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            // validator: (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {},
                              ),
                              labelText: "Enter Password",
                              fillColor: ColorConst.kTextFieldColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            // validator: (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkValue,
                                shape: RoundedRectangleBorder(
                                    // side: BorderSide(color: ColorConst.kPrimaryColor),
                                    borderRadius: BorderRadius.circular(5.0)),
                                onChanged: (v) {
                                  // v = !v!;
                                  checkValue = !checkValue;
                                  setState(() {});
                                },
                              ),
                              Text("Remember me"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: ColorConst.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50)),
                        child: Text("Sign Up")),
                    const SizedBox(height: 65),
                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1,)),
                        Text("or continue with"),
                        Expanded(child: Divider(thickness: 1,))
                    ],)
                  ],
                ),
              ),
            );
  }
}