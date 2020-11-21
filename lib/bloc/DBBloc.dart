import 'dart:async';
import 'dart:developer';

import 'package:TODO/bloc/BlocProvider.dart';
import 'package:TODO/data/DBProvider.dart';
import 'package:TODO/model/DatabaseEvents.dart';
import 'package:TODO/model/Item.dart';

class DBBloc implements BlocBase{

  /*final _itemcontroller = StreamController<List<Item>>.broadcast();

  StreamSink<List<Item>> get _inItems => _itemcontroller.sink;
  Stream<List<Item>> get items => _itemcontroller.stream;

  final _itemaddcontroller = StreamController<Item>.broadcast();
  StreamSink<Item> get addItem => _itemaddcontroller.sink;*/

  final _eventcontroller = StreamController<DatabaseEvent>.broadcast();

  final _itemcontroller = StreamController<List<Item>>.broadcast();

  StreamSink<List<Item>> get _inItems => _itemcontroller.sink;
  Stream<List<Item>> get items => _itemcontroller.stream;

  DBBloc(){
    getItems();
    _eventcontroller.stream.listen(_listener);
  }

  void dispatch(DatabaseEvent event){
    _eventcontroller.sink.add(event);
  }

  void _listener(DatabaseEvent event){
      if(event is InsertItem){
        _addItem(event.item);
      }
      else if(event is GetItems){
        getItems();
      }
      else if(event is UpdateItem){
        _updateItem(event.item);
      }
  }

  Future<List<Item>> getItems() async{
    List<Item> items = await DBProvider.db.getitems();

    _inItems.add(items);
    return items;
  }

  void _addItem(Item item) async{
    await DBProvider.db.newitem(item);

    getItems();
  }

  void _updateItem(Item item) async{
    await DBProvider.db.updateitem(item);

    getItems();
  }

  @override
  void dispose() {
    _itemcontroller.close();
    _eventcontroller.close();
  }

}