import 'package:TODO/model/Item.dart';

abstract class DatabaseEvent{

}

class CreateDatabase extends DatabaseEvent{
  CreateDatabase();
}

class GetItems extends DatabaseEvent{
  GetItems();
}

class InsertItem extends DatabaseEvent{
  Item item;
  InsertItem({this.item});
}

class UpdateItem extends DatabaseEvent{
  Item item;
  UpdateItem({this.item});
}