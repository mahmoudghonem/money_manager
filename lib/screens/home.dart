import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneymanager/screens/accounts.dart';
import 'package:moneymanager/screens/bills.dart';
import 'package:moneymanager/screens/overview.dart';
import 'package:moneymanager/screens/settings.dart';

import '../data/data.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _overviewVisible = false;
  bool _accountVisible = false;
  bool _billVisible = false;
  bool _settingsVisible = false;

  Color _activeColor = customButtonTextColor;
  Color _nonActiveColor = customIconColor;
  Color _overviewColor = customIconColor;
  Color _accountColor = customIconColor;
  Color _billColor = customIconColor;
  Color _settingsColor = customIconColor;
  double _appBarFontSize = 16;
  PageController _pageViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageViewController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    _overviewColor = _activeColor;
    _overviewVisible = true;
  }

  _changeVisiblePage(int key) {
    _pageViewController.animateToPage(key,
        duration: Duration(milliseconds: 250), curve: Curves.linear);
    switch (key) {
      case 0:
        {
          setState(() {
            _overviewVisible = true;
            _accountVisible = false;
            _billVisible = false;
            _settingsVisible = false;
            _overviewColor = _activeColor;
            _accountColor = _nonActiveColor;
            _billColor = _nonActiveColor;
            _settingsColor = _nonActiveColor;
          });
        }
        break;
      case 1:
        {
          setState(() {
            _overviewVisible = false;
            _accountVisible = true;
            _billVisible = false;
            _settingsVisible = false;
            _overviewColor = _nonActiveColor;
            _accountColor = _activeColor;
            _billColor = _nonActiveColor;
            _settingsColor = _nonActiveColor;
          });
        }
        break;
      case 2:
        {
          setState(() {
            _overviewVisible = false;
            _accountVisible = false;
            _billVisible = true;
            _settingsVisible = false;
            _overviewColor = _nonActiveColor;
            _accountColor = _nonActiveColor;
            _billColor = _activeColor;
            _settingsColor = _nonActiveColor;
          });
        }
        break;
      case 3:
        {
          setState(() {
            _overviewVisible = false;
            _accountVisible = false;
            _billVisible = false;
            _settingsVisible = false;
            _overviewColor = _nonActiveColor;
            _accountColor = _nonActiveColor;
            _billColor = _nonActiveColor;
            _settingsColor = _nonActiveColor;
          });
        }
        break;
      case 4:
        {
          setState(() {
            _overviewVisible = false;
            _accountVisible = false;
            _billVisible = false;
            _settingsVisible = true;
            _overviewColor = _nonActiveColor;
            _accountColor = _nonActiveColor;
            _billColor = _nonActiveColor;
            _settingsColor = _activeColor;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: myCustomAppBar(),
      body: PageView(
        controller: _pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Overview(),
          Accounts(),
          Bills(),
          Settings(),
        ],
      ),
    );
  }

  PreferredSize myCustomAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 56),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: customFieldColor, spreadRadius: 5, blurRadius: 2)
        ]),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            color: customSecondaryColor,
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 28, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/overview.svg',
                    color: _overviewColor,
                    height: appBarIconH,
                    width: appBarIconW,
                    semanticsLabel: 'Overview',
                  ),
                  onTap: () => _changeVisiblePage(0),
                ),
                Visibility(
                    visible: _overviewVisible,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: _appBarFontSize,
                        color: _activeColor,
                      ),
                    )),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/accounts.svg',
                    color: _accountColor,
                    height: appBarIconH,
                    width: appBarIconW,
                    semanticsLabel: 'Accounts',
                  ),
                  onTap: () => _changeVisiblePage(1),
                ),
                Visibility(
                    visible: _accountVisible,
                    child: Text(
                      'Accounts',
                      style: TextStyle(
                        fontSize: _appBarFontSize,
                        color: _activeColor,
                      ),
                    )),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/bill.svg',
                    color: _billColor,
                    height: appBarIconH,
                    width: appBarIconW,
                    semanticsLabel: 'Bills',
                  ),
                  onTap: () => _changeVisiblePage(2),
                ),
                Visibility(
                    visible: _billVisible,
                    child: Text(
                      'Bills',
                      style: TextStyle(
                        fontSize: _appBarFontSize,
                        color: _activeColor,
                      ),
                    )),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/setting.svg',
                    color: _settingsColor,
                    height: appBarIconH,
                    width: appBarIconW,
                    semanticsLabel: 'Settings',
                  ),
                  onTap: () => _changeVisiblePage(4),
                ),
                Visibility(
                    visible: _settingsVisible,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: _appBarFontSize,
                        color: _activeColor,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }
}
