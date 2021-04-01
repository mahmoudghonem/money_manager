import 'package:flutter/material.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/widgets/moneyadder.dart';

class AccountsAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountsAddState();

  final AccountsModel model;
  final bool isAccountToEdit;

  AccountsAdd({this.model, this.isAccountToEdit});
}

class _AccountsAddState extends State<AccountsAdd> {
  var _data = ['Cash', 'Bank Account', 'Payment Card'];
  var _dataAvatar = [
    Icons.account_balance_wallet,
    Icons.account_balance,
    Icons.credit_card
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MoneyAdder(
      _data,
      _dataAvatar,
      true,
      true,
      model: widget.model,
      oldAccountToEdit: widget.isAccountToEdit,
    );
  }
}
