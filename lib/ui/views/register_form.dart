import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/UserViewModel.dart';
import 'package:vote/core/models/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formkey = GlobalKey<FormState>();

  String name;
  String age;

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

  String address;
  String insurance;

  void registerToVote() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    }
  }

  addUserTolocalStorage(String id) async{
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    print(id);
    prefs.setString("user", id);
  }

    @override
    Widget build(BuildContext context) {
      var userProvider = Provider.of<UserViewModel>(context);
      return Container(
        child: Form(
            key: _formkey,
            child: new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter name';
                              }
                              return null;
                            },
                            onSaved: (value) => name = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Age'),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            validator: numValidator,
                            onSaved: (value) => age = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLines: 2,
                            decoration: InputDecoration(labelText: 'Address'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Address';
                              }
                              return null;
                            },
                            onSaved: (value) => address = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration:
                            InputDecoration(labelText: 'Insurance(Optional)'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter insurance';
                              }
                              return null;
                            },
                            onSaved: (value) => insurance = value,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )),
                  new MaterialButton(
                    minWidth: double.infinity,
                    color: Color(0xffD1248F),
                    padding: EdgeInsets.all(15.0),
                    child: Text('SUBMIT', style: TextStyle(fontSize: 18)),
                    textColor: Color(0xffffffff),
                    onPressed: () async{
                       Scaffold(
                        body: Center(
                            child:SpinKitRotatingCircle(
                              color: Color(0xffD1248F),
                              size: 80.0,
                            )
                        ),
                      );
                      if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                            await userProvider.addProduct(User(name: name,address: address,age: age,insurance: insurance)).then((response)=>
                              addUserTolocalStorage(response.documentID),

                            );

//                          SpinKitWave(color: Colors.white, type: SpinKitWaveType.end);
                            Navigator.pushNamed(context,'/nation');
                      }
                    },
                    splashColor: Color(0xffD1248F),
                  ),
                ],
              ),
            )),
      );
    }
  }