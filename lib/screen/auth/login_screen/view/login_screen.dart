import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zakwamfyp/reusable_widgets/reuse_buttom_navigationbar.dart';
import 'package:zakwamfyp/utils/colors.dart';

import '../../../../reusable_widgets/ruse_textfield.dart';
import '../../sign_up/view/sign_sp_screen.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key,}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  final loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
            init: LoginController(),
        builder: (loginController){
              return
                Container(
                height: double.infinity,
                width: double.infinity,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 140,
                          ),
                          Text("Login Here",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            color: AppColor.primary,
                          ),),
                          SizedBox(
                            height: 20,
                          ),
                          CustomeTextfield(
                            valid: (val){
                             return validate_email(val);
                              },
                            controller: loginController.emailController,
                            hinttext: "Enter Your Email",
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomPasswordTextfield(
                            valid: (val){
                             return validate_password(val);
                              },
                            controller:
                            loginController.passwordController,
                            obscTextTrue: loginController.isVisible,
                            hinttext: "Password",
                            suficIcons: IconButton(
                              onPressed: () {
                                loginController.changeVisibility();
                              },
                              icon: loginController.isVisible
                                  ? Icon(Icons.visibility_off,color: AppColor.blackColor,)
                                  : Icon(Icons.visibility,color: AppColor.blackColor,),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: (){
                              // Get.to(()=>ForgetScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Forgot password ?",style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppColor.primary,
                                ),),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: (){
                             validateForm();
                            },
                            child: isLoading ? Center  (child: CircularProgressIndicator(
                              color: AppColor.primary,
                            ),) : Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text("Login",style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColor.primary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Or sign in with",style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColor.primary,
                                ),),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: (){
                                    loginController.signInWithGoogle();
                                  },
                                  child: Image.asset("assets/images/home_screen_images/google.png",height: 70,)),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Account ",style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),),
                              InkWell(
                                onTap: (){
                                  Get.to(()=>SignUpScreen());
                                },
                                child: Text("SignUp",style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary
                                ),),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
        },
      ),


    );
  }

  validateForm() async {
    if (!loginFormKey.currentState!.validate()) {
      log("Form Not Valid");
    } else {
      isLoading = true;
      log("Form Valid");
      // Get.to(()=>BottomNavigationBarScreen());
      return controller.loginUser();

      // changeIsLoadingStatus();
      // return login();
    }
  }

  String? validate_email(val) {
    bool emailValid =
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val);
    if (val.isEmpty) {
      return "Please Enter your email";
    } else if (emailValid == false) {
      return "email is not valid";
    } else
      return null;
  }

  String? validate_password(val) {
    if (val.length < 6) {
      return "please Enter minimum 6 character";
    } else {
      return null;
    }
  }
}
