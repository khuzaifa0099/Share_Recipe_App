// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:improvescap/generated/assert.dart';
// import 'package:improvescap/utils/colors.dart';
// import 'dart:math' as math;
// import '../../home/view/home_screen.dart';
// import '../login_screen/view/login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3),
//             () {
//           FirebaseAuth.instance.authStateChanges().listen((User? user)
//           {
//             if(user==null)
//             {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder:
//                       (context) => LoginScreen()
//                   )
//               );
//               //  Get.offAll(() =>  NameRegistration());
//
//             }
//             else{
//                   Get.offAll(()=>HomeScreen());
//             }
//           });
//
//         }
//
//
//
//
//             // ()=>  Navigator.pushReplacement(context,
//             //     MaterialPageRoute(builder:
//             //         (context) => LoginScreen()
//             //     )
//             // )
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.blackColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 25),
//           child: Center(
//             child: Image.asset(ImageConstant.logoImage),
//           ),
//         )
//       ),
//     );
//   }
// }
//
//
//
