import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakwamfyp/reusable_widgets/reuse_buttom_navigationbar.dart';
import 'package:zakwamfyp/screen/Dashboard/profile/screen/profile_screen.dart';
import 'package:zakwamfyp/screen/auth/login_screen/controller/login_controller.dart';
import 'package:zakwamfyp/screen/auth/sign_up/controller/signUp_conroller.dart';
import '../../../../common_controller/get_storage_controller.dart';
import '../../../../utils/colors.dart';
import '../controller/profile_screen_controller.dart';


class UserDetaileProfile extends StatefulWidget {
  const UserDetaileProfile({Key? key}) : super(key: key);

  @override
  State<UserDetaileProfile> createState() => _UserDetaileProfileState();
}

class _UserDetaileProfileState extends State<UserDetaileProfile> {
  @override
  void initState() {
    getCurrentUserData().then((value) {});

  }
  var profileControler = Get.put(ProfileScreenController());
  // var _image;
  Future<void> getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('user')
        .where("uid", isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        Get.find<GetStorageController>()
            .writeStorage("UserName", value.docs[0]['username'].toString());
        Get.find<GetStorageController>()
            .writeStorage("Email", value.docs[0]['email'].toString());
        Get.find<GetStorageController>().writeStorage(
            "location", value.docs[0]['location'].toString());
        Get.find<GetStorageController>()
            .writeStorage("bio", value.docs[0]['bio'].toString());
        Get.find<GetStorageController>()
            .writeStorage("Image", value.docs[0]['photoUrl'].toString());
      });
    }).then((value) {
      setState(() {
        profileControler.userNameController.text =
            Get.find<GetStorageController>().box.read("UserName").toString();
        profileControler.emailController.text =
            Get.find<GetStorageController>().box.read("Email").toString();
        profileControler.locationController.text =
            Get.find<GetStorageController>().box.read("location").toString();

        profileControler.bioController.text =
            Get.find<GetStorageController>().box.read("bio").toString();
        profileControler.imageController.text =
            Get.find<GetStorageController>().box.read("Image").toString();
      });
    });
  }

  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: (){
                          Get.to(()=>BottomNavigationBarScreen());
                        },
                        child: Icon(Icons.keyboard_arrow_left,size: 30,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.find<GetStorageController>().removeStorage();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1)
                        ),
                        child: Center(
                          child: Text("LogOut",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColor.blackColor,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20
                ),
                GetBuilder<SignUpController>(
                  init: SignUpController(),
                  builder: (controllerr) {
                    return Stack(
                      children: [
                        controllerr.image != null
                            ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(controllerr.image!),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border:
                              Border.all(width: 1, color: Colors.white)),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                profileControler.imageController.text),
                          ),
                        ),
                      ],
                    );
                  }
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      controller.selectImage();
                    });
                  },
                  child: Center(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Change Photo",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColor.blackColor,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Name",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),),
                      ),
                      TextFormField(
                        controller: profileControler.userNameController,
                        decoration: InputDecoration(

                          // hintText: profileControler.userNameController.text,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Email",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),),
                      ),
                      TextFormField(
                        controller: profileControler.emailController,
                        decoration: InputDecoration(
                          // hintText: profileControler.emailController.text.toString(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Location",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),),
                      ),
                      TextFormField(
                        controller: profileControler.locationController,
                        decoration: InputDecoration(
                          // hintText: profileControler.locationController.text.toString(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Biography",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),),
                      ),
                      TextFormField(
                        controller: profileControler.bioController,
                        decoration: InputDecoration(
                          // hintText: profileControler.bioController.text.toString(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: (){
                          if(controller.image == null) {
                            Get.snackbar("Profile Update", "Pleas select image...",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:Colors.red,
                                colorText: Colors.white
                            );
                          }
                          else{
                            profileControler.profileUpdate(file:  controller.image);
                          }
                        },
                        child: profileControler.isLoading ? Center(child: CircularProgressIndicator(
                          color: AppColor.primary,
                        )) : Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text("Update",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColor.blackColor,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}