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
  OverlayEntry? entry;
  TextEditingController? addItemController;

  var itemID = 0;
<<<<<<< HEAD
  var listOfItems = {};
=======
  DoItem listOfItems = {} as DoItem;
>>>>>>> AddingLogic

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
            onPressed: AddItemOverlay,
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      )
    );
  }

  void AddItemOverlay(){
<<<<<<< HEAD
    final overlay = Overlay.of(context)!;
    entry = OverlayEntry(
        builder: (context) {
          return FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.2,
            child: Scaffold(
              body: Column(
                children: [
                  Text(
                    "Something To Do...",
                  ),
                  TextField(
                    controller: addItemController,
                    decoration: InputDecoration(
                      hintText: "Type here",
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "INSERT",
                          ),
                      ),
                      ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "CANCEL",
                          ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
    overlay.insert(entry!);
=======
    entry = OverlayEntry(
        builder: (context) {
          return Column(
            children: [
              Text(
                "Something To Do...",
              ),
              TextField(
                controller: addItemController,
                decoration: InputDecoration(
                  hintText: "Type here",
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: null,
                      child: Text(
                        "INSERT",
                      ),
                  ),
                  ElevatedButton(
                      onPressed: null,
                      child: Text(
                        "CANCEL",
                      ),
                  ),
                ],
              )
            ],
          );
        }
    );
>>>>>>> AddingLogic
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