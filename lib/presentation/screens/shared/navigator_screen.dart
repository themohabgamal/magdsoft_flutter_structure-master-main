// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:magdsoft_flutter_structure/business_logic/navigator/bloc/navigator_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/home_screen.dart';

class NavigatorScreen extends StatelessWidget {
  static const routeName = 'nav';
  SharedPreferences loginData;
  NavigatorScreen({
    Key? key,
    required this.loginData,
  }) : super(key: key);
  List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Heart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'Alert',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  List<Widget> screenBody = <Widget>[
    HomeScreen(),
    const Text("favourites"),
    const Text("notifications"),
    const Text("settings"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigatorBloc, NavigatorHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: screenBody.elementAt(state.tabIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: const IconThemeData(color: Colors.grey),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              BlocProvider.of<NavigatorBloc>(context)
                  .add(TabChangeEvent(tabIndex: value));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //signout
              loginData.setBool('login', true);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Icon(Icons.logout),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
