import 'package:flutter/material.dart';
import 'package:vote/core/models/Country.dart';
import 'package:vote/core/models/Party.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/PartyViewModel.dart';
import '../../core/viewmodels/CountryViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PartyView extends StatefulWidget {
  @override
  _PartyState createState() => _PartyState();
}

class _PartyState extends State<PartyView> {
  final _formKey = GlobalKey<FormState>();
  String name ;
  String country ;
  List<Country> countries;

  @override
  Widget build(BuildContext context) {
    var partyProvider = Provider.of<PartyViewModel>(context) ;
    var countryProvider = Provider.of<CountryViewModel>(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Register'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Name';
                    }
                  },
                  onSaved: (value) => name = value
              ),
              StreamBuilder(
                  stream: countryProvider.fetchCountriesAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot ){
                    var length = snapshot.data.documents.length;
                    DocumentSnapshot ds = snapshot.data.documents[length - 1];
                    if (snapshot.hasData) {
                      countries = snapshot.data.documents
                          .map((doc) => Country.fromMap(doc.data, doc.documentID))
                          .toList();

                      return new DropdownButton(
                          items: snapshot.data.documents.map((DocumentSnapshot document) {
                            return DropdownMenuItem(child: new Text(document['title'].toString()),value: document.documentID,);
                          }).toList(),
                            onChanged: (newValue) {
                            setState(() {
                            country = newValue;
                            });
                            debugPrint(country);},
                        hint: Text('Select Country')

                      );


                    } else {
                      return Text('fetching');
                    }

                  }
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await partyProvider.addProduct(Party(country: country,title: name));
                    Navigator.pop(context) ;
                  }
                },
                child: Text('add Product', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}