import 'package:riverpod_advance/model/customers_model.dart';
import 'package:riverpod_advance/model/users_model.dart';
import 'package:riverpod_advance/service/db_query.dart';
import 'package:riverpod_advance/service/session_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../function/encode_password.dart';

class DbHelper {
  static final _tables = [
    UsersQuery.createTable,
    CustomersQuery.createTable,
  ];
  static Future createTable(Database db) async {
    for (var item in _tables) {
      await db.execute(item);
    }
  }

  static Future<Database> openDb() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, "riverpod_advance.sql");
    return openDatabase(path, version: 1, onCreate: (db, vers) async {
      await createTable(db);
    });
  }

  static Future<int> createCustomer(CustomerSubmit customers) async {
    final db = await openDb();
    return await db.insert(CustomersQuery.tableName, customers.toMap());
  }

  static Future<UserModel> signUp(UserModel userModel) async {
    final db = await openDb();
    final encode = userModel.copyWith(password: userModel.password.encode());
    final id = await db.insert(UsersQuery.tableName, encode.toMap());
    final newUser = encode.copyWith(id: id);
    await SessionHelper.write(newUser);
    return newUser;
  }

  static Future<List<CustomersRetrieve>> getCustomers() async {
    final db = await openDb();
    final result =
        await db.query(CustomersQuery.tableName, orderBy: "customerId");

    return result.map((e) => CustomersRetrieve.fromMap(e)).toList();
  }

  static Future<List> getUsers() async {
    final db = await openDb();
    final result = await db.query(UsersQuery.tableName);
    return result;
  }

  static Future<UserModel?> login(UserModel userModel, bool session) async {
    final db = await openDb();
    late UserModel value;
    late List result;
    if (session) {
      value = userModel.copyWith();
      result = await db.query(UsersQuery.tableName,
          limit: 1, where: 'username=?', whereArgs: [value.username]);
    } else {
      value = userModel.copyWith(
        password: userModel.password.encode(),
      );
      result = await db.query(UsersQuery.tableName,
          limit: 1, where: 'username = ?', whereArgs: [value.username]);
    }

    if (result.isNotEmpty && result[0]["password"] == value.password) {
      var data = UserModel.fromMap(result[0]);
      await SessionHelper.write(data);
      return data;
    } else {
      return null;
    }
  }

  static Future delete(CustomersRetrieve customer) async {
    final db = await openDb();
    await db.delete(CustomersQuery.tableName,
        where: "customerId=?", whereArgs: [customer.customerId]);
  }

  static Future<List<CustomersRetrieve>> retrieveCreatedByUser(
      UserModel user) async {
    final db = await openDb();
    final retrieve = await db.query(UsersQuery.tableName,
        where: "createdBy = ?", whereArgs: [user.id]);
    if (retrieve.isNotEmpty) {
      return retrieve.map((e) => CustomersRetrieve.fromMap(e)).toList();
    }
    return [];
  }
}
