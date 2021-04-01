import 'package:flutter/material.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/widgets/accountspagewidget.dart';
import 'addscreen.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  AccountsDataBaseService _dataBaseService = new AccountsDataBaseService();
  List<AccountsModel> accountsModelList = new List();
  double result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBaseService.init();
    setDateFromDb();
  }

  @override
  void didUpdateWidget(Accounts oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setDateFromDb();
  }

  void setDateFromDb() async {
    var fetchedData = await _dataBaseService.getAccountsFromDB();
    setState(() {
      accountsModelList.clear();
      accountsModelList = fetchedData.where((i) => i.isDeposit && i.isNotBudget).toList();
      sumTotal();
    });
  }

  sumTotal() {
    result = 0.0;
    accountsModelList.forEach((f) {
      setState(() {
        result = result + f.amount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AccountsPageWidget(
                  data: accountsModelList,
                  result: result,
                  accountType: 'Accounts',
                  updateFunction: setDateFromDb,
              indexNum:0),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addFab',
        onPressed: () => Navigator.of(context).push(
          // With MaterialPageRoute, you can pass data between pages,
          // but if you have a more complex app, you will quickly get lost.
          MaterialPageRoute(
            builder: (context) => AddScreen(
              addScreenPasser: true,
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
