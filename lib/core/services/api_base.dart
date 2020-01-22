
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wheelthehood/core/services/api_service.dart';


class ApiBase implements ApiService{
  final Firestore _db = Firestore.instance;
  final String _path;
  CollectionReference ref;

  ApiBase(this._path){
    ref = _db.collection(_path);
  }

  @override
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }

  @override
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }

  @override
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  @override
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }

  @override
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  @override
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }
}