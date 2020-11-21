import 'dart:io';
import 'dart:developer';
import 'package:TODO/model/Item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  //singleton olustur
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async{
    if(_database==null){
      _database = await initdb();
    }
    return _database;
  }

  initdb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "database.db";
    var db = await openDatabase(path,version: 1,onCreate: createDatabase);
    return db;
  }

  void createDatabase(Database db,int version) async{
    await db.execute("CREATE TABLE todo (title STRING,completed INTEGER)");
  }


  getitems() async{
    final db = await database;
    var res = await db.query("todo");
    List<Item> list = res.isNotEmpty ? res.map((e) => Item.fromJson(e)).toList() : [];
    return list;
  }

  newitem(Item item) async{
      final db = await database;
      log(item.title+item.completed.toString());
      var res = await db.insert("todo", item.toJson());
      return res;
  }

  updateitem(Item item) async{
    final db = await database;
    var res = await db.update("todo", item.toJson(), where: 'title = ?', whereArgs: [item.title]);
    return res;
  }
}