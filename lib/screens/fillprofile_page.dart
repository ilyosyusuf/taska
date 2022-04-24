import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/text_field.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/core/constants/font_const.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/widgets/elevated_button_widget.dart';

class FillProfilePage extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  PhoneNumberEditingController phoneController = PhoneNumberEditingController();
  TextEditingController roleController = TextEditingController();
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 25),
              child: const Text(
                "Fill Your Profile",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatefulBuilder(
                      builder: ((context, setState) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              SizedBox(
                                child: image != null
                                    ? CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        backgroundImage:
                                            FileImage(File(image!.path)))
                                    : CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        backgroundImage: AssetImage(
                                            'assets/images/user.png')),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  child: IconButton(
                                    onPressed: () async {
                                      image = await _picker.pickImage(
                                          source: ImageSource.gallery);
                                      setState((){});
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    MyTextField.textField(text: "Full name", controller: nameController),
                    MyTextField.textField(text: "Usename", controller: usernameController),
                    MyTextField.textField(
                        text: "Date of Birth",
                        controller: birthController,
                        iconButton: IconButton(
                            onPressed: () async {
                              final DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.utc(1966),
                                lastDate: DateTime.utc(2023),
                              );
                              print(selected!.day);
                              birthController.text =
                                  "${selected.day}/${selected.month}/${selected.year}";
                            },
                            icon: Icon(Icons.calendar_month))),
                    MyTextField.textField(
                        text: "Email",
                        controller: emailController,
                        iconButton: IconButton(
                            onPressed: () {}, icon: Icon(Icons.email))),
                    PhoneNumberField(
                      controller: phoneController,
                      countryCodeWidth: 80,
                      dialogTitle: "Area code",
                      decoration: InputDecoration(
                        hintText: "Telephone number",
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: ColorConst.kTextFieldColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    MyTextField.textField(text: "Role", controller: roleController),
                    SizedBox(height: 50),
                    ElevatedButtonWidget(onPressed: () {
                      context.read<LoginProvider>().fillProfile(context, image!, nameController.text, usernameController.text, birthController.text, phoneController.nationalNumber, roleController.text);
                    }, text: "Continue")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
