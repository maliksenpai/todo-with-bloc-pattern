import 'dart:async';

import 'file:///C:/Users/asus/Desktop/androidler/kronastatistic/lib/model/Events.dart';
import 'package:TODO/model/Item.dart';

class TodoBloc{
  List<Item> items = [];

  final _todoEventController = StreamController<TodoEvent>();
  //Sink<TodoEvent> get todoEventSink => _todoEventController.sink;

  final _todoStateController = StreamController<List<Item>>();
  StreamSink<List<Item>> get _inTodoSink => _todoStateController.sink;
  Stream<List<Item>> get todos => _todoStateController.stream;

  TodoBloc(){
    _todoEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TodoEvent event) {
    if (event is AddEvent) {
      items.add(event.item);
    } else if (event is DeleteEvent) {
      items.removeAt(event.index);
    } else if (event is DoneEvent) {
      items.asMap().forEach((index, todo) {
        if (index == event.index) {
          todo.completed = 1;
        }
      });
    } else if (event is NotDoneEvent) {
      items.asMap().forEach((index, todo) {
        if (index == event.index) {
          todo.completed = 0;
        }
      });
    }

    _inTodoSink.add(items);
  }

  void dispatch(TodoEvent event) {
    _todoEventController.sink.add(event);
  }

  void dispose() {
    _todoEventController.close();
    _todoStateController.close();
  }
}
