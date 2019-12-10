import 'package:vote/core/services/API.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CandidateApi extends Api {

  CandidateApi(String path):
        super(path);

  Stream<QuerySnapshot> getetDocumentByIdAsStream(String id){
    return ref.where('party',isEqualTo: id).snapshots();
  }

}