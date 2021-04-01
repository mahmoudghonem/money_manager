import 'package:flutter/material.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/widgets/moneyadder.dart';

class ExpensesAdd extends StatefulWidget {
  final AccountsModel model;
  final bool isAccountToEdit;

  ExpensesAdd({this.model, this.isAccountToEdit});

  @override
  State<StatefulWidget> createState() => _ExpensesAddState();
}

class _ExpensesAddState extends State<ExpensesAdd> {
  var _data = [
    'Bills',
    'Car',
    'Clothes',
    'Communications',
    'Food',
    'Travel',
    'Gifts',
    'Health',
    'Personal Care',
    'House',
    'Transports',
    'Entertatinment',
    'Pets',
    'Shopping',
    'Tax',
    'Education',
    'Insurance',
    'Utility',
    'Debit Card',
    'Debit',
    'Others',
  ];
  var _dataAvatar = [
    Icons.money_off,
    Icons.directions_car,
    Icons.accessibility_new,
    Icons.phone_android,
    Icons.fastfood,
    Icons.airplanemode_active,
    Icons.card_giftcard,
    Icons.healing,
    Icons.person,
    Icons.home,
    Icons.train,
    Icons.fitness_center,
    Icons.pets,
    Icons.shopping_cart,
    Icons.monetization_on,
    Icons.school,
    Icons.security,
    Icons.wb_incandescent,
    Icons.credit_card,
    Icons.money_off,
    Icons.book,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MoneyAdder(
      _data,
      _dataAvatar,
      false,
      true,
      model: widget.model,
      oldAccountToEdit: widget.isAccountToEdit,
    );
  }
}
