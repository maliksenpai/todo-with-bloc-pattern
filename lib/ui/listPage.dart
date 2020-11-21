import 'dart:developer';
import 'dart:developer';
import 'package:TODO/bloc/BlocProvider.dart';
import 'package:TODO/bloc/DBBloc.dart';
import 'package:TODO/bloc/TodoBloc.dart';
import 'package:TODO/model/DatabaseEvents.dart';
import 'file:///C:/Users/asus/Desktop/androidler/kronastatistic/lib/model/Events.dart';
import 'package:TODO/model/Item.dart';
import 'package:TODO/ui/todoDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listPage extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "List",
      home: BlocProvider(
        bloc: DBBloc(),
        child: liststate(),
      ),
    );
    //throw UnimplementedError();
  }}

class liststate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _listPage();
    throw UnimplementedError();
  }

}


class _listPage extends State<liststate>{
  final _bloc = TodoBloc();
  DBBloc _dbBloc;

  @override
  Widget build(BuildContext context) {

    _dbBloc = BlocProvider.of<DBBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _showDialog(context, _dbBloc);
        },
      ),
      body: StreamBuilder(
        stream: _dbBloc.items,
        builder: (BuildContext context, AsyncSnapshot<List<Item>> data){


          if(!data.hasData){
            return Center(
              child: Text("Liste bos"),
            );
          }
          var list = data.data;
          log(list.toString());
          return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                  onTap: (){ /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=> todoDetail())); */} ,
                  title: Text(list[index].title),
                  trailing: data.data[index].completed==0?
                      IconButton(icon: Icon(Icons.done),onPressed: () { var _item = list[index]; _item.completed = 1; _dbBloc.dispatch(UpdateItem(item: _item)); },):
                      IconButton(icon: Icon(Icons.done_all),onPressed: () { var _item = list[index]; _item.completed = 0; _dbBloc.dispatch(UpdateItem(item: _item));  } ,),
                );
              }
          );

      },
      ),
    );
    throw UnimplementedError();
  }



  _showDialog(BuildContext context,DBBloc bloc) async{
    TextEditingController _controller = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text("Yeni bir iş ekle"),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "İş"
                  ),
                  controller: _controller,
                  autofocus: true,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Kaydet"),
              onPressed: (){
                if(_controller.text != ''){
                  //bloc.dispatch(AddEvent(item: Item(title: _controller.text.toString(),completed: 0)));
                  bloc.dispatch(InsertItem(item: Item(title: _controller.text.toString(),completed: 0)));
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      }
    );
  }


}

