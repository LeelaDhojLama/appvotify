import 'package:flutter/material.dart';
import 'package:vote/ui/views/dashboard.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          overflow: Overflow.visible,
          children: <Widget>[appBg(), caption(), startBtn(context)],
        ));
  }

  Widget appBg() {
    return new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.cover)));
  }

  Widget caption() {
    return new Container(
        padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[brand(), ukFlag()]));
  }

  Widget brand() {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          logo(),
          Text('Voice of the unheard',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Avenir',
                color: Color(0xffD1248F),
                fontWeight: FontWeight.w500,
              )),
          SizedBox(height: 30),
          appHeading(),
          SizedBox(height: 10),
        ]);
  }

  Widget logo() {
    return new Row(mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            image: AssetImage('images/appy_vote_logo.png'),
            width: 40,
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('AppyVote',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Avenir',
                    color: Color(0xffD1248F),
                    fontWeight: FontWeight.w900,
                  )),
            ],
          ),
        ]);
  }

  Widget appHeading() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('UK Election',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Avenir',
              color: Color(0xffD1248F),
              fontWeight: FontWeight.w500,
            )),
        Text('2019',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Avenir',
              color: Color(0xffD1248F),
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }

  Widget ukFlag() {
    return new Column(
      children: <Widget>[
        Image(
          image: AssetImage('images/uk_flag.png'),
        )
      ],
    );
  }

  Widget startBtn(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 60,
      right: 60,
      child: new MaterialButton(
        minWidth: 250,
        color: Color(0xffffffff),
        padding: EdgeInsets.all(10.0),
        child: Text('Get Started', style: TextStyle(fontSize: 18)),
        textColor: Color(0xffD1248F),
        onPressed: () =>
            Navigator.pushNamed(
                context, '/dashboard'),
        splashColor: Color(0xffD1248F),
      ),
    );
  }
}
