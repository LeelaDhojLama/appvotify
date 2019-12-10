import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './views/register.dart';
import './views/parties.dart';
import './views/thankyou.dart';
import './views/nation.dart';
import './views/dashboard.dart';
import './views/splash.dart';
//import './views/homeView.dart';
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case '/':
        return MaterialPageRoute(
          builder: (_)=>SplashScreen()
        );
      case '/dashboard':
        return MaterialPageRoute(
          builder: (_)=>Dashboard()
        );
      case '/register':
        return MaterialPageRoute(
            builder: (_)=>RegisterView()
        );
        case '/nation':
        return MaterialPageRoute(
            builder: (_)=>Nation()
        );
      case '/party':
        var country = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_)=>Parties(country)
        );
      case '/thankyou':
        return MaterialPageRoute(
            builder: (_)=>ThankYou()
        );
    }
  }
}