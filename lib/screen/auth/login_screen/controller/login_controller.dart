import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../models/user_model.dart';
import '../../../../reusable_widgets/reuse_buttom_navigationbar.dart';
import '../../sign_up/controller/signUp_conroller.dart';

class LoginController extends GetxController{
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final loginFormKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoading = false;
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  changeVisibility() {
    isVisible = !isVisible;
    update();
  }



 // final storage = FlutterSecureStorage();
 //  FirebaseAuth auth = FirebaseAuth.instance;
 //  final FirebaseAuth _auth = FirebaseAuth.instance;
 //  final controller = Get.put(LoginController());




  signInWithGoogle()async{
    final  GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
      var currentuser = await FirebaseFirestore.instance
          .collection("user")
          .where('email', isEqualTo:  FirebaseAuth.instance.currentUser!.email.toString())
          .get();
      final List<DocumentSnapshot> documents = currentuser.docs;
      if (documents.length > 0)
      {
        Get.to(()=>BottomNavigationBarScreen());
        Get.snackbar("Google Login", "Google login Successfully...",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor:Colors.green,
            colorText: Colors.white
        );
      } else {
        FirebaseAuth _auth = FirebaseAuth.instance;
        User? user = _auth.currentUser;
        UserModel newuser = UserModel(
          username: user!.displayName.toString(),
          uid : user.uid,
          email: user.email.toString(),
          photoUrl : user.photoURL.toString(),
          location: '',
          bio: '',
        );
        await FirebaseFirestore.instance
            .collection("user")
            .doc(user.uid)
            .set(newuser.toMap())
            .then((value) {
          Get.to(()=>BottomNavigationBarScreen());
          Get.snackbar("Google Login", "Google login Successfully...",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor:Colors.green,
              colorText: Colors.white
          );
        });

      }



    });
  }

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void loginUser()async {

      isLoading = true;
      update();
    String res = await AuthResources().loginUser(
        email: emailController.text,
        password: passwordController.text);
    if(res == "success"){
      Get.offAll(()=>BottomNavigationBarScreen());
      Get.snackbar("User Login", "User Login Successfully...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.green,
          colorText: Colors.white
      );
    }else{
      Get.snackbar("Something is Wrong", "Check Email or Password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.red,
          colorText: Colors.white
      );
    }
      isLoading = false;
    update();
  }

}

