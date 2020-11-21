import 'package:meta/meta.dart';

class Item{
  Item({@required this.title, this.completed = 0});
  String title;
  int completed;

  factory Item.fromJson(Map<String ,dynamic> json) => new Item(title: json["title"], completed: json["completed"]);

  Map <String, dynamic> toJson() => {
    "title" : title,
    "completed" : completed
  };
}