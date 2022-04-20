import 'package:flutter/material.dart';
import 'package:taska/screens/authentication/sign_in_page.dart';
import 'package:taska/screens/authentication/sign_up_page.dart';
import 'package:taska/screens/fillprofile_page.dart';
import 'package:taska/screens/first_splash_page.dart';
import 'package:taska/screens/homepage.dart';
import 'package:taska/screens/splash_page.dart';

class MyRoute {
  Route? onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/firstsplash':
        return MaterialPageRoute(builder: ((context) => FirstSplashPage()));
      case '/splash':
        return MaterialPageRoute(builder: ((context) => SplashPage()));
      case '/home':
        return MaterialPageRoute(builder: ((context) => HomePage()));
      case '/signup':
        return MaterialPageRoute(builder: ((context) => SignUpPage()));
        
      case '/signin':
        return MaterialPageRoute(builder: ((context) => SignInPage()));

      case '/fillprofile':
        return MaterialPageRoute(builder: ((context) => FillProfilePage()));
    }
  }
}
