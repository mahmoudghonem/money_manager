import 'package:flutter/material.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/data/data.dart';
import 'package:moneymanager/screens/accountsadd.dart';
import 'package:moneymanager/screens/expensesadd.dart';

class AccountsRowWidget extends StatelessWidget {
  final AccountsModel model;
  final Function updateFunction;
  final int indexNum;

  AccountsRowWidget(
      {@required this.model,
      @required this.updateFunction,
      @required this.indexNum});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Wrap(
          children: <Widget>[
            ListTile(
              title: Text(
                '${model.type}',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('${model.date}'),
              trailing: Text(
                '\$${model.amount}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => editAccount(context, model)),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteAccount(context, model)),
                Text(
                  '${model.note == null ? '\"No note\"' : model.note}',
                  style: TextStyle(color: customTextColor),
                ),
              ],
            ),
            Divider(
              thickness: 2.0,
            )
          ],
        ),
      ],
    );
  }

  deleteAccount(BuildContext context, AccountsModel model) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('No')),
              FlatButton(
                  onPressed: () => {
                        AccountsModel.deleteModel(model, updateFunction),
                        Navigator.pop(context),
                      },
                  child: Text('Yes'))
            ],
          );
        });
  }

  editAccount(BuildContext context, AccountsModel model) {
    if (indexNum == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AccountsAdd(
                    isAccountToEdit: true,
                    model: model,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExpensesAdd(
                    isAccountToEdit: true,
                    model: model,
                  )));
    }
  }
}
