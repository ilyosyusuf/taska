import 'package:flutter/material.dart';
import 'package:taska/pages/profile_page.dart';
import 'package:taska/screens/authentication/sign_in_page.dart';
import 'package:taska/screens/authentication/sign_up_page.dart';
import 'package:taska/screens/fillprofile_page.dart';
import 'package:taska/screens/first_splash_page.dart';
import 'package:taska/screens/full_info_page.dart';
import 'package:taska/screens/homepage.dart';
import 'package:taska/screens/splash_page.dart';
import 'package:taska/screens/update_profile_page.dart';

class MyRoute {
  static final MyRoute _instance = MyRoute._init();
  static MyRoute get instance => _instance;
  
  MyRoute._init();

  Route? onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {

      case '/firstsplash':
        return _pages(FirstSplashPage());

      case '/splash':
        return _pages(SplashPage());
      case '/home':
        return _pages(HomePage());

      case '/profile':
        return _pages(ProfilePage());

      case '/signup':
        return _pages(SignUpPage());

      case '/signin':
        return _pages(SignInPage());

      case '/fillprofile':
        return _pages(FillProfilePage());

      case '/updateprofile':
        return _pages(UpdateProfilePage());

      case '/fullinfo':
        return _pages(FullInfoPage());

    }
  }
    _pages(Widget page){
      return MaterialPageRoute(builder: (context)=> page);
    }

}


  
