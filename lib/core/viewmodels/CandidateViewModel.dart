import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../models/Candidate.dart';
import '../services/CandidateApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateViewModel extends ChangeNotifier{

  CandidateApi _api = locater<CandidateApi>();

  List<Candidate> candidates;

  Future<List<Candidate>> fetchUsers() async{
    var result = await _api.getDataCollection();
    candidates = result.documents
        .map((doc)=>Candidate.fromMap(doc.data, doc.documentID))
        .toList();

    return candidates;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Stream<QuerySnapshot> getCandidateAsStreamById(id){
    return _api.getetDocumentByIdAsStream(id);
  }

  Future<Candidate> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Candidate.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Candidate data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Candidate data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }

}