import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakwamfyp/screen/Dashboard/profile/screen/user_detailes_profile_screen.dart';
import '../../../../common_controller/get_storage_controller.dart';
import '../../../../models/add_recipe_model.dart';

class ProfileScreenController extends GetxController{
  bool isLoading = false;
  var auth = FirebaseAuth.instance;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  profileUpdate({var file}) async {
    String  photoUrl = await StorageResource().
    uploadImageToStorage('profilePic', file, false);
    var collection = FirebaseFirestore.instance.collection("user");
    return await collection
        .doc((FirebaseAuth.instance.currentUser!).uid)
        .update({
      "username":userNameController.text,
      // "email":emailController.text,
      "location":locationController.text,
      "bio":bioController.text,
      "photoUrl" : photoUrl,
      // "photoUrl" :  imageController,
    }) // <-- Updated data
        .then((_) {
      Get.snackbar("Profile Update", "Profile Updated Successfully...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.green,
          colorText: Colors.white
      );
      Get.to(()=>UserDetaileProfile());

    }).catchError((error) {});

  }
  Future<List<RecippeModel>> fetchUserRecipes() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("RecippeModel")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    final recipes = snapshot.docs
        .map((doc) => RecippeModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return recipes;
  }
}