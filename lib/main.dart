import 'dart:developer';

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
  bool hasDisplayOverlay = false;

  final addItemController = TextEditingController();

  var itemID = 0;
  List<DoItem> listOfItems = [];

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
            children: listOfItems.map(
                (item) =>
                  Container(
                    child: item,
                  )).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => !hasDisplayOverlay ? addItemOverlay() : hideItemOverlay(),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      )
    );
  }

  void updateList(int currentId, String newItem){
    for(int i = 0; i < listOfItems.length; i++){
      if(listOfItems[i].id == currentId){
        log("$i");
        setState(() {
          listOfItems[i].item = newItem;
          log(listOfItems[i].item);
        });
        break;
      }
    }
  }

  void addItemOverlay(){
    final overlay = Overlay.of(context)!;
    hasDisplayOverlay = true;
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
                          onPressed: () {
                            var itemText = addItemController.text;
                            var doItemBuild = DoItem(itemText, updateList);
                            addItemController.clear();
                            setState(() {
                              listOfItems.add(doItemBuild);
                            });
                            hideItemOverlay();
                          },
                          child: Text(
                            "INSERT",
                          ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addItemController.clear();
                            hideItemOverlay();
                          },
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
  }

  void hideItemOverlay(){
    hasDisplayOverlay = false;
    entry?.remove();
    entry = null;
  }
}

class DoItem extends StatefulWidget{

  String item;
  static var _idCounter = 0;
  late final int id;
  late final void Function(int, String) updateList;

  var editButton = Icons.edit;
  bool isEditMode = false;
  var checkButton = Icons.radio_button_unchecked;

  final editController = TextEditingController();

  dynamic textField;

  late final Text itemTextField;
  late final TextField editItemField;

  DoItem(this.item, this.updateList){
    id = _idCounter++;
    itemTextField = Text(
      item,
    );
    editItemField = TextField(
      controller: editController,
      decoration: const InputDecoration(
        hintText: "Edit your item",
      ),
    );

    textField = itemTextField;
  }

  @override
  State<DoItem> createState() => _DoItemState();
}

class _DoItemState extends State<DoItem> {

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        IconButton(
            onPressed: null,
            icon: Icon(
              widget.checkButton,
            )
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: widget.textField,
          ),
        ),
        IconButton(
            onPressed: () {
              if(!widget.isEditMode){
                setState(() {
                  widget.editController.text = widget.item;
                  widget.textField = widget.editItemField;
                  widget.editButton = Icons.check;
                });
                widget.isEditMode = true;
              }
              else{
                setState(() {
                  widget.item = widget.editController.text;
                  widget.updateList(widget.id, widget.item);
                  widget.editController.clear();
                  widget.editButton = Icons.edit;
                  widget.textField = widget.itemTextField;
                });
                widget.isEditMode = false;
              }
            },
            icon: Icon(
              widget.editButton,
            )
        ),
      ],
    );
  }
}