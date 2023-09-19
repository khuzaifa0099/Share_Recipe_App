import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_controller/get_storage_controller.dart';
import '../../../../models/add_recipe_model.dart';
import '../../../../utils/colors.dart';
import '../../home/screen/detailes_screen.dart';
import '../../profile/controller/profile_screen_controller.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}
class _FavoriteScreenState extends State<FavoriteScreen> {

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
        Get.find<GetStorageController>()
            .writeStorage("Email", value.docs[0]['email'].toString());
      });
    }).then((value) {
      controller.userNameController.text =
          Get.find<GetStorageController>().box.read("UserName").toString();
      controller.imageController.text =
          Get.find<GetStorageController>().box.read("Image").toString();
      controller.emailController.text =
          Get.find<GetStorageController>().box.read("Email").toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Favorite Screen",style: GoogleFonts.poppins(fontSize: 30),),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("FavoritedRecipes").
                doc(FirebaseAuth.instance.currentUser!.uid).
                collection("Recipes").get(),
                builder:(context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return ListView.builder(itemBuilder: (context, index){
                      Shimmer.fromColors(
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
                      ),);
                    });
                  }
                  else if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      QuerySnapshot data = snapshot.data as QuerySnapshot;
                      if(data != null){
                        return GridView.builder(
                            itemCount: data.docs.length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              mainAxisExtent: 270,
                            ),
                            itemBuilder: (BuildContext context, int index){
                              var indexx = snapshot.data!.docs[index];
                              print(data.docs.length.toString());
                              RecippeModel recippeModel = RecippeModel.fromMap(
                                  data.docs[index].data()
                                  as Map<String, dynamic>);
                              log( recippeModel.title.toString());
                              return InkWell(
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
                                child: Container(
                                  // width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: AppColor.whitekColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(recippeModel.image),
                                                fit: BoxFit.fill
                                            )
                                        ),
                                        child:   Padding(
                                          padding: const EdgeInsets.only(top: 20,right: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    recippeModel.isFavorite = !recippeModel.isFavorite;
                                                  });

                                                  CollectionReference favoritedRecipesCollection = FirebaseFirestore.instance.collection("FavoritedRecipes");

                                                  if (recippeModel.isFavorite == true) {
                                                    // Store the favorited recipe in Firestore
                                                    await favoritedRecipesCollection
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .collection("Recipes")
                                                        .doc(recippeModel.documentId) // Unique identifier for the favorited recipe
                                                        .set(recippeModel.toMap()).then((value) {
                                                      Get.snackbar("Favourite Recipe", "Your Recipe has been Favourite",
                                                          snackPosition: SnackPosition.BOTTOM,
                                                          backgroundColor: Colors.green,
                                                          colorText: Colors.white);
                                                    });
                                                  } else {
                                                    // Remove the favorited recipe from Firestore
                                                    await favoritedRecipesCollection
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .collection("Recipes")
                                                        .doc(recippeModel.documentId)
                                                        .delete().then((value) {
                                                      Get.snackbar("Delete Recipe", "Your Recipe has been deleted from Favourite",
                                                          snackPosition: SnackPosition.BOTTOM,
                                                          backgroundColor: Colors.red,
                                                          colorText: Colors.white);
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Color(0xffD3ECEC),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3),
                                                    child: Icon(
                                                      Icons.favorite,
                                                      size: 20,
                                                      color: recippeModel.isFavorite == true ? Colors.red : Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    recippeModel.isSaved = !recippeModel.isSaved;
                                                  });

                                                  CollectionReference savedRecipesCollection = FirebaseFirestore.instance.collection("SavedRecipes");

                                                  if (recippeModel.isSaved == true) {
                                                    // Store the favorited recipe in Firestore
                                                    await savedRecipesCollection
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .collection("Recipes")
                                                        .doc(recippeModel.documentId) // Unique identifier for the favorited recipe
                                                        .set(recippeModel.toMap()).then((value) {
                                                      Get.snackbar("Save Recipe", "Your Recipe has been save",
                                                          snackPosition: SnackPosition.BOTTOM,
                                                          backgroundColor: Colors.green,
                                                          colorText: Colors.white);
                                                    });
                                                  } else {
                                                    // Remove the favorited recipe from Firestore
                                                    await savedRecipesCollection
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .collection("Recipes")
                                                        .doc(recippeModel.documentId)
                                                        .delete().then((value) {
                                                      Get.snackbar("Delete Recipe", "Your Recipe has been deleted from save",
                                                          snackPosition: SnackPosition.BOTTOM,
                                                          backgroundColor: Colors.red,
                                                          colorText: Colors.white);

                                                    });
                                                  }}, child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Color(0xffD3ECEC)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Image.asset("assets/images/home_screen_images/Saved.png",height: 20,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage( controller.imageController.text.toString()),
                                                ):  CircleAvatar(
                                                  backgroundImage: NetworkImage( recippeModel.photoUrl.toString()),
                                                ),
                                                SizedBox(width: 5,),
                                                Expanded(
                                                  child: recippeModel.uid.toString() == FirebaseAuth.instance.currentUser!.uid.toString()?
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
                                            Text(recippeModel.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppColor.blackColor,
                                              ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8,)
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      else {
                        return Center(
                          child: Text("No Recipes found."),
                        );
                      }
                    }
                    else if(snapshot.hasError){
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    else{
                      return Center(child: Text("Somethings is Wrong"));
                    }
                  }
                  return Text('No data');

                }
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
