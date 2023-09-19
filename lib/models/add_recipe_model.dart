import 'package:zakwamfyp/models/user_model.dart';

class RecippeModel {
  String ? documentId;
  String? description;
  var image;
  var image2;
  var image3;
  String? uid;
  var title;
  var server;
  var cooktime;
  var igredient1;
  var igredient2;
  var step2;
  var step3;
  var step4;
  var username;
  var photoUrl;
  var email;
  var isFavorite;
  var isSaved;
  RecippeModel(
      {
        this.description,
        this.uid,
        this.image,
        this.image2,
        this.image3,
        this.title,
        this.server,
        this.cooktime,
        this.igredient1,
        this.igredient2,
        this.step2,
        this.step3,
        this.step4,
        this.documentId,
        this.email,
        this.photoUrl,
        this.username,
        this.isFavorite,
        this.isSaved,

      });

  factory RecippeModel.fromMap(map) {
    return RecippeModel(
      uid: map["uid"],
      description: map["description"],
      email: map["email"],
      photoUrl: map["photoUrl"],
      username: map["username"],
      isFavorite: map["isFavorite"],
      isSaved: map["isSaved"],
      documentId: map['docId'],
      title: map["title"],
      server: map["server"],
      cooktime: map["cooktime"],
      igredient1: map["igredient1"],
      igredient2: map["igredient2"],
      step2: map["step2"],
      step3: map["step3"],
      step4: map["step4"],
      image: map["image"],
      image2: map["image2"],
      image3: map["image3"],

    );
  }


  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "photoUrl": photoUrl,
      "username": username,
      "email": email,
      "description": description,
      "title": title,
      "server": server,
      "cooktime": cooktime,
      "igredient1": igredient1,
      "igredient2": igredient2,
      "step2": step2,
      "step3": step3,
      "step4": step4,
      "image": image,
      "image2": image2,
      "image3": image3,
      'docId' : documentId,
      'isFavorite' : isFavorite,
      'isSaved' : isSaved,
    };
  }
}


