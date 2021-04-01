import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountsModel {
  int id;
  String type;
  int typeIndex;
  bool isDeposit;
  bool isNotBudget;
  double amount;
  String note;
  DateTime date;

  AccountsModel.empty();

  AccountsModel(
      {this.id,
      this.type,
      this.isDeposit,
      this.isNotBudget,
      this.amount,
      this.note,
      this.date,
      this.typeIndex});

  AccountsModel.formMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.type = map['type'];
    this.typeIndex = map['typeIndex'];
    this.isDeposit = map['isDeposit'] == 0 ? true : false;
    this.isNotBudget = map['isNotBudget'] == 0 ? true : false;
    this.amount = map['amount'];
    this.note = map['note'];
    this.date = DateTime.parse(map['date']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'type': this.type,
      'typeIndex': this.typeIndex,
      'isDeposit': this.isDeposit == true ? 0 : 1,
      'isNotBudget': this.isNotBudget == true ? 0 : 1,
      'amount': this.amount,
      'note': this.note,
      'date': this.date.toIso8601String(),
    };
  }

  AccountsDataBaseService _dataBaseService = AccountsDataBaseService();

  AccountsModel.deleteModel(AccountsModel model, Function updateChanges) {
    _dataBaseService.deleteAccountsInDB(AccountsModel(id: model.id)).then((_) {
      updateChanges();
    });
  }
}

class AccountsDataBaseService {
  String path;
  Database _database;
  final int _version = 1;
  final String tableName = 'Accounts';

  AccountsDataBaseService();

  static final AccountsDataBaseService db = AccountsDataBaseService();

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we will initlize.. it
    _database = await init();
    return _database;
  }

  init() async {
    path = await getDatabasesPath();
    path = join(path, 'accounts.db');

    return await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, type TEXT, isDeposit INTEGER, isNotBudget INTEGER, typeIndex INTEGER, amount REAL, note TEXT, date TEXT)',
      );
    });
  }

  Future<List<AccountsModel>> getAccountsFromDB() async {
    final db = await database;
    List<AccountsModel> accountsList = [];
    List<Map> maps = await db.query(tableName, columns: [
      'id',
      'type',
      'isDeposit',
      'isNotBudget',
      'typeIndex',
      'amount',
      'note',
      'date'
    ]);
    if (maps.length > 0) {
      maps.forEach((map) {
        accountsList.add(AccountsModel.formMap(map));
      });
    }
    return accountsList;
  }

  Future<void> updateAccountsInDB(AccountsModel updatedAccounts) async {
    final db = await database;
    await db.update(tableName, updatedAccounts.toMap(),
        where: 'id = ?', whereArgs: [updatedAccounts.id]);
  }

  Future<void> deleteAccountsInDB(AccountsModel accountToDelete) async {
    final db = await database;
    await db
        .delete(tableName, where: 'id = ?', whereArgs: [accountToDelete.id]);
  }

  Future<int> addAccountInDB(AccountsModel newAccount) async {
    final db = await database;
    var results = db.insert(tableName, newAccount.toMap());
    return results;
  }

  Future close() async => _database.close();
}
