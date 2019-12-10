import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../models/User.dart';
import '../services/UserApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserViewModel extends ChangeNotifier{

  UserApi _api = locater<UserApi>();

  List<User> users;

  Future<List<User>> fetchUsers() async{
    var result = await _api.getDataCollection();
    users = result.documents
    .map((doc)=>User.fromMap(doc.data, doc.documentID))
    .toList();

    return users;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<User> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  User.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(User data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(User data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return result;

  }

}