
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zakwamfyp/screen/auth/login_screen/view/login_screen.dart';
import 'package:zakwamfyp/utils/colors.dart';
import '../../../../reusable_widgets/ruse_textfield.dart';
import '../../login_screen/controller/login_controller.dart';
import '../controller/signUp_conroller.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final logincontroller = Get.put(LoginController());

  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (signUpController){
          return  Container(
            height: double.infinity,
            width: double.infinity,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.signupKey123,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Stack(
                        children: [
                          signUpController.image != null? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(signUpController.image!),
                          )
                              : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(width: 1,color: Colors.white)
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:  AssetImage("assets/images/home_screen_images/bg.jpg"),
                            ),
                          ),
                          Positioned(
                            bottom: -7,
                            left: 70,
                            child: IconButton(
                              onPressed: signUpController.selectImage,
                              icon: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(Icons.add,color: AppColor.blackColor,),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("SignUp Here",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: AppColor.primary,
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      CustomeTextfield(
                        valid: (val){
                          return signUpController.validate_name(val);
                        },
                        controller: signUpController.username,
                        hinttext: "Enter Your Name",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomeTextfield(
                        valid: (val){
                          return signUpController.validate_email(val);
                        },
                        controller: signUpController.emailController,
                        hinttext: "Enter Your Email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomPasswordTextfield(
                        valid: (val){
                          return signUpController.validate_password(val);
                        },
                        controller:
                        signUpController.passwordController,
                        obscTextTrue: signUpController.isVisible,
                        hinttext: "Password",
                        suficIcons: IconButton(
                          onPressed: () {
                            signUpController.changeVisibility();
                          },
                          icon: signUpController.isVisible
                              ? Icon(Icons.visibility_off,color: AppColor.blackColor,)
                              : Icon(Icons.visibility,color: AppColor.blackColor,),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: (){

                          if(controller.image == null) {
                            Get.snackbar("Profile Picture", "Pleas select Your Profile image...",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:Colors.red,
                                colorText: Colors.white
                            );
                          }
                          else{
                            signUpController.validateForm();
                          }
                        },
                        child: controller.isLoading ? Center(child: CircularProgressIndicator(
                          color: AppColor.primary,
                        ),):Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text("SignUp",style: GoogleFonts.poppins(
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
                                logincontroller.signInWithGoogle();
                              },
                              child: Image.asset("assets/images/home_screen_images/google.png",height: 70,)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already You have an Account ",style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),),
                          InkWell(
                            onTap: (){
                              Get.to(()=>LoginScreen());
                            },
                            child: Text("Login",style: GoogleFonts.poppins(
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
}
