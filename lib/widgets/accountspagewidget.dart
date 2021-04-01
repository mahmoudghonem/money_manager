import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/data/data.dart';
import 'package:moneymanager/widgets/accountsrowwidget.dart';

class AccountsPageWidget extends StatelessWidget {
  final List<AccountsModel> data;
  final result;
  final String accountType;
  final Function updateFunction;
  final int indexNum;

  AccountsPageWidget({@required this.data,
    @required this.result,
    @required this.accountType,
    @required this.updateFunction,
    @required this.indexNum});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = getDeviceWidth(context);
    double deviceHeight = getDeviceHeight(context);
    List<charts.Series<AccountsModel, String>> series = [
      charts.Series(
        id: '$accountType',
        data: data,
        domainFn: (AccountsModel series, _) => series.id.toString(),
        measureFn: (AccountsModel series, _) => series.amount,
//        colorFn: (AccountsModel series, _) => series.barColor,
        labelAccessorFn: (AccountsModel row, _) =>
        '${row.type} : \$${row.amount}',
      )
    ];
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
//        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            alignment: Alignment.center,
            width: deviceWidth - 10,
            height: deviceHeight / 3.5,
            child: Card(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    charts.PieChart(
                      series,
                      animate: false,
//                      selectionModels: [
//                        charts.SelectionModelConfig(
//                            changedListener: (charts.SelectionModel model) {
//                              if(model.hasDatumSelection)
//                                _showModalSheet(model,context);
//                            }
//                        )
//                      ],
                      defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 25,
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Text(
                            '\$ $result',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '$accountType',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountsRowWidget(
                    model: data[index],
                    updateFunction: updateFunction,
                    indexNum: indexNum);
              },
            ),
          )
        ],
      ),
    );
  }

}
