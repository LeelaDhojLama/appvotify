import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:vote/core/models/Country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/core/viewmodels/CountryViewModel.dart';
import 'package:provider/provider.dart';

class Nation extends StatefulWidget {
  @override
  _Nation createState() => _Nation();
}

class _Nation extends State<Nation> {
  final _formkey = GlobalKey<FormState>();
  final appBg = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_grey.png'), fit: BoxFit.cover)));
  List<Country> countries;

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

  final List<String> nationList = [
    'England',
    'Northern Wales',
    'Scotland',
    'Wales'
  ];

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    var countryprovider = Provider.of<CountryViewModel>(context);

    return Scaffold(
      //backgroundColor: Colors.transparent,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Nation',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Avenir',
                        color: Color(0xffD1248F),
                        fontWeight: FontWeight.w800,
                      )),
                  SizedBox(height: 20),
            StreamBuilder(
                stream: countryprovider.fetchCountriesAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    countries = snapshot.data.documents
                        .map((doc) => Country.fromMap(doc.data, doc.documentID))
                        .toList();
                    print(countries);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: countries.length,
                      itemBuilder: (buildContext, index) =>
                          nationCard(context,index),
                    );
                  } else {
                    return Text('fetching');
                  }
                }),
                  
                ],
              ))
        ],
      ),
    );
  }

  Widget nationCard(BuildContext context, int index) {
    return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/party',arguments: countries[index].id);
        },
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Color(0xffd8d8d8), width: 2.0)),
          child: Row(

            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0)),
//              CircularCheckBox(
//                  value: _isChecked,
//                  materialTapTargetSize: MaterialTapTargetSize.padded,
//                  activeColor: Color(0xffD1248F),
//                  onChanged: (bool x) {
//                    _isChecked = !_isChecked;
//                  }),
              Text(countries[index].title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Avenir',
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
        )));
  }
}
