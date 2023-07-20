import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/navigator/bloc/navigator_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/help_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/home_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/navigator_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/product_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/splash_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/verify_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/args.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    NavigatorBloc navigatorBloc = NavigatorBloc();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/navigator':
        final args = settings.arguments as SharedPreferences;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<NavigatorBloc>.value(
                  value: navigatorBloc,
                  child: NavigatorScreen(loginData: args),
                ));
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/verify':
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerifyScreen(
                  code: args,
                ));
      case '/help':
        return MaterialPageRoute(builder: (_) => const HelpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/single':
        final args = settings.arguments as MyArgs;
        return MaterialPageRoute(
            builder: (_) => ProductScreen(
                  myArgs: args,
                ));

      default:
        return null;
    }
  }
}
