import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart';
import 'locator.dart';
import 'core/viewmodels/UserViewModel.dart';
import 'core/viewmodels/CountryViewModel.dart';
import 'core/viewmodels/PartyViewModel.dart';
import 'core/viewmodels/CandidateViewModel.dart';
import 'core/viewmodels/VoteViewModel.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_)=>locater<UserViewModel>()),
        ChangeNotifierProvider(builder: (_)=>locater<CountryViewModel>()),
        ChangeNotifierProvider(builder: (_)=>locater<PartyViewModel>()),
        ChangeNotifierProvider(builder: (_)=>locater<CandidateViewModel>()),
        ChangeNotifierProvider(builder: (_)=>locater<VoteViewModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Vote',
        theme: ThemeData(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}