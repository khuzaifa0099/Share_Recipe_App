import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakwamfyp/utils/colors.dart';
import '../controller/post_screen_controller.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddPropertyController>(
        init: AddPropertyController(),
        builder: (addPropertyController){
          return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => Stack(
                      children: [
                        Get.find<AddPropertyController>()
                            .selectedImagePath
                            .value ==
                            ""
                            ? Container(
                          width: Get.width,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/home_screen_images/post_reipppe.PNG",
                                  ),
                                  fit: BoxFit.fill)),
                        )
                            : Image.file(
                            File(Get.find<AddPropertyController>()
                                .selectedImagePath
                                .value),
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              Get.find<AddPropertyController>()
                                  .getImage(ImageSource.gallery);
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.image_rounded,size: 35,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: addPropertyController.title,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500
                            ),
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500
                                ),
                                hintText: "Enter Recipe Title"
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: addPropertyController.description,
                            decoration: InputDecoration(
                                hintText: "Add Description here"
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Add recipe orign",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.grey,
                              ),),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("Serves",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: addPropertyController.server,
                                  decoration: InputDecoration(
                                      hintText: "Enter People"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("Cook time",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: addPropertyController.cooktime,
                                  decoration: InputDecoration(
                                      hintText: "Enter time"
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Ingredients",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,

                              ),),
                          ),
                          TextFormField(
                            controller: addPropertyController.igredient1,
                            decoration: InputDecoration(
                                hintText: "Enter Ingredient1"
                            ),
                          ),
                          TextFormField(
                            controller: addPropertyController.igredient2,
                            decoration: InputDecoration(
                                hintText: "Enter Ingredient 2"
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Method",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,

                              ),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height:20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("1",style: TextStyle(color: Colors.white,fontSize: 16),)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Enter Step one as image",style: TextStyle(color: Colors.black,fontSize: 16),)

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(()=>
                                  Container(
                                    child: Get.find<AddPropertyController>()
                                        .selectedImagePath2
                                        .value ==
                                        ""
                                        ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF7F6F2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.find<AddPropertyController>()
                                              .getImage2(ImageSource.gallery);
                                        },
                                        child: Icon(Icons.camera_alt_outlined),
                                      ),
                                    )
                                        : Image.file(
                                        File(Get.find<AddPropertyController>()
                                            .selectedImagePath2
                                            .value),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill),
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height:20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("2",style: TextStyle(color: Colors.white,fontSize: 16),)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: addPropertyController.step2,
                                  decoration: InputDecoration(
                                      hintText: "Enter Step number two"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height:20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("3",style: TextStyle(color: Colors.white,fontSize: 16),)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: addPropertyController.step3,
                                      decoration: InputDecoration(
                                          hintText: "Enter Step number three"
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(()=>
                                  Container(
                                    child: Get.find<AddPropertyController>()
                                        .selectedImagePath3
                                        .value ==
                                        ""
                                        ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF7F6F2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.find<AddPropertyController>()
                                              .getImage3(ImageSource.gallery);
                                        },
                                        child: Icon(Icons.camera_alt_outlined),
                                      ),
                                    )
                                        : Image.file(
                                        File(Get.find<AddPropertyController>()
                                            .selectedImagePath3
                                            .value),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill),
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height:20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("4",style: TextStyle(color: Colors.white,fontSize: 16),)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: addPropertyController.step4,
                                  decoration: InputDecoration(
                                      hintText: "Enter Step number four"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(()=>addPropertyController.isLoading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primary,
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        if (
                           addPropertyController.selectedImagePath.value == "" ||
                           addPropertyController.selectedImagePath2.value == "" ||
                           addPropertyController.selectedImagePath3.value == "" ||
                            addPropertyController.cooktime.text == "" ||
                            addPropertyController.server.text == "" ||
                            addPropertyController.igredient1.text == "" ||
                            addPropertyController.description.text == "" ||
                            addPropertyController.igredient2.text == "" ||
                            addPropertyController.step2.text == "" ||
                            addPropertyController.step3.text == "" ||
                            addPropertyController.step4.text == "" ||
                            addPropertyController.title.text ==  ""
                        )
                        {
                          print("if error");
                          Get.snackbar(
                            "Error",
                            "One of your field is not selected",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          addPropertyController.uploadImageToFirebase(
                            title: addPropertyController.title.text,
                            server: addPropertyController.server.text,
                            cooktime: addPropertyController.cooktime.text,
                            igredient1: addPropertyController.igredient1.text,
                            description: addPropertyController.description.text,
                            igredient2: addPropertyController.igredient2.text,
                            step2: addPropertyController.step2.text,
                            step3: addPropertyController.step3.text,
                            step4: addPropertyController.step4.text,
                          );
                        }
                      },
                      child: Container(
                        height: Get.height * 0.07,
                        width: Get.width,
                        //   margin: EdgeInsets.symmetric(horizontal: Get.height*0.04),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius:
                            BorderRadius.circular(Get.height * 0.010)),
                        child: Text(
                          "Add",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Get.height * 0.022,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}