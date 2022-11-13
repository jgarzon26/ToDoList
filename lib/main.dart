import 'package:flutter/material.dart';

main() => runApp(
  MaterialApp(
    home: Home(),
  )
);

class Home extends StatefulWidget{

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var itemID = 0;
  var listOfItems = {};

  @override
  Widget build(BuildContext context){
    return(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("To Do List"),
            actions: [
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.delete,
                  )
              ),
            ],
          ),
          body: ListView(
            children: [

            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      )
    );
  }
}

class DoItem extends StatelessWidget{

  String item;

  DoItem(String this.item);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.radio_button_unchecked,
              )
          ),
          Text(
            item,
          ),
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.edit,
              )
          ),
        ],
      ),
    );
  }
}