import 'dart:async';
import 'dart:io';
import 'package:new_app_trial/Customer.dart';



import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  final String cusTable ='CustomerInfo';
  final String cusName ='customerName';
  final String cusID = 'customerID';
  final String emailAdd = 'emailAddress';
  final String passW = 'password';
  final String itemNum = 'numberOfItemsPurchased';
  final String wishL = 'wishList';
  final String ordHistory = 'orderHistory';
  final String ordID = 'orderID';
  final String item = 'item';
  final String itemID = 'itemID';
  final String itemPrice = 'priceOfItem';
  final String date = 'dateOfPurchase';


  Future<Database> get db async{
    if (_db !=null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $cusTable($cusID INTEGER PRIMARY KEY, $cusName TEXT, $emailAdd VARCHAR, $passW VARCHAR)"

            "CREATE TABLE $wishL($cusID INTEGER PRIMARY KEY, $itemID INTEGER PRIMARY KEY, $item TEXT)"

            "CREATE TABLE $ordHistory($cusID INTEGER PRIMARY KEY, $itemID INTEGER PRIMARY KEY, $item TEXT, $itemPrice DOUBLE ,$itemNum INTEGER, $date, DATETIME)"
    );
  }/*
 All the above will be used to create a database. The lines directly above this line of text will be used to create tables in the database

 ALl databases will allow an admin to CRUD; CREATE, READ, UPDATE AND DELETE.
*/

//Insertion for CustomerTable
Future<int> saveCustomer(Customer customer) async {
     var dbClient = await db;
     int res = await dbClient.insert("$cusTable", customer.toMap());
     return res;
}
 //Get All Customers
Future<List> getAllCustomers() async {
  var dbClient = await db;
  var result = await dbClient.rawQuery("SELECT * FROM $cusTable");
  return result.toList();
}

//Count all rows on Customer Table
Future<int?> getCount() async {
  var dbClient = await db;
  return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $cusTable"));
}

//Get One Customer
Future<Customer?> getCustomer(int id) async {
 var dbClient = await db;
 var result = await dbClient.rawQuery("SELECT * FROM $cusTable WHERE $cusID = $id");

 if (result.length == 0) return null;
 return new Customer.fromMap(result.first);
}

//Delete A Customer
Future<int> deleteCustomer(int id) async {
  var dbClient = await db;

  return await dbClient.delete(cusTable,
      where: "$cusID =?", whereArgs:[id]);

}
//Update User
Future<int> updateCustomer(Customer customer) async{
  var dbClient = await db;
  return await dbClient.update(cusTable,
  customer.toMap(), where: "$cusID = ?", whereArgs: [customer.customerID]);
}

//Close Database
Future close()async {
  var dbClient = await db;
  return dbClient.close();
}







}



