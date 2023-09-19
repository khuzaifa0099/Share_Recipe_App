import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zakwamfyp/reusable_widgets/reuse_buttom_navigationbar.dart';
import 'package:zakwamfyp/screen/Dashboard/home/screen/home_screen.dart';
import 'package:zakwamfyp/screen/auth/login_screen/view/login_screen.dart';

import 'common_controller/get_storage_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
Future<void> initServices() async {
  await Get.put(GetStorageController()).initstorage();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? BottomNavigationBarScreen()
          : LoginScreen(),
      // home: LoginScreen(),
    );
  }
}
