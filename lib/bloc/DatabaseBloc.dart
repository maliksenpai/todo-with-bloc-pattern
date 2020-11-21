
import 'dart:async';
import 'dart:io';

import 'package:TODO/model/DatabaseEvents.dart';
import 'package:TODO/model/Item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBloc{
  List<Item> items = [];

  final _databaseEC = StreamController<DatabaseEvent>();

  final _databaseStateController = StreamController<List<Item>>();
  StreamSink<List<Item>> get _indbSink => _databaseStateController.sink;
  Stream<List<Item>> get dbitems => _databaseStateController.stream;

  DatabaseBloc(){
    _databaseEC.stream.listen(_dbevents);
  }

  void _dbevents(DatabaseEvent event){
    if(event is CreateDatabase){
      _createDatabase();
    }else if(event is GetItems){
      _getItems();
    }else if(event is InsertItem){
      _insertItem(event.item);
    }
    _indbSink.add(items);
  }

  static Database _db;

  /*Future<Database> get db async{
    if(_db==null){
      _db = await initdatabase();
    }
  }*/

  Future<Database> initdatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "database.db";
    var db = await openDatabase(path,version: 1,onCreate: createDatabase);
    return db;
  }

  void createDatabase(Database db,int version) async{
    await db.execute("CREATE TABLE todo (item STRING,completed INTEGER");
  }

  _createDatabase() async{
    if(_db==null){
      _db = await initdatabase();
    }
  }

  _getItems(){

  }

  _insertItem(Item item) async{
   // var result = await _db.insert("todo", item.toMap());
  }
}