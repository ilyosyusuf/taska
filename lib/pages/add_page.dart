import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/app_bar.dart';
import 'package:taska/core/components/text_field.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/add_provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';

class AddPage extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _moreController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  String? text;
  String? email;
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ColorConst.kBackgroundColor,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
          MyAppBar.myAppBar(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StatefulBuilder(builder: (context, setstate) {
                return InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // border: Border.all(color: ColorConst.kPrimaryColor),
                      color: Colors.white,
                      image: image == null
                          ? const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/upload.png'),
                            )
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(image!.path),
                              ),
                            ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onTap: () async {
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setstate(() {});
                  },
                );
              }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 20.0, right: 20.0),
                      child: MyTextField.textField(
                          text: "Title", controller: _titleController)),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 20.0, right: 20.0),
                    child: MyTextField.textField(text: "More", controller: _moreController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextField.textField(
                              text: "Choose Date",
                              controller: _dateController,
                              read: true),
                        ),
                        SizedBox(width: 10.0),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.07,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.calendar,
                              color: ColorConst.kPrimaryColor,
                            ),
                            onPressed: () async {
                              final DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.utc(2060),
                              );
                              print(selected!.day);

                              selected != null
                                  ? _dateController.text =
                                      "${selected.day}/${selected.month}/${selected.year}"
                                  : _timeController.text = '';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextField.textField(
                            text: "Choose Time",
                            controller: _timeController,
                            read: true,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.07,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.clock,
                              color: ColorConst.kPrimaryColor,
                            ),
                            onPressed: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 9, minute: 00));
                              selectedTime != null
                                  ? _timeController.text =
                                      '${selectedTime.hour}:${selectedTime.minute}'
                                          .toUpperCase()
                                  : _timeController.text = '';
                              debugPrint(
                                  '${selectedTime!.hour} : ${selectedTime.minute}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: ColorConst.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () async {
                  showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (widget) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            child: Center(
                                child: LottieBuilder.asset(
                              'assets/lotties/save.json',
                              fit: BoxFit.cover,
                            )),
                          ));
                  await context.read<AddProvider>().addToList();
                  email = FireService.auth.currentUser!.email.toString();
                  print(email);
                  await context.read<AddProvider>().addToDb(
                        context,
                        image!,
                        email.toString(),
                        _titleController.text,
                        _moreController.text,
                        _dateController.text,
                        _timeController.text,
                      );
                  _titleController.clear();
                  _moreController.clear();
                  _timeController.clear();
                  _dateController.clear();
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextFormField textField(
  //     {required String text,
  //     IconButton? iconButton,
  //     required TextEditingController controller,
  //     IconButton? suffixIcon,
  //     bool? read = false}) {
  //   return TextFormField(
  //       readOnly: read!,
  //       controller: controller,
  //       decoration: InputDecoration(
  //         fillColor: Colors.white,
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25.0),
  //           borderSide: BorderSide(color: ColorConst.kPrimaryColor),
  //         ),
  //         filled: true,
  //         hintText: text,
  //         suffixIcon: suffixIcon,
  //         hintStyle: TextStyle(color: ColorConst.kPrimaryColor),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             borderSide: BorderSide.none),
  //       )
  //       // validator: (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
  //       );
  // }
}
