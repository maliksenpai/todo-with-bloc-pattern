
import 'package:TODO/model/Item.dart';

abstract class TodoEvent {

}

class AddEvent extends TodoEvent{
  Item item;
  AddEvent({this.item});
}

class DeleteEvent extends TodoEvent{
  int index;
  DeleteEvent({this.index});
}

class DoneEvent extends TodoEvent{
  int index;
  DoneEvent({this.index});
}

class NotDoneEvent extends TodoEvent{
  int index;
  NotDoneEvent({this.index});
}