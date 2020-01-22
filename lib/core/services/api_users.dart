import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wheelthehood/core/services/api_base.dart';
import 'package:wheelthehood/core/services/api_service.dart';

class ApiUsers extends ApiBase implements ApiService{

  final Firestore _db = Firestore.instance;
  final String _path;
  CollectionReference ref;

  ApiUsers(this._path) : super(_path) {
    ref = _db.collection(_path);
  }

  Future<void> addDocumentByUid({Map data, @required String uid}) async{
    //return ref.add(data);
    //  https://stackoverflow.com/questions/55328838/flutter-firestore-add-new-document-with-custom-id
    var result = await ref.document(uid).setData(data);
    return result;
  }
}