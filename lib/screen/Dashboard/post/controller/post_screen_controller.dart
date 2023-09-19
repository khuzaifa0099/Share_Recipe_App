import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import 'package:zakwamfyp/reusable_widgets/reuse_buttom_navigationbar.dart';
import '../../../../common_controller/get_storage_controller.dart';
import '../../../../models/add_recipe_model.dart';
import '../../home/screen/home_screen.dart';


class AddPropertyController extends GetxController {

  Uuid uuid = Uuid();
  final formKey = GlobalKey<FormState>();
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  ImagePicker imagePicker = ImagePicker();

  File? file;
  var downloadURL;

  var selectedImagePath2 = "".obs;
  var selectedImageSize2 = "".obs;
  ImagePicker imagePicker2 = ImagePicker();

  File? file2;
  var downloadURL2;

  var selectedImagePath3 = "".obs;
  var selectedImageSize3 = "".obs;
  ImagePicker imagePicker3 = ImagePicker();

  File? file3;
  var downloadURL3;


  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var title = TextEditingController();
  var server = TextEditingController();
  var cooktime = TextEditingController();
  var igredient1 = TextEditingController();
  var igredient2 = TextEditingController();
  var step2 = TextEditingController();
  var step3 = TextEditingController();
  var step4 = TextEditingController();
  var description = TextEditingController();
  var isfavorite = TextEditingController();


  Future getImage(ImageSource imageSource) async {
    final pickedFile = await imagePicker.pickImage(source: imageSource, imageQuality: 85);
    if (pickedFile != null) {
      print("get image if");
      selectedImagePath.value = pickedFile.path;
      file = File(pickedFile.path);
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
              "Mb";
    } else {
      print("get image else");
      Get.snackbar(
        "Error",
        "No image selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
    print("get image upload function");
    update();

  }
  Future getImage2(ImageSource imageSource) async {
    final pickedFile = await imagePicker2.pickImage(source: imageSource, imageQuality: 85);
    if (pickedFile != null) {
      print("get image if");
      selectedImagePath2.value = pickedFile.path;
      file2 = File(pickedFile.path);
      selectedImageSize2.value =
          ((File(selectedImagePath2.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
              "Mb";
    } else {
      print("get image else");
      Get.snackbar(
        "Error",
        "No image selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
    print("get image upload function");
    update();

  }
  Future getImage3(ImageSource imageSource) async {
    final pickedFile = await imagePicker3.pickImage(source: imageSource, imageQuality: 85);
    if (pickedFile != null) {
      print("get image if");
      selectedImagePath3.value = pickedFile.path;
      file3 = File(pickedFile.path);
      selectedImageSize3.value =
          ((File(selectedImagePath3.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
              "Mb";
    } else {
      print("get image else");
      Get.snackbar(
        "Error",
        "No image selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
    print("get image upload function");
    update();

  }

  uploadImageToFirebase({
    var title,
    var server,
    var cooktime,
    var igredient1,
    var igredient2,
    var step2,
    var step3,
    var step4,
    var description,
  }) async {
    String filename = Path.basename(file!.path);
    String filename2 = Path.basename(file2!.path);
    String filename3 = Path.basename(file3!.path);
    Reference storageReference = FirebaseStorage.instance.ref().child("posts" + filename);
    Reference storageReference2 = FirebaseStorage.instance.ref().child("posts" + filename2);
    Reference storageReference3 = FirebaseStorage.instance.ref().child("posts" + filename3);
    isLoading.value = true;
    final UploadTask uploadTask = storageReference.putFile(file!);
    final UploadTask uploadTask2 = storageReference2.putFile(file2!);
    final UploadTask uploadTask3 = storageReference3.putFile(file3!);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final TaskSnapshot downloadUrl2 = (await uploadTask2);
    final TaskSnapshot downloadUrl3 = (await uploadTask3);
    print("get image upload task");

    downloadURL = await downloadUrl.ref.getDownloadURL().whenComplete(() {
      print("get image get url");
      isLoading.value = false;
      Get.snackbar("Message", "Your data uploaded succesfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
    downloadURL2 = await downloadUrl2.ref.getDownloadURL().whenComplete(() {});
    downloadURL3 = await downloadUrl3.ref.getDownloadURL().whenComplete(() {});

    await addPropertyDetailsToFirestore(

      description: description,
      title: title,
      server: server,
      cooktime: server,
      igredient1: igredient1,
      igredient2: igredient2,
      step2: step2,
      step3: step3,
      step4: step4,
      image: downloadURL,
      image2: downloadURL2,
      image3: downloadURL3,
    );
    print(downloadURL.toString() + "down");
    print(downloadURL2.toString() + "down");
    print(downloadURL3.toString() + "down");
  }




  addPropertyDetailsToFirestore({
    var description,
    var title,
    var server,
    var cooktime,
    var igredient1,
    var igredient2,
    var step2,
    var step3,
    var step4,
    var image,
    var image2,
    var image3,
    var docid
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    RecippeModel recippeModel = RecippeModel();
    recippeModel.uid = user!.uid;
    recippeModel.description = description;
    recippeModel.title = title;
    recippeModel.server = server;
    recippeModel.cooktime = cooktime;
    recippeModel.igredient1 = igredient1;
    recippeModel.igredient2 = igredient2;
    recippeModel.step2 = step2;
    recippeModel.step3 = step3;
    recippeModel.step4 = step4;
    recippeModel.image = image;
    recippeModel.image2 = image2;
    recippeModel.image3 = image3;
    recippeModel.username = Get.find<GetStorageController>().box.read("UserName").toString();
    recippeModel.photoUrl = Get.find<GetStorageController>().box.read("Image").toString();
    recippeModel.email = Get.find<GetStorageController>().box.read("Email").toString();
    recippeModel.documentId = uuid.v1();
    await firebaseFirestore
        .collection("RecippeModel")
        .doc(recippeModel.documentId)
        .set(recippeModel.toMap())
        .then((value) {
      Get.offAll(()=>BottomNavigationBarScreen());

    });
  }
}