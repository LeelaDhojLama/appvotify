import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:vote/core/models/Party.dart';
import 'package:vote/core/models/Vote.dart';
import 'package:vote/core/viewmodels/CandidateViewModel.dart';
import 'package:vote/core/viewmodels/VoteViewModel.dart';
import 'package:vote/core/viewmodels/PartyViewModel.dart';
import 'package:vote/core/viewmodels/CountryViewModel.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Parties extends StatefulWidget {

  String country;

  Parties(this.country);

  @override
  _Parties createState() => _Parties(country);
}

class _Parties extends State<Parties> {
  final _formkey = GlobalKey<FormState>();
  final appBg = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_grey.png'), fit: BoxFit.cover)));


  List<Party> parties;

  String party;

  _Parties(this.country);

  vote() async{
    final prefs =  await SharedPreferences.getInstance();
    var voteProvider = Provider.of<VoteViewModel>(context);
    String user = prefs.getString('user');
    await voteProvider.addVote(Vote(user: user ,party: party ));
    Navigator.pushNamed(context, '/thankyou');

  }

  String country;

  String numValidator(String value) {
    if (value.isEmpty) {
      return 'Enter Age';
    }



    final age = num.tryParse(value);
    if (age < 16) {
      return 'Not eligible to vote';
    }
    return null;
  }

  final List<String> partiesList = [
    'England',
    'Northern Wales',
    'Scotland',
    'Wales'
  ];

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    var partyProivder = Provider.of<PartyViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffD1248F)),
        elevation: 0.0,
        backgroundColor: Color(0xffffffff),
        title: Text(
          'AppyVote',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            fontFamily: 'Avenir',
            color: Color(0xffD1248F),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: new Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          appBg,
          new Container(
              padding: EdgeInsets.all(15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Parties',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Avenir',
                        color: Color(0xffD1248F),
                        fontWeight: FontWeight.w800,
                      )),
                  SizedBox(height: 5),
                  Text('Select parties to vote',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Avenir',
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic)),
                  SizedBox(height: 20),

                  Form(
                    key: _formkey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: partyProivder.fetchPartiesAsStream(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                parties = snapshot.data.documents
                                    .map((doc) => Party.fromMap(doc.data, doc.documentID))
                                    .toList();


                                for(int i=0;i<parties.length;i++){
                                  if(parties[i].country!=country){
                                    parties.removeAt(i);
                                  }
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: parties.length,
                                  itemBuilder: (buildContext, index) =>
                                      partiesCard(context,index),
                                );
                              } else {
                                return Text('fetching');
                              }
                            }),
                        SizedBox(height: 30),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: new MaterialButton(
                              minWidth: double.infinity,
                              color: Color(0xffD1248F),
                              padding: EdgeInsets.all(15.0),
                              child: Text('SUBMIT',
                                  style: TextStyle(fontSize: 18)),
                              textColor: Color(0xffffffff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              onPressed: vote
//
                            ),
                              )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget partiesCard(BuildContext context, int index) {
    var countryProvider = Provider.of<CountryViewModel>(context);
    var candidateProvider = Provider.of<CandidateViewModel>(context);

    return new Container(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Color(0xffd8d8d8), width: 2.0)),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                      StreamBuilder(
                      stream: countryProvider.getCountryById(parties[index].country).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;

                        return new Text(userDocument['title']);
                      }
                  ),
                  StreamBuilder(
                      stream: candidateProvider.getCandidateAsStreamById(parties[index].id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data.documents;

                        print("candidate " +userDocument[0]['name']);

                        return new  Text('Candidate: ${userDocument[0]['name']}',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Avenir',
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic));
                      }
                  ),

                        ],
                      ))),

//              CircularCheckBox(
//                  value: _isChecked,
//                  materialTapTargetSize: MaterialTapTargetSize.padded,
////                  activeColor: Color(0xffD1248F),
//                  onChanged: (bool x) {
//                    _isChecked = !_isChecked;
//                  }),
            Radio(
              value:parties[index].id ,
              groupValue: 0,
              activeColor: Color(0xffD1248F),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (val){
                setState(() {
                  party = val;
                  print(val);
                });
              },
            )

            ],
          ),
        ));
  }

  int _groupValue = -1;

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
