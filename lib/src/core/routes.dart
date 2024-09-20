
import 'package:app_clone/src/presentation/feature/auth/ui/login.dart';
import 'package:app_clone/src/presentation/feature/auth/ui/signup.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String HOME = '/';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER ='/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
      //return MaterialPageRoute(builder: (_) => HomeScreen());
      case SPLASH:
      //return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const AuthFlow());
      case REGISTER:
        return MaterialPageRoute(builder: (_)=> const Register());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        Text('No route defined for ${settings.name}')
                      ],
                    ),
                  ),
                ));
    }
  }
}
