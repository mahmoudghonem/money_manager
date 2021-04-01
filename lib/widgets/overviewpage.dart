import 'package:flutter/material.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/data/data.dart';
import 'package:moneymanager/data/moneymanagment.dart';

class OverviewWidget extends StatefulWidget {
  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  AccountsDataBaseService _dataBaseService = new AccountsDataBaseService();
  List<AccountsModel> accountsModelList = new List();
  List<AccountsModel> expensesModelList = new List();

  double accountSum = 0.0;
  double expensesSum = 0.0;
  double moneySaved = 0.0;
  int leftMoneyP = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBaseService.init();
    setDateFromDb();
  }

  @override
  void didUpdateWidget(OverviewWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setDateFromDb();
  }

  void setDateFromDb() async {
    accountsModelList.clear();
    expensesModelList.clear();
    var fetchedData = await _dataBaseService.getAccountsFromDB();
    accountsModelList = fetchedData.where((i) => i.isDeposit).toList();
    expensesModelList = fetchedData.where((i) => !i.isDeposit).toList();
    setState(() {
      accountSum = MoneyManagement(
              accountsModelList: accountsModelList,
              expensesModelList: expensesModelList)
          .accountsSum();
      expensesSum = MoneyManagement(
              accountsModelList: accountsModelList,
              expensesModelList: expensesModelList)
          .expensesSum();
      moneySaved =
          MoneyManagement(totalMoney: accountSum, totalExpenses: expensesSum)
              .leftSum();
      leftMoneyP = MoneyManagement(
              totalMoney: accountSum,
              totalExpenses: expensesSum,
              totalLeft: moneySaved)
          .leftMoneyP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 2.0,
            child: Wrap(children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Money',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total Budget',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('\$$accountSum',
                          style: TextStyle(
                              fontSize: 18, color: customButtonTextColor)),
                    ],
                  ),
                  Container(
//                width: deviceWidth,
//                height: deviceHeight / 5,
                    child: Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            title: Text(
                              '$leftMoneyP\%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              'Saved',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Total Spent',
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0)),
                          Text(
                            '\$$expensesSum',
                            style: TextStyle(
                                fontSize: 18, color: customButtonTextColor),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Money Saved',
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0)),
                          Text(
                            '\$$moneySaved',
                            style: TextStyle(
                                fontSize: 18, color: customButtonTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
