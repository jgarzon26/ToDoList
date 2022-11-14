import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
            backgroundColor: Color.fromRGBO(2, 79, 169, 100),
            title: Text(
                "To Do List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      listOfItems = [];
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 32,
                  )
              ),
            ],
          ),
          body: ListView(
            children: listOfItems.map(
                (item) =>
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    widthFactor: 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(78, 129, 232, 100),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: item,
                      ),
                    ),
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
            alignment: const Alignment(0, 0.7),
            widthFactor: 0.8,
            heightFactor: 0.25,
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(78, 129, 232, 100),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Something To Do...",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    TextField(
                      controller: addItemController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Type here",
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  var itemText = addItemController.text;
                                  var doItemBuild = DoItem(itemText, updateList);
                                  addItemController.clear();
                                  setState(() {
                                    listOfItems.add(doItemBuild);
                                  });
                                  hideItemOverlay();
                                },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.green),
                              ),
                                child: const Text(
                                  "INSERT",
                                ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  addItemController.clear();
                                  hideItemOverlay();
                                },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red),
                              ),
                                child: Text(
                                  "CANCEL",
                                ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
    editItemField = TextField(
      autofocus: true,
      controller: editController,
      decoration: const InputDecoration(
        hintText: "Edit your item",
      ),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
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
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.checkButton = Icons.radio_button_checked;
                });
              },
              icon: Icon(
                widget.checkButton,
                size: MediaQuery.of(context).size.width * 0.07,
                color: Colors.white,
              )
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: widget.textField,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
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
                size: MediaQuery.of(context).size.width * 0.07,
                color: Colors.white,
              )
          ),
        ),
      ],
    );
  }
}