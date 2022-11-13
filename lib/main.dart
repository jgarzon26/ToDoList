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