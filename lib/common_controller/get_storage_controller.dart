import 'dart:developer';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../screen/auth/login_screen/view/login_screen.dart';

class StorageResource{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost)async{
    Reference  ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if(isPost){
      String id =  Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}




class GetStorageController extends GetxController implements GetxService {
  final box = GetStorage();


  @override
  void onInit() {
    imageurl.value = readStorage("image").toString();
    pImageurl.value = readStorage("image").toString();
    // username.value = readStorage("username");

    username.value = readStorage("username").toString();
    uID.value = readStorage("uid").toString();
    super.onInit();
  }
  var imageurl = "".obs;
  var pImageurl = "".obs;
  var uID = "".obs;
  var username = "".obs;
  bool isHavingData = false;

  ToggleIsHavingData(bool value) {
    isHavingData = value;
    update();
  }

  Future<void> initstorage() async {
    await GetStorage().initStorage;
    // box.writeIfNull("country_code", "us");
    // print("country code is ${box.read("country_code")}");
  }

  String? writeStorage(String key, String value) {
    box.write(key, value);
    return null;
  }


  String? readStorage(String key) {
    return box.read(key);
  }

  Future<void> removeStorage() async {
    log("<--------------Get Storage Remove Before-------------->");
    log(box.getKeys().toString());
    log(box.getValues().toString());
    FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(()=>LoginScreen());
    });
    await box.erase().then((value) async {
      ToggleIsHavingData(false);
      print("remove storage");
      update();

    });
    log("<--------------Get Storage Remove After-------------->");
    log(box.getKeys().toString());
    log(box.getValues().toString());
  }

}