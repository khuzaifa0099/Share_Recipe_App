import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  var username;
  var uid;
  var email;
  var location;
  var bio;
  var photoUrl;
  UserModel(
      {
        this.username,
        this.uid,
        this.email,
        this.location,
        this.bio,
        this.photoUrl,
      });

  factory UserModel.fromMap(map) {
    return UserModel(
      username: map['username'],
      uid: map['uid'],
      email: map['email'],
      location: map['location'],
      bio: map['bio'],
      photoUrl: map['photoUrl'],


    );
  }
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid' : uid,
      'email': email,
      'location' : location,
      'bio' : bio,
      'photoUrl' : photoUrl,
      //"like": like,

    };
  }
}
