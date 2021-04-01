import 'accountsmodel.dart';

class MoneyManagement {
  double totalMoney;
  double totalExpenses;
  double totalLeft;
  int totalPer;
  List<AccountsModel> accountsModelList;
  List<AccountsModel> expensesModelList;

  MoneyManagement(
      {this.accountsModelList,
      this.expensesModelList,
      this.totalMoney,
      this.totalExpenses,
      this.totalLeft});

  accountsSum() {
    totalMoney = 0.0;
    accountsModelList.forEach((f) {
      totalMoney = totalMoney + f.amount;
    });
    return totalMoney;
  }

  expensesSum() {
    totalExpenses = 0.0;
    expensesModelList.forEach((f) {
      totalExpenses = totalExpenses + f.amount;
    });
    return totalExpenses;
  }

  leftSum() {
    totalLeft = 0.0;
    totalLeft = totalMoney - totalExpenses;
    return totalLeft;
  }

  leftMoneyP() {
    totalPer = 0;
    totalPer = (totalLeft / totalMoney * 100).toInt();
    return totalPer;
  }
}
