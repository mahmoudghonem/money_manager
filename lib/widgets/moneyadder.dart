import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/data/accountsmodel.dart';
import 'package:moneymanager/data/data.dart';

// ignore: must_be_immutable
class MoneyAdder extends StatefulWidget {
  List<String> date;
  List<IconData> dataAvatar;
  bool isDeposit;
  bool isNotBudget;
  AccountsModel model;
  bool oldAccountToEdit;

  MoneyAdder(this.date, this.dataAvatar, this.isDeposit, this.isNotBudget,
      {this.model, this.oldAccountToEdit});

  @override
  State<StatefulWidget> createState() => _MoneyAdderState();
}

class _MoneyAdderState extends State<MoneyAdder> {
  AccountsDataBaseService _db = new AccountsDataBaseService();
  var _data, _dataAvatar;
  bool _isDeposit;
  bool _isNotBudget;
  bool _oldAccountToEdit;
  AccountsModel _model;
  int _value;

  static var dateNow = new DateTime.now();
  static var dateFormatter = new DateFormat.yMMMMd("en_US");
  String dateFormatted = dateFormatter.format(dateNow);
  final _textEditingController = TextEditingController();
  final _doubleEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._data = widget.date;
    this._dataAvatar = widget.dataAvatar;
    this._isDeposit = widget.isDeposit;
    this._isNotBudget = widget.isNotBudget;

    if (widget.model != null) {
      this._model = widget.model;
      this._value = _model.typeIndex;
      this._oldAccountToEdit = widget.oldAccountToEdit;
    } else {
      this._value = 0;
      this._oldAccountToEdit = false;
    }
    checkIfEdit();
  }

  checkIfEdit() {
    if (_oldAccountToEdit) {
      _doubleEditingController.text = _model.amount.toString();
      if (_model.note != null) {
        _textEditingController.text = _model.note;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _oldAccountToEdit
          ? AppBar(
              centerTitle: true,
              title: Text(
                _isDeposit ? 'Accounts' : 'Expenses',
                style: TextStyle(color: customButtonTextColor),
              ),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            )
          : null,
      resizeToAvoidBottomPadding: true,
      body: Container(
        child: SafeArea(
          bottom: true,
          top: true,
          left: true,
          right: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  dateFormatted,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == '0.00' || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  controller: _doubleEditingController,
                  expands: false,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  maxLengthEnforced: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: '0.00',
                      labelStyle: TextStyle(
                        color: customWhite,
                        letterSpacing: 7,
                      ),
                      prefixText: '\$',
                      prefixStyle: TextStyle(
                        color: customButtonTextColor,
                        fontSize: 25,
                      )),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 10.0,
                children: List<Widget>.generate(
                  _data.length,
                  (int index) {
                    return ChoiceChip(
                      avatar: CircleAvatar(
                        child: Icon(_dataAvatar[index]),
                        backgroundColor: customButtonTextColor,
                      ),
                      label: Text(_data[index]),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : _value;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: _textEditingController,
                expands: false,
                keyboardType: TextInputType.text,
                maxLength: 58,
                maxLengthEnforced: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: 'Add note',
                  labelText: 'Note',
                  labelStyle: TextStyle(
                    color: customWhite,
                    letterSpacing: 7,
                  ),
                  prefixIcon: Icon(
                    Icons.subject,
                    color: customButtonTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'addFab',
        elevation: 2.0,
        onPressed: () => moneyAdderFunction(),
        label: Text('Save'),
        icon: Icon(Icons.add),
      ),
    );
  }

  moneyAdderFunction() {
    if (_oldAccountToEdit) {
      if (_formKey.currentState.validate()) {
        String amountText = _doubleEditingController.text;
        RegExp exp = new RegExp(r",");
        String str = amountText.replaceAll(exp, '');
        double amount = double.parse(str);

        String noteText = _textEditingController.text.isNotEmpty
            ? _textEditingController.text
            : null;
        String typeText = '${_data[_value]}';
        AccountsModel model = new AccountsModel(
            id: _model.id,
            amount: amount,
            date: _model.date,
            isDeposit: _model.isDeposit,
            isNotBudget: _model.isNotBudget,
            note: noteText,
            type: typeText);
        _db.updateAccountsInDB(model).then((_) {
          Navigator.pop(context);
        });
      }
    } else {
      if (_formKey.currentState.validate()) {
        String amountText = _doubleEditingController.text;
        RegExp exp = new RegExp(r",");
        String str = amountText.replaceAll(exp, '');
        double amount = double.parse(str);

        String noteText = _textEditingController.text.isNotEmpty
            ? _textEditingController.text
            : null;
        String typeText = '${_data[_value]}';
        AccountsModel model = new AccountsModel(
            amount: amount,
            date: dateNow,
            isDeposit: _isDeposit,
            isNotBudget: _isNotBudget,
            note: noteText,
            type: typeText,
            typeIndex: _value);
        _db.addAccountInDB(model).then((_) {
          Navigator.pop(context);
        });
      }
    }
  }
}
