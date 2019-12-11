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
        ChangeNotifierProvider(create: (_)=>locater<UserViewModel>()),
        ChangeNotifierProvider(create: (_)=>locater<CountryViewModel>()),
        ChangeNotifierProvider(create: (_)=>locater<PartyViewModel>()),
        ChangeNotifierProvider(create: (_)=>locater<CandidateViewModel>()),
        ChangeNotifierProvider(create: (_)=>locater<VoteViewModel>()),
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