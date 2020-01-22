
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wheelthehood/core/models/user.dart';
import 'package:wheelthehood/core/services/auth_service.dart';
import 'package:wheelthehood/core/view_models/CRUDModel.dart';
import 'package:wheelthehood/locator.dart';


class Auth implements AuthService {

  Auth(){
    _firebaseAuth = FirebaseAuth.instance;
    _userController = StreamController<User>();
  }

  FirebaseAuth _firebaseAuth;

  //UserService _userService = locator<UserService>();
  CRUDModel _crudModel = locator<CRUDModel>();

  /// When the home view is initialized we want to call the [getPosts]
  /// method to get the posts for our user. We need the userId for that
  /// We know the user info will be required in this view and the post
  /// details view to show author name. We don't want to inject the
  /// [AuthenticationService] into the home model because that is not
  /// good code practice. Instead we'll expose a [StreamController] of
  /// type [User] and we'll provide that using the [StreamProvider].
  ///
  StreamController<User> _userController;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  @override
  Future<User> signInAnonymously() async {
    final AuthResult authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(EmailAuthProvider.getCredential(
      email: email,
      password: password,
    ));
    //return _userFromFirebase(authResult.user);
    var thisUser = _userFromFirebase(authResult.user);
    if(thisUser != null)
    {
      _userController.add(thisUser);
    }
    return thisUser;
  }

  @override
  Future<User> signInWithGoogle() async {

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final AuthResult authResult = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        var thisUser = _userFromFirebase(authResult.user);
        _userController.add(thisUser);
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }

    //  Remember to add:
    //  _userController.add(thisUser);
  }

  Future<bool> createUserData(User user) async{
    var result = await _crudModel.addUser(user);
    return (result)? true : false;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    final AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    //  get this instance of the current user so we can update it
    //  with our additional information
    //
    //  20/11/2019
    //  for now, any addition information should be stored in
    //  our database
    /*FirebaseUser user  = await _firebaseAuth.currentUser();
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = username;
    //`return this with updated info
    user.updateProfile(updateInfo);*/


    //  add displayname to object instance
    var firebaseUser = _userFromFirebase(authResult.user);

    User returnUser = User(uid: firebaseUser.uid, email: firebaseUser.email,
        photoUrl: firebaseUser.photoUrl, displayName: username);


    //  add user to our database
    /*_userService.createUser(returnUser.uid, _userService.getUserData(
      uid: returnUser.uid,
      email: returnUser.email,
      displayName: returnUser.displayName,
      photoUrl: returnUser.photoUrl
    ));*/
    await _crudModel.addUser(returnUser);
    //await _crudModel.addData(returnUser);

    /* Just for testing */
    /*Car myCar = Car(uid: returnUser.uid, numberOfDoors: 4, make: "Volkswagon", colour: "Jet Black");
    _crudModel.addCar(myCar);*/

    //  add to stream
    _userController.add(returnUser);

    return returnUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithEmailAndLink({String email, String link}) async {
    AuthResult authResult =
    await _firebaseAuth.signInWithEmailAndLink(email: email, link: link);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<bool> isSignInWithEmailLink(String link) async {
    return await _firebaseAuth.isSignInWithEmailLink(link);
  }

  @override
  Future<void> sendSignInWithEmailLink({
    @required String email,
    @required String url,
    @required bool handleCodeInApp,
    @required String iOSBundleID,
    @required String androidPackageName,
    @required bool androidInstallIfNotAvailable,
    @required String androidMinimumVersion,
  }) async {
    return await _firebaseAuth.sendSignInWithEmailLink(
      email: email,
      url: url,
      handleCodeInApp: handleCodeInApp,
      iOSBundleID: iOSBundleID,
      androidPackageName: androidPackageName,
      androidInstallIfNotAvailable: androidInstallIfNotAvailable,
      androidMinimumVersion: androidMinimumVersion,
    );
  }



  /*@override
  Future<User> signInWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin
        .logInWithReadPermissions(<String>['public_profile']);
    if (result.accessToken != null) {
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }*/

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    if(user != null){
      print("the current value of user is: ${user}");
    }else{
      print("Current user not logged in.");
    }

    return _userFromFirebase(user);
  }

  @override
  StreamController<User> getStreamController(){
    return _userController;
  }


  @override
  Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    //final FacebookLogin facebookLogin = FacebookLogin();
    //await facebookLogin.logOut();

    //  Get user, using Provider
    var user = Provider.of<User>(context);
    //_userController.add(_userFromFirebase(user));
    //  clear user data instance
    user = User.initial();
    _userController.add(user);

    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}
}