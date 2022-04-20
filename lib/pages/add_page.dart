import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/add_provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';

// class AddPage extends StatefulWidget {
//   AddPage({Key? key}) : super(key: key);

//   @override
//   State<AddPage> createState() => _AddPageState();
// }

class AddPage extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _moreController = TextEditingController();
  String? text;
  String? email;

  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: StatefulBuilder(builder: (context, setstate) {
                  return InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: image == null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: 
                                AssetImage('assets/images/uploadimage.png')
                              )
                            : DecorationImage(
                              fit: BoxFit.cover,
                                image: FileImage(
                                  File(image!.path),
                                ),
                              ),
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    //  BoxDecoration(
                    //     image: DecorationImage(
                    //         image: FileImage(File(image!.path))),
                    //     // color: Colors.grey,
                    //     borderRadius: BorderRadius.circular(20.0))),
                    onTap: () async {
                      image = await _picker.pickImage(
                          source: ImageSource.gallery);
                      setstate((){});
                    },
                  );
                }),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: ColorConst.kPrimaryColor,
                        cursorRadius: const Radius.circular(10),
                        decoration: textDecoration("Title"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            // showSnackBar("Please fill the line", Colors.red);
                            print("Please fill the line");
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _moreController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        minLines: 1,
                        cursorColor: ColorConst.kPrimaryColor,
                        cursorRadius: const Radius.circular(10),
                        decoration: textDecoration("More"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            // showSnackBar("Please fill the line", Colors.red);
                            print("Please fill the line");
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
                onPressed: () async {
                  context.read<AddProvider>().addToList();
                  email = FireService.auth.currentUser!.email.toString();
                  print(email);
                   context.read<AddProvider>().addToDb(context,
                    image!,
                    email.toString(),
                   _titleController.text, _moreController.text);
                   _titleController.clear();
                   _moreController.clear();
                },
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textDecoration(String text) {
    return InputDecoration(
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: text,
      hintStyle: TextStyle(color: ColorConst.kPrimaryColor),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none),
    );
  }
}
