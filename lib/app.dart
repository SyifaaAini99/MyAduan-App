import 'package:MyAduan/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'resident_profile.dart';
import 'filed.dart';
import 'resolved.dart';
import 'Compose.dart';
import 'notifications.dart';
import 'navigation.dart';
import 'login.dart';
import 'aboutPage.dart';

class MyAduan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(title: 'MyAduan', routes: {
      '/filed': (context) => Filed(),
      '/resolved': (context) => Resolved(),
      '/resident_profile': (context) => Profile(),
      '/compose': (context) => Compose(),
      '/notifications': (context) => Notifications(),
      '/navigation': (context) => User1(),
      '/register': (context) => RegisterPage(),
      '/': (context) =>
          (FirebaseAuth.instance.currentUser == null) ? MyLoginPage() : User1(),
      '/about': (context) => AboutPage()
    });
  }
}
