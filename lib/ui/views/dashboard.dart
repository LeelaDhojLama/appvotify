import 'package:vote/ui/views/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();



}

class _DashboardState extends State<Dashboard>{

  final itemList = [
    {'icon': 'images/vote_icon.png', 'title': 'Vote', 'link': '/register'},
    {'icon': 'images/news_icon.png', 'title': 'News', 'link': ''},
    {'icon': 'images/vote_icon.png', 'title': 'Parties', 'link': ''},
    {'icon': 'images/vote_icon.png', 'title': 'Result', 'link': ''},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
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
        children: <Widget>[appBg(), title(), dashboardGrid()],
      ),
    );
  }

  //Background Widget
  Widget appBg() {
    return new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg_grey.png'), fit: BoxFit.cover)));
  }

  //Title Widget
  Widget title() {
    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Dashboard',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Avenir',
                  color: Color(0xffD1248F),
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 20),
          ]),
    );
  }

  //Grid View
  Widget dashboardGrid() {
    return new Container(
      padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
      child: new GridView.builder(
        itemCount: itemList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.3),
        itemBuilder: (BuildContext context, int index) {
          return DashboardItem(
              icon: itemList[index]['icon'],
              title: itemList[index]['title'],
              link: itemList[index]['link']);
        },
      ),
    );
  }
}

//Dashboard Item
class DashboardItem extends StatelessWidget {
  final icon;
  final title;
  final link;

  DashboardItem({this.icon, this.title, this.link});

  SharedPreferences pref;

  checkUser(context) {
    LocalStorage storage = new LocalStorage("vote");

    if(link == '/register') {
      if (storage.getItem('user') != null) {
        Navigator.pushNamed(context, '/nation');
      }else{
        Navigator.pushNamed(context, link);
      }
    }else{
      Navigator.pushNamed(context, link);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 10.0,
        child: new Container(
            child: new Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () =>
                  checkUser(context),

                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage(icon),
                              height: 30,
                            ),
                            Text(title,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Avenir',
                                    color: Color(0xffD1248F),
                                    fontWeight: FontWeight.w800)),
                          ],
                        )),
                  )),
            )));
  }
}
