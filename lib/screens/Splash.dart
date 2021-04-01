import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanager/data/data.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData().then((value) {
      navigateToHomeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: customPrimaryColor,
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
        ),
      ),
    );
  }

  Future initData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void navigateToHomeScreen() {
    Navigator.pop(context);
  }
}
