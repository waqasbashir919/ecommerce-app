import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/auth/login_page.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/on_boarding_screen.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/auth/registration_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<UserId?>.value(
    value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      initialRoute: '/onBoardingScreen',
      routes: {
        '/onBoardingScreen': (context) => OnBoardingScreen(),
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(),
      },
    ),
  ));
}
