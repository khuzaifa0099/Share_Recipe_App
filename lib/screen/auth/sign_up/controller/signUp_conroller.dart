// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// //
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;
// import 'package:uuid/uuid.dart';
//
// import '../../../../models/user_model.dart';
// import '../../../home/view/home_screen.dart';
//
// class AddPropertyController extends GetxController {
//   Uuid uuid = Uuid();
//   final formKey = GlobalKey<FormState>();
//   var selectedImagePath = "".obs;
//   var selectedImageSize = "".obs;
//   ImagePicker imagePicker = ImagePicker();
//   File? file;
//   var downloadURL;
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   var description = TextEditingController();
//   var location = TextEditingController();
//   var price = TextEditingController();
//   var title = TextEditingController();
//   var rooms = TextEditingController();
//   var size = TextEditingController();
//   var kitchen = TextEditingController();
//   var bathroom = TextEditingController();
//   var isLoading = false.obs;
//   Future getImage(ImageSource imageSource) async {
//     final pickedFile =
//     await imagePicker.getImage(source: imageSource, imageQuality: 85);
//     if (pickedFile != null) {
//       print("get image if");
//       selectedImagePath.value = pickedFile.path;
//       file = File(pickedFile.path);
//       selectedImageSize.value =
//           ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
//               .toStringAsFixed(2) +
//               "Mb";
//     } else {
//       print("get image else");
//       Get.snackbar(
//         "Error",
//         "No image selected",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//     update();
//     print("get image upload function");
//     update();
//   }
//   uploadImageToFirebase({
//     var description,
//     var location,
//     var price,
//     var rooms,
//     var size,
//     var kitchen,
//     var bathroom,
//     var title,
//   }) async {
//     String filename = Path.basename(file!.path);
//     Reference storageReference = FirebaseStorage.instance.ref().child("posts" + filename);
//     isLoading.value = true;
//     final UploadTask uploadTask = storageReference.putFile(file!);
//     final TaskSnapshot downloadUrl = (await uploadTask);
//     print("get image upload task");
//     downloadURL = await downloadUrl.ref.getDownloadURL().whenComplete(() {
//       print("get image get url");
//       isLoading.value = false;
//       Get.snackbar("Message", "Your data uploaded succesfully",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white);
//     });
//     await addPropertyDetailsToFirestore(
//         description: description,
//         location: location,
//         price: price,
//         title: title,
//         rooms: rooms,
//         size: size,
//         kitchen: kitchen,
//         bathroom: bathroom,
//         image: downloadURL);
//     print(downloadURL.toString() + "down");
//   }
//   addPropertyDetailsToFirestore({
//     var description,
//     var location,
//     var price,
//     var title,
//     var rooms,
//     var size,
//     var kitchen,
//     var bathroom,
//     var image,
//     var publish,
//     var docid
//   }) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     User? user = _auth.currentUser;
//     PropertyModel propertyModel = PropertyModel();
//     propertyModel.uid = user!.uid;
//     propertyModel.description = description;
//     propertyModel.title = title;
//     propertyModel.price = price;
//     propertyModel.location = location;
//     propertyModel.rooms = rooms;
//     propertyModel.kitchen = kitchen;
//     propertyModel.bathroom = bathroom;
//     propertyModel.size = size;
//     propertyModel.image = image;
//     propertyModel.documentId = uuid.v1();
//     await firebaseFirestore
//         .collection("AddPropertyDetails")
//         .doc(propertyModel.documentId)
//         .set(propertyModel.toMap())
//         .then((value) {
//       Get.offAll(()=>HomeScreen());
//     });
//   }
// }


import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakwamfyp/common_controller/get_storage_controller.dart';
import 'package:zakwamfyp/screen/auth/login_screen/view/login_screen.dart';
import 'package:zakwamfyp/models/user_model.dart' as model;

class SignUpController extends GetxController{
  GlobalKey<FormState> signupKey123 = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoading = false;

  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  final TextEditingController username= TextEditingController();
  changeVisibility() {
    isVisible = !isVisible;
    update();
  }
  Uint8List? image;
  void selectImage() async{
    Uint8List im = await  pickImage(ImageSource.gallery);
      image = im;
    update();
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
  String? validate_name(val) {
    if (val.length < 3) {
      return "Please Enter Your Name minimum 3 character";
    } else {
      return null;
    }
  }
  pickImage(ImageSource source)async{
    final ImagePicker _imagepicker = ImagePicker();
    XFile? _file = await _imagepicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }
    print("no image selected");
  }
  validateForm() async{
    if (!signupKey123.currentState!.validate()) {
      log("Form Not Valid");
    } else {
      isLoading = true;
      log("Form Valid");
      // Get.to(()=>LoginScreen());
       return signUpUser();

      // changeIsLoadingStatus();
      // await login();
    }
  }
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    username.dispose();
  }
  void signUpUser() async{
    isLoading = true;
    update();
    // setState((){

    // });
    String res = await AuthResources().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: username.text,
      file: image!,
      location: '',
      bio: '',
    );
    if(res != "success"){

      Get.snackbar("User Failed", "Something is Wrong pease check Carfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.red,
          colorText: Colors.white
      );
      isLoading = false;
      update();
    }else{
      Get.to(()=>LoginScreen());
      Get.snackbar("User SignUp", "User SignUp Successfully...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.green,
          colorText: Colors.white
      );
      isLoading = false;
      update();
    }

    // isLoading = false;

  }



  showSnackBar(String content, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
  }
}
class AuthResources{
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  Future<model.UserModel> getUserDetails()async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore
        .collection('user')
        .doc(currentUser.uid)
        .get();
    return model.UserModel.fromMap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String location,
    required String bio,
    required Uint8List file,
  }) async{
    String res = "some error occurred";
    try{
      {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
        print(cred.user!.uid);
        String  photoUrl = await StorageResource().
        uploadImageToStorage('profilePic', file, false);
        model.UserModel user = model.UserModel(
          username: username,
          uid : cred.user!.uid,
          email: email,
          location: location,
          bio : bio,
          photoUrl : photoUrl,
        );
        await _firestore.collection('user').doc(cred.user!.uid).set(user.toMap());
        res = "success";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
  Future<String> loginUser({
    required String email,
    required String password,
  })async{
    String res = "some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(
            email: email,
            password: password);
        res = "success";
      }else{
        res = "please enter all the fields";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
}