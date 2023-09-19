import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zakwamfyp/models/add_recipe_model.dart';
import 'package:zakwamfyp/screen/Dashboard/home/screen/detailes_screen.dart';


import '../../../../common_controller/get_storage_controller.dart';
import '../../../../utils/colors.dart';
import '../../profile/controller/profile_screen_controller.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(ProfileScreenController());
  void initState() {
    getCurrentUserData().then((value) {});
  }
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
            .writeStorage("Image", value.docs[0]['photoUrl'].toString());
      });
    }).then((value) {
      controller.userNameController.text =
          Get.find<GetStorageController>().box.read("UserName").toString();
      controller.imageController.text =
          Get.find<GetStorageController>().box.read("Image").toString();
    });
  }

  TextEditingController searchController = TextEditingController();

  List searchResult = [];

  void searchFromFirebase(String query) async{
    final result = await FirebaseFirestore.instance.collection("RecippeModel").where(
        "title",
        isEqualTo: query
    ).get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title:
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.grey)
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: (value){
                setState(() {

                });
              },

              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: "Search Recipee",
                  border: InputBorder.none
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<QuerySnapshot?>(
                    future: FirebaseFirestore.instance.collection("RecippeModel").get(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return
                          ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index){
                                return Shimmer.fromColors(
                                  baseColor: Color(0xffD3ECEC),
                                  highlightColor:Color(0xffD3ECEC),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(height: 10, width: 90,color: Colors.white,),
                                        subtitle: Container(height: 10, width: 90,color: Colors.white,),
                                        leading: Container(height: 50, width: 50,color: Colors.white,),
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                      }
                      else {
                        QuerySnapshot data = snapshot.data as QuerySnapshot;
                        return
                          ListView.builder(
                              itemCount: data.docs.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var indexx = snapshot.data!.docs[index];
                                print(data.docs.length.toString());
                                RecippeModel recippeModel =
                                RecippeModel.fromMap(
                                    data.docs[index].data()
                                    as Map<String, dynamic>);
                                log( recippeModel.title.toString());
                                String search = snapshot.data!.docs[index]['title'];
                                if(searchController.text.isEmpty){
                                  return
                                    InkWell(
                                      onTap: (){
                                        Get.to(()=>DetailesScreen(
                                          imag: recippeModel.image.toString(),
                                          imag2: recippeModel.image2.toString(),
                                          imag3: recippeModel.image3.toString(),
                                          recipee_name: recippeModel.title.toString(),
                                          personimage: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.imageController.text.toString() : recippeModel.photoUrl.toString(),
                                          name: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.userNameController.text.toString() : recippeModel.username.toString(),
                                          email: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.emailController.text.toString() : recippeModel.email.toString(),
                                          description:  recippeModel.description.toString(),
                                          cooktime: recippeModel.cooktime.toString(),
                                          server: recippeModel.server.toString(),
                                          ing2: recippeModel.igredient2.toString(),
                                          ing1: recippeModel.igredient1.toString(),
                                          step2: recippeModel.step2.toString(),
                                          step3: recippeModel.step3.toString(),
                                          step4: recippeModel.step4.toString(),
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Card(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: MediaQuery.of(context).size.width * 0.36,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    image: DecorationImage(
                                                        image: NetworkImage(recippeModel.image),
                                                        fit: BoxFit.fill
                                                    )
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(recippeModel.title,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 18,
                                                        color: AppColor.blackColor,
                                                      ),),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
                                                        CircleAvatar(
                                                          backgroundImage: NetworkImage( controller.imageController.text.toString()),
                                                        ):  CircleAvatar(
                                                          backgroundImage: NetworkImage( recippeModel.photoUrl.toString()),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child:recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
                                                          Text(controller.userNameController.text.toString(),style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 13,
                                                            color: AppColor.blackColor,
                                                          ),):
                                                          Text(recippeModel.username.toString().toString(),style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 13,
                                                            color: AppColor.blackColor,
                                                          ),),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(recippeModel.description.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 13,
                                                        color: AppColor.blackColor,
                                                      ),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                }
                                else if(search.toLowerCase().contains(searchController.text.toLowerCase())){
                                  return
                                    InkWell(
                                    onTap: (){
                                      Get.to(()=>DetailesScreen(
                                        imag: recippeModel.image.toString(),
                                        imag2: recippeModel.image2.toString(),
                                        imag3: recippeModel.image3.toString(),
                                        recipee_name: recippeModel.title.toString(),
                                        personimage: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.imageController.text.toString() : recippeModel.photoUrl.toString(),
                                        name: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.userNameController.text.toString() : recippeModel.username.toString(),
                                        email: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString() ? controller.emailController.text.toString() : recippeModel.email.toString(),
                                        description:  recippeModel.description.toString(),
                                        cooktime: recippeModel.cooktime.toString(),
                                        server: recippeModel.server.toString(),
                                        ing2: recippeModel.igredient2.toString(),
                                        ing1: recippeModel.igredient1.toString(),
                                        step2: recippeModel.step2.toString(),
                                        step3: recippeModel.step3.toString(),
                                        step4: recippeModel.step4.toString(),
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Card(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 150,
                                              width: MediaQuery.of(context).size.width * 0.36,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(recippeModel.image),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(recippeModel.title,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18,
                                                      color: AppColor.blackColor,
                                                    ),),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage( controller.imageController.text.toString()),
                                                      ):  CircleAvatar(
                                                        backgroundImage: NetworkImage( recippeModel.photoUrl.toString()),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child:recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
                                                       Text(controller.userNameController.text.toString(),style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 13,
                                                          color: AppColor.blackColor,
                                                        ),):
                                                          Text(recippeModel.username.toString().toString(),style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                              color: AppColor.blackColor,
                                            ),),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(recippeModel.description.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                      color: AppColor.blackColor,
                                                    ),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
