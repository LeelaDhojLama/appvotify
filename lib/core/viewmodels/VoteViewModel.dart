import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../models/Vote.dart';
import '../services/VoteApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteViewModel extends ChangeNotifier{

  VoteApi _api = locater<VoteApi>();

  List<Vote> parties;

  Future<List<Vote>> fetchVotes() async{
    var result = await _api.getDataCollection();
    parties = result.documents
        .map((doc)=>Vote.fromMap(doc.data, doc.documentID))
        .toList();

    return parties;
  }

  Stream<QuerySnapshot> fetchVotesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Vote> getVotesById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Vote.fromMap(doc.data, doc.documentID) ;
  }


  Future removeVote(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateVote(Vote data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addVote(Vote data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return result;

  }

}