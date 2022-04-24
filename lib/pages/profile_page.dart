import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/services/firebase/fire_service.dart';
import 'package:taska/services/firebase/home_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/taska.png',
                      width: 50,
                    ),
                    const Text(
                      "Taska",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'mainFont',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundImage: NetworkImage(
                              data['image_url'].toString(),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        data['name'].toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['username'].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userPro("0", "Projects"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                            userPro(data['todos'].length.toString(), "Tasks"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                            userPro("0", "Groups")
                          ],
                        ),
                      ),
                      Divider(thickness: 1,)
                    ],
                    
                  ),
                );
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: Column(
                  children: [
                    listTile(Icon(FontAwesomeIcons.wordpress), "Workspace"),
                    listTile(Icon(FontAwesomeIcons.user), "Edit Profile", onPressed: (){
                      // showModalBottomSheet(context: context, builder: (context){
                      //   return Container();
                      // });
                      Navigator.pushNamed(context, '/updateprofile');
                    }),
                    listTile(Icon(FontAwesomeIcons.bell), "Notifications"),
                    listTile(Icon(Icons.verified_user), "Security"),
                    listTile(Icon(FontAwesomeIcons.infoCircle), "Help"),
                    listTile(Icon(FontAwesomeIcons.eye), "Dark Theme", trailing: Switch.adaptive(value: true, onChanged: (v){})),
                    listTile(Icon(FontAwesomeIcons.signOutAlt), "Logout", color: Colors.red),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  ListTile listTile(Icon icon, String text,  {VoidCallback? onPressed,Switch? trailing, Color? color})=> ListTile(
    leading: icon,
    title: Text(text, style: TextStyle(color: color),),
    trailing: trailing, iconColor: color,
    onTap: onPressed
  );

  Column userPro(String text, String text2) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            text2,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
}
