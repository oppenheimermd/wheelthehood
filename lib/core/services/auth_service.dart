import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wheelthehood/core/models/user.dart';

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password,String username);
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithEmailAndLink({String email, String link});
  Future<bool> isSignInWithEmailLink(String link);
  Future<void> sendSignInWithEmailLink({
    @required String email,
    @required String url,
    @required bool handleCodeInApp,
    @required String iOSBundleID,
    @required String androidPackageName,
    @required bool androidInstallIfNotAvailable,
    @required String androidMinimumVersion,
  });
  Future<User> signInWithGoogle();
  //Future<User> signInWithFacebook();
  Future<void> signOut(BuildContext context);
  void dispose();
  StreamController<User> getStreamController();
}