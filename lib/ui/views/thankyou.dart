import 'package:flutter/material.dart';

class ThankYou extends StatelessWidget {
  final appBg = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_grey.png'), fit: BoxFit.cover)));

  final messageCard = new Container(
      padding: EdgeInsets.all(15.0),
      child: new Card(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Text(
                    'Thank you for voting at the 2019 Federal election!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Avenir',
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ])));
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        body: new Stack(children: <Widget>[appBg, messageCard]));
  }

  Widget exitButton(BuildContext context) {
    return new MaterialButton(
      minWidth: 250,
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10.0),
      child: Text('Get Started', style: TextStyle(fontSize: 18)),
      textColor: Color(0xffD1248F),
      onPressed: () => Navigator.pushNamed(
          context,'/dashboard'),
      splashColor: Color(0xffD1248F),
    );
  }
}
