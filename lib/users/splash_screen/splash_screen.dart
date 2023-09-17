import 'package:clothes/consts/colors.dart';
import 'package:clothes/consts/consts.dart';
import 'package:clothes/consts/widgets_common/applogo_widget.dart';
import 'package:clothes/users/authentication/login_screen.dart';
import 'package:clothes/users/fragments/dashboard_of_fragments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:clothes/users/userPreferences/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  // creting a method to change screen
  changeScreen()
  {
    // FutureBuilder(
    //     future: RememberUserPrefs.readUserInfo(),
    //     builder: (context, dataSnapShot){
    //       if(dataSnapShot.data == null){
    //         return const LoginScreen();
    //       }else{
    //         return DashboardOfFragments();
    //       }
    //     },
    //   );

    Future.delayed(const Duration(seconds: 3),(){
      
        Get.to(() => DashboardOfFragments());

      
    });
  }

  @override
  void initState()
  {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300)),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              5.heightBox,
              appversion.text.white.make(),
              Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
              // flashscreen ui is complete
          ],
        ),
      ),
    );
  }
}