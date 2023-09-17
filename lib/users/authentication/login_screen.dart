import 'dart:convert';
import 'dart:math';
import 'dart:developer';

import 'package:clothes/consts/consts.dart';
import 'package:clothes/consts/lists.dart';
import 'package:clothes/consts/widgets_common/applogo_widget.dart';
import 'package:clothes/consts/widgets_common/bg_widget.dart';
import 'package:clothes/consts/widgets_common/our_button.dart';
import 'package:clothes/users/authentication/signup_screen.dart';
import 'package:clothes/users/fragments/dashboard_of_fragments.dart';
import 'package:clothes/users/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:clothes/api/api_connect.dart';
import 'package:clothes/users/model/user.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'user_email': emailController.text.trim(),
          'user_password': passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        print(res.body);
        if (result['success'] == true) {
          // Fluttertoast.showToast(msg: 'Login Successfully');
          VxToast.show(context, msg: loggedin);

          User userInfo = User.fromJson(result["userData"]);
          RememberUserPrefs.storeUserInfo(userInfo);
          //  Get.to(DashboardOfFragments())
          print(result);
          Future.delayed(const Duration(microseconds: 2000), () {
            Get.to(() => DashboardOfFragments());
          });
        } else {
          // Fluttertoast.showToast(msg: 'Error in login');
          VxToast.show(context, msg: loggedinerror);
        }
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  // loginUserNow() async {

  //   // WebView(
  //   //   initialUrl: 'http://dar.great-site.net/backend/clothes/all.php',
  //   //   javascriptMode: JavascriptMode.unrestricted,

  //   // );
  //   // WebView(
  //   //   initialUrl: 'http://hgt-compra.000webhostapp.com/backend/clothes/all.php',
  //   //   javascriptMode: JavascriptMode.unrestricted,

  //   // );

  //   // final url = Uri.parse('http://hgt-compra.000webhostapp.com/backend/clothes/all.php');
  //   // http.Response response = 
  //   //   // await http.get(url, headers: {'Accept': 'application/json'});
  //   //   await http.get(url, headers: {
  //   //     'Content-Type': 'application/json',
  //   //     'Charset': 'utf-8',
  //   //     // "Accept": 'application/json'
  //   //   });
  //   //   print(response.body);

  //   final response =
  //       await http.get(Uri.parse('https://hgt-compra.000webhostapp.com/backend/clothes/all.php'));
  //       // await http.get(Uri.parse('http://e-hgt.byethost7.com/backend/clothes/all.php'));
  //   print(response.body);
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgWidget(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      // customTextField(hint: emailHint,title: email,isPass: false,controller: controller.emailController),
                      // customTextField(hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
                      
                      //this is our form with email password details
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [


                                        //email textfield
                                        TextFormField(
                                          controller: emailController,
                                          validator: (val) => val == ""
                                              ? "PLease email addesss"
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            hintText: "Email ...",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 14, vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
        
                                        const SizedBox(
                                          height: 18,
                                        ),
        
                                        // for password text field
                                        TextFormField(
                                            controller: passwordController,
                                            obscureText: isObsecure.value,
                                            validator: (val) => val == ""
                                                ? "Please enter password"
                                                : null,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.vpn_key_sharp,
                                                color: Colors.black,
                                              ),
                                              suffixIcon: Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    isObsecure.value =
                                                        !isObsecure.value;
                                                  },
                                                  child: Icon(
                                                    isObsecure.value
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              hintText: "Password ...",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                          ),
                                       
        
                                        const SizedBox(
                                          height: 18,
                                        ),
        
                                        // button login
                                        Material(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                loginUserNow();
                                              }
                                              
                                            },
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28,
                                              ),
                                              child: Text(
                                                login,   
                                                style: TextStyle(
                                                  color: lightGrey,
                                                  fontSize: 16,
                                                  fontFamily: bold,
                                                ),
                                              ),
                                            ).box.white.roundedSM.color(redColor).alignCenter.width(context.screenWidth - 50).make(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
            
        
        
                      
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,

                      // signup button
                      ourButton(
                        color: lightGolden, 
                        title: signup, 
                        textColor: redColor, 
                        onPress: () {
                          Get.to(()=>const SignupScreen());
                        }
                      )
                      .box.width(context.screenWidth - 50).make(),
                
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialIconList[index],
                            width: 30,
                          ),
                          ),
                        )),
                      ),
                
                    ],
                  ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                ),
              ],
            ),
          ),
        ),
      );


    // return Scaffold(
    //     backgroundColor: Colors.black,
    //     body: LayoutBuilder(
    //       builder: (context, cons) {
    //         return ConstrainedBox(
    //           constraints: BoxConstraints(
    //             minHeight: cons.maxHeight,
    //           ),
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 //login scrreb header
    //                 Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   height: 285,
    //                   child: Image.asset("images/login.jpg"),
    //                 ),

    //                 //login screen sign-in form

    //                 const Text(
    //                   "Compra sa HGT",
    //                   style: TextStyle(
    //                     color: Colors.green,
    //                     fontSize: 26,
    //                   ),
    //                 ),

    //                 Padding(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: Container(
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white24,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(60),
    //                         ),
    //                         boxShadow: [
    //                           BoxShadow(
    //                               blurRadius: 8,
    //                               color: Colors.black26,
    //                               offset: Offset(0, -3)),
    //                         ],
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
    //                         child: Column(
    //                           children: [
    //                             //this is our form with email password details
    //                             Form(
    //                               key: formKey,
    //                               child: Column(
    //                                 children: [
    //                                   //email
    //                                   TextFormField(
    //                                     controller: emailController,
    //                                     validator: (val) => val == ""
    //                                         ? "PLease email addesss"
    //                                         : null,
    //                                     decoration: InputDecoration(
    //                                       prefixIcon: const Icon(
    //                                         Icons.email,
    //                                         color: Colors.black,
    //                                       ),
    //                                       hintText: "Email ...",
    //                                       border: OutlineInputBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(30),
    //                                         borderSide: const BorderSide(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       enabledBorder: OutlineInputBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(30),
    //                                         borderSide: const BorderSide(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       focusedBorder: OutlineInputBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(30),
    //                                         borderSide: const BorderSide(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       disabledBorder: OutlineInputBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(30),
    //                                         borderSide: const BorderSide(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       contentPadding:
    //                                           const EdgeInsets.symmetric(
    //                                               horizontal: 14, vertical: 6),
    //                                       fillColor: Colors.white,
    //                                       filled: true,
    //                                     ),
    //                                   ),

    //                                   const SizedBox(
    //                                     height: 18,
    //                                   ),

    //                                   // for password text field

    //                                   Obx(
    //                                     () => TextFormField(
                                          // controller: passwordController,
    //                                       obscureText: isObsecure.value,
    //                                       validator: (val) => val == ""
    //                                           ? "Please enter password"
    //                                           : null,
    //                                       decoration: InputDecoration(
    //                                         prefixIcon: const Icon(
    //                                           Icons.vpn_key_sharp,
    //                                           color: Colors.black,
    //                                         ),
    //                                         suffixIcon: Obx(
    //                                           () => GestureDetector(
    //                                             onTap: () {
    //                                               isObsecure.value =
    //                                                   !isObsecure.value;
    //                                             },
    //                                             child: Icon(
    //                                               isObsecure.value
    //                                                   ? Icons.visibility_off
    //                                                   : Icons.visibility,
    //                                               color: Colors.black,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         hintText: "Password ...",
    //                                         border: OutlineInputBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(30),
    //                                           borderSide: const BorderSide(
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                         enabledBorder: OutlineInputBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(30),
    //                                           borderSide: const BorderSide(
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                         focusedBorder: OutlineInputBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(30),
    //                                           borderSide: const BorderSide(
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                         disabledBorder: OutlineInputBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(30),
    //                                           borderSide: const BorderSide(
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                         contentPadding:
    //                                             const EdgeInsets.symmetric(
    //                                                 horizontal: 14,
    //                                                 vertical: 6),
    //                                         fillColor: Colors.white,
    //                                         filled: true,
    //                                       ),
    //                                     ),
    //                                   ),

    //                                   const SizedBox(
    //                                     height: 18,
    //                                   ),

    //                                   // button input
    //                                   Material(
    //                                     color: Colors.black,
    //                                     borderRadius: BorderRadius.circular(30),
    //                                     child: InkWell(
    //                                       onTap: () {
    //                                         if (formKey.currentState!
    //                                             .validate()) {
    //                                           loginUserNow();
    //                                         }
                                            
    //                                       },
    //                                       borderRadius:
    //                                           BorderRadius.circular(30),
    //                                       child: const Padding(
    //                                         padding: EdgeInsets.symmetric(
    //                                           vertical: 10,
    //                                           horizontal: 28,
    //                                         ),
    //                                         child: Text(
    //                                           "Login",
    //                                           style: TextStyle(
    //                                             color: Colors.white,
    //                                             fontSize: 16,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               height: 16,
    //                             ),
    //                             // dont have account button form here
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 const Text(
    //                                   "Dont't have an Account?",
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize: 15,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                                 TextButton(
    //                                   onPressed: () {
    //                                     Get.to(() => SignupScreen());
    //                                   },
    //                                   child: const Text(
    //                                     "Register here",
    //                                     style: TextStyle(
    //                                       color: Colors.purpleAccent,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),

    //                             // const Text(
    //                             //   "Or",
    //                             //   style: TextStyle(
    //                             //     color: Colors.green,
    //                             //     fontSize: 16,
    //                             //   ),
    //                             // ),

    //                             // admin row

    //                             // Row(
    //                             //   mainAxisAlignment: MainAxisAlignment.center,
    //                             //   children: [
    //                             //     const Text(
    //                             //       "Are you an Admin?",
    //                             //       style: TextStyle(
    //                             //           color: Colors.white,
    //                             //           fontSize: 15,
    //                             //           fontWeight: FontWeight.bold),
    //                             //     ),
    //                             //     TextButton(
    //                             //       onPressed: () {
    //                             //         Get.to(AdminLoginScreen());
    //                             //       },
    //                             //       child: const Text(
    //                             //         "Click here",
    //                             //         style: TextStyle(
    //                             //           color: Colors.purpleAccent,
    //                             //         ),
    //                             //       ),
    //                             //     ),
    //                             //   ],
    //                             // ),
    //                           ],
    //                         ),
    //                       )),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ));
  }
}
