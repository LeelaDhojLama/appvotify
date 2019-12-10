import 'package:flutter/material.dart';
import './register_form.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String name ;
  String address ;
  String age ;
  String insurance ;

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

  final appBg = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_grey.png'), fit: BoxFit.cover)));

  @override
  Widget build(BuildContext context) {


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
                  Text('Register to vote',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Avenir',
                        color: Color(0xffD1248F),
                        fontWeight: FontWeight.w800,
                      )),
                  SizedBox(height: 20),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:
                          BorderSide(color: Color(0xffd8d8d8), width: 2.0)),
                      child: RegisterForm()),
                  //RegisterToVoteForm()),
                ],
              ))
        ],
      ),
    );
  }
}