import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../models/Party.dart';
import '../services/PartyApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartyViewModel extends ChangeNotifier{

  PartyApi _api = locater<PartyApi>();

  List<Party> parties;

  Future<List<Party>> fetchParties() async{
    var result = await _api.getDataCollection();
    parties = result.documents
        .map((doc)=>Party.fromMap(doc.data, doc.documentID))
        .toList();

    return parties;
  }

  Stream<QuerySnapshot> fetchPartiesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Party> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Party.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Party data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Party data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }

}