import 'package:clothes/users/authentication/login_screen.dart';
import 'package:clothes/users/fragments/dashboard_of_fragments.dart';
import 'package:clothes/users/splash_screen/splash_screen.dart';
import 'package:clothes/users/splash_screen/splash_screen2.dart';
import 'package:clothes/users/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shop Now',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot){
          if(dataSnapShot.data == null){
            // go to SplashScreen log in
            return const SplashScreen2();
          }else{
            // go to SplashScreen then dashboard
            return const SplashScreen();
          }
        },
      ),
    );
  }
}

