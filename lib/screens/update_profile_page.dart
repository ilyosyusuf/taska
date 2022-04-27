import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/text_field.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/home_service.dart';
import 'package:taska/widgets/elevated_button_widget.dart';

class UpdateProfilePage extends StatelessWidget {
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
      backgroundColor: ColorConst.kBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: FutureBuilder(
                    future: FireHome.getData(),
                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snap) {
                      if (!snap.hasData) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snap.hasError) {
                        return Center(
                          child: Text(
                            "No Internet",
                          ),
                        );
                      } else {
                        var data = snap.data!;
                        return Padding(
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
                                                    radius: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.15,
                                                    backgroundImage: FileImage(
                                                        File(image!.path)))
                                                : CircleAvatar(
                                                    radius: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.15,
                                                    backgroundImage: NetworkImage(
                                                        data['image_url']
                                                            .toString()),
                                                  ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: CircleAvatar(
                                              child: IconButton(
                                                onPressed: () async {
                                                  image = await _picker.pickImage(
                                                      source: ImageSource.gallery);
                                                  setState(() {});
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
                                MyTextField.textField(
                                    text: "${data['name']}",
                                    controller: nameController),
                                MyTextField.textField(
                                    text: "${data['username']}",
                                    controller: usernameController),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyTextField.textField(
                                        text: "${data['birth']}",
                                        controller: birthController,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width * 0.07,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.calendar,
                                          color: ColorConst.kPrimaryColor,
                                        ),
                                        onPressed: () async {
                                          final DateTime? selected =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.utc(1960),
                                            lastDate: DateTime.now()
                                          );
                                          print(selected!.day);
                                        
                                          selected != null
                                              ? birthController.text =
                                                  "${selected.day}/${selected.month}/${selected.year}"
                                              : birthController.text = '';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                MyTextField.textField(
                                    text: "${data['email']}",
                                    controller: emailController,
                                    iconButton: IconButton(
                                        onPressed: () {}, icon: Icon(Icons.email), color: ColorConst.kPrimaryColor,)),
                                PhoneNumberField(
                                  controller: phoneController,
                                  countryCodeWidth: 80,
                                  dialogTitle: "Area code",
                                  decoration: InputDecoration(
                                    hintText: "${data['phone']}",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                MyTextField.textField(
                                    text: "${data['role']}",
                                    controller: roleController),
                                SizedBox(height: 50),
                                ElevatedButtonWidget(
                                    onPressed: () async {
                                      showDialog(
                                          useSafeArea: true,
                                          context: context,
                                          builder: (widget) => SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Center(
                                                    child: LottieBuilder.asset(
                                                  'assets/lotties/save.json',
                                                  fit: BoxFit.cover,
                                                )),
                                              ));
                                      await context
                                          .read<LoginProvider>()
                                          .updateProfile(
                                              context,
                                              image!,
                                              nameController.text,
                                              usernameController.text,
                                              birthController.text,
                                              phoneController.nationalNumber,
                                              roleController.text);
                                    },
                                    text: "Update")
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
