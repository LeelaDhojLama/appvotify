import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../models/Country.dart';
import '../services/CountryAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountryViewModel extends ChangeNotifier{

  CountryApi _api = locater<CountryApi>();

  List<Country> countries;

  Future<List<Country>> fetchCountries() async{
    var result = await _api.getDataCollection();
    countries = result.documents
        .map((doc)=>Country.fromMap(doc.data, doc.documentID))
        .toList();

    return countries;
  }

  Stream<QuerySnapshot> fetchCountriesAsStream() {
    return _api.streamDataCollection();
  }

  DocumentReference getCountryById(String id) {
    return  _api.streamGetDocumentById(id);
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Country data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Country data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }

}