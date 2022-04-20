import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/theme_comp.dart';
import 'package:taska/core/routes/my_route.dart';
import 'package:taska/providers/add_provider.dart';
import 'package:taska/providers/lottie_provider.dart';
import 'package:taska/providers/signin_provider.dart';
import 'package:taska/services/firebase/fire_service.dart';

import 'screens/authentication/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => SplashProvider()),
      ChangeNotifierProvider(create: (context) => AddProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MyRoute _myRoute = MyRoute();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeComp.myTheme,
      // home: LoginPage()
      // initialRoute: FireService.auth.currentUser != null ? '/home': '/signup',
      initialRoute: '/firstsplash',
      onGenerateRoute: _myRoute.onGenerateRoute,
    );
  }
}
