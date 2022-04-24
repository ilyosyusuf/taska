import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/app_bar.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/providers/theme_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';
import 'package:taska/services/firebase/home_service.dart';
import 'package:taska/widgets/box_decoration_widget.dart';
import 'package:taska/widgets/elevated_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MyAppBar.myAppBar(),
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
                            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
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
                    listTile(Icon(Icons.workspace_premium), "Workspace"),
                    listTile(Icon(FontAwesomeIcons.user), "Edit Profile", onPressed: (){
                      Navigator.pushNamed(context, '/updateprofile');
                    }),
                    listTile(Icon(FontAwesomeIcons.bell), "Notifications"),
                    listTile(Icon(Icons.verified_user), "Security"),
                    listTile(Icon(Icons.info_outline), "Help"),
                    listTile(Icon(FontAwesomeIcons.eye), "Dark Theme", trailing: Switch.adaptive(
                      value: context.watch<ThemeProvider>().themeStatus, 
                      onChanged: (v){
                        context.read<ThemeProvider>().changeTheme();
                      })),
                    listTile(Icon(FontAwesomeIcons.signOutAlt), "Logout", color: Colors.red, onPressed: (){
                      showModalBottomSheet(
                        context: context, 
                        backgroundColor: Colors.transparent,
                        builder: (context){
                        
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 25.0),),
                                ), 
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Are you sure you want to log out?", style: TextStyle(fontSize: 18.0),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                                  child: ElevatedButtonWidget(onPressed: (){
                                    context.read<LoginProvider>().logOut(context);
                                  }, text: "Yes, Logout"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                  "Cancel",
                                  style:
                                      TextStyle(color: ColorConst.kPrimaryColor),
                              ),
                            ),
                                ),
                                
                              ],
                            ),
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
                          ),
                        );
                      });
                    }),
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
