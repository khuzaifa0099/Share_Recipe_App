import 'package:flutter/material.dart';
class HomeScreenModel {
  String image,name,personimage,recipee_name,description;
  HomeScreenModel(this.image,this.name,this.personimage,this.recipee_name,this.description);
/////
}

final List<String> image= [
  "assets/images/home_screen_images/recipe1.jpg",
  "assets/images/home_screen_images/recipe2.jpg",
  "assets/images/home_screen_images/recipe3.jpg",
  "assets/images/home_screen_images/recipe4.jpg",
  "assets/images/home_screen_images/recipe5.jpg",
  "assets/images/home_screen_images/recipe6.jpg",
];
List name = [
  "zakwon ktk khan uni",
  "khuzaifa khan",
  "khalid Khan",
  "Tahir Khan",
  "adnan khan",
  "inam khan",


];
List<String>  personimage= [
  "assets/images/home_screen_images/person1.jpg",
  "assets/images/home_screen_images/person2.jpg",
  "assets/images/home_screen_images/person3.jpg",
  "assets/images/home_screen_images/person4.jpg",
  "assets/images/home_screen_images/person5.jpg",
  "assets/images/home_screen_images/person6.jpg",

];

List recipee_name= [
  "Chiken best one Recipee",
  "pizza best one Recipee",
  "Rice best one Recipee",
  "egg bets one Recipee",
  "Chiken best one Recipee",
  "Chiken bets one Recipee",

];
List description= [
  "Chiken best one Recipee for students they all thing about etc etc",
  "Chiken best one Recipee for students they all thing about etc etc",
  "Chiken best one Recipee for students they all thing about etc etc",
  "Chiken best one Recipee for students they all thing about etc etc",
  "Chiken best one Recipee for students they all thing about etc etc",
  "Chiken best one Recipee for students they all thing about etc etc",


];



final List<HomeScreenModel> homeScreenModel = List.generate(
    image.length,
        (index) => HomeScreenModel(
          '${image[index]}',
         '${name[index]}',
         '${personimage[index]}',
         '${recipee_name[index]}',
         '${description[index]}',
    )
);