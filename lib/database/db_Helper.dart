import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> Chekdatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await creatDatabase();
    }
  }


  //======================================================================================================================
//======================================================================================================================



  Future<Database> creatDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();

    String path = join(folder.path, "rnw.db");

    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE ClientTable(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT,address TEXT)";
      String query1 =
          "CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,amount TEXT,date TEXT,time TEXT,client_id INTEGER,payment_status INTEGER)";

      db.execute(query1);
      db.execute(query);
    });
  }


  //======================================================================================================================
//======================================================================================================================



  void insertData(String n1, String m1, String a1) async {
    db = await Chekdatabase();
    db!.insert("ClientTable", {"name": n1, "mobile": m1, "address": a1});
  }


//======================================================================================================================
//======================================================================================================================




  Future<List<Map>> readData() async {
    db = await Chekdatabase();

    String query = "SELECT * FROM ClientTable";
    List<Map> Clientalldatalist = await db!.rawQuery(query, null);

    return Clientalldatalist;
  }


//======================================================================================================================
//======================================================================================================================


  void deletData(String id) async {
    db = await Chekdatabase();
    db!.delete("ClientTable", where: "id = ?", whereArgs: [int.parse(id)]);
  }


  //======================================================================================================================
//======================================================================================================================


  void updateData(String id, String n1, String m1, String a1) async {
    db = await Chekdatabase();

    db!.update("ClientTable", {"name": n1, "mobile": m1, "address": a1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //=========================================================================================================


  void productinsertData(String n1, String a1, String d1,String t1,int clientId,int status) async {
    db = await Chekdatabase();
    db!.insert("product", {"name": n1, "amount":a1, "date": d1, "time": t1,"client_id":clientId,"payment_status":status});
  }

  Future<List<Map>> productreadData({String? id}) async {
    db = await Chekdatabase();
    String query = "";
    if (id != null)
      query = "SELECT * FROM product where client_id = $id";
    else
      query = "SELECT * FROM product";

    List<Map> productlist = await db!.rawQuery(query, null);

    return productlist;
  }

  Future<List<Map>> ProductFilterReadData(String? date) async {
    db = await Chekdatabase();
    String query = "SELECT * FROM product where date = ?";
    List<Map> productlist = await db!.rawQuery(query, [date]);

    return productlist;
  }


  void productdeleteData(String id) async {
    db = await Chekdatabase();
    db!.delete("product", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void productupdateData(String id, String n1, String a1, String d1,String t1) async {
    db = await Chekdatabase();
    db!.update("product", {"name": n1, "amount":a1, "date": d1, "time": t1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }
}
