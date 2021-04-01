import 'package:flutter/material.dart';
import 'package:moneymanager/screens/addscreen.dart';
import 'package:moneymanager/screens/home.dart';
import 'package:moneymanager/screens/Splash.dart';
import 'data/apptheme.dart';

class MoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money',
      home: HomePage(),
      initialRoute: '/splash',
      theme: AppTheme.darkTheme,
      routes: {
        '/addScreen': (context) => AddScreen(),
      },
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/splash') {
      return _buildRoute(settings, new Splash());
   }

    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}
