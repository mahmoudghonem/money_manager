import 'package:flutter/material.dart';
import 'package:moneymanager/data/data.dart';
import 'package:moneymanager/screens/accountsadd.dart';
import 'package:moneymanager/screens/expensesadd.dart';

class AddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddScreenState();

  final bool addScreenPasser;
  final int id;

  AddScreen({this.addScreenPasser, this.id});
}

class _AddScreenState extends State<AddScreen> {
  PageController _pageViewController;
  int _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageViewController =
        PageController(initialPage: widget.addScreenPasser ? 0 : 1);
    this._currentIndex = widget.addScreenPasser ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentIndex == 0 ? 'Accounts' : 'Expenses',
          style: TextStyle(color: customButtonTextColor),
        ),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
      ),
      body: PageView(
        controller: _pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          AccountsAdd(),
          ExpensesAdd(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: customSecondaryColor,
        selectedItemColor: customButtonTextColor,
        unselectedItemColor: customTextColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: navigationTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
            ),
            title: Text('Accounts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_off,
            ),
            title: Text('Expenses'),
          ),
        ],
      ),

    );
  }

  void navigationTapped(int page) {
    _pageViewController.animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }
}
