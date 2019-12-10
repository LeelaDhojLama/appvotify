import 'package:flutter/material.dart';
import 'package:vote/core/models/Country.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/CountryViewModel.dart';

class CountryView extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<CountryView> {
  final _formKey = GlobalKey<FormState>();
  String title ;

  @override
  Widget build(BuildContext context) {
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
                    hintText: 'Title',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title';
                    }
                  },
                  onSaved: (value) => title = value
              ),
              SizedBox(height: 16,),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await countryProvider.addProduct(Country(title: title));
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