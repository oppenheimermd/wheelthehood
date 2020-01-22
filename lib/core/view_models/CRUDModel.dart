import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wheelthehood/core/models/user.dart';
import 'package:wheelthehood/core/services/api_users.dart';
import 'package:wheelthehood/locator.dart';


/// The CRUD Model will use the Api classes to handle different
///  CRUD operations.  This will be injected  using locator
class CRUDModel extends ChangeNotifier {

  //ApiUsers _apiUsers = locator<ApiService>();
  //ApiCars _apiCars = locator<ApiService>();

  ApiUsers _apiUsers = locator<ApiUsers>();
  List<User> _users;

  Future<List<User>> fetchProducts() async {
    var result = await _apiUsers.getDataCollection();
    _users = result.documents
        .map((doc) => User.fromMap(doc.data))
        .toList();
    return _users;
  }

  Stream<QuerySnapshot> fetchUsersAsStream() {
    return _apiUsers.streamDataCollection();
  }

  Future<User> getUserById(String id) async {
    var doc = await _apiUsers.getDocumentById(id);
    return  User.fromMap(doc.data) ;
  }


  Future removeUser(String id) async{
    await _apiUsers.removeDocument(id) ;
    return ;
  }
  Future updateUser(User data,String uid) async{
    await _apiUsers.updateDocument(data.toJson(), uid) ;
    return ;
  }

  Future<bool> addUser(User data) async{

    try {
      await _apiUsers.addDocumentByUid(data: data.toJson(), uid: data.uid);
      print("User: ${data.displayName} and uid: ${data.uid} added.");
      return true;
    } catch (e) {
      print('Error adding user to storage: $e');
      return false;
    }
  }

/*Future<void> addData(User user) async {
    //
    try{
      await Firestore.instance.collection('users').add(user.toJson());
    }
    catch(e){
      print('new AddData(): $e');
    }
  }*/


}