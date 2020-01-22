import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  static User initial(){
    var initialUser = User(
        uid: null,
        email: null,
        photoUrl: null,
        displayName: null
    );

    return initialUser;
  }

  User.fromMap(Map snapshot) :
        uid = snapshot['uid'] ?? '',
        email = snapshot['email'] ?? '',
        photoUrl = snapshot['photoUrl'] ?? '',
        displayName = snapshot['displayName'] ?? '';

  toJson() {
    return {
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "displayName":displayName
    };
  }
}