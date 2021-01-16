import 'package:flutter/material.dart';
import 'package:flutter_grid_view/female_item.dart';

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<FemaleItem> _femaleItemList;
  List<FemaleItem> femaleItem = [];
  FemaleItem femaleItemData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFemaleItemList();
  }

  _updateFemaleItemList() async {
    _femaleItemList = femaleItem;
    setState(() {
      femaleItem = _femaleItemList;
    });
  }

  _myCardView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: femaleItem == null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Container()),
            )
          : Container(
              height: femaleItem.length == 0
                  ? MediaQuery.of(context).size.height
                  : null,
              width: femaleItem.length == 0
                  ? MediaQuery.of(context).size.width
                  : null,
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    elevation: 4,
                    color: Colors.cyan,
                    child: Container(
                      child: Text(
                        femaleItem[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                itemCount: femaleItem.length,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateFemaleItemList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: _myCardView(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Create an female item"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (input) => input.trim().isEmpty
                              ? "Please enter your item."
                              : null,
                          autofocus: true,
                          controller: itemController,
                          decoration: InputDecoration(hintText: "Item"),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        itemController.clear();
                      },
                      child: Text(
                        "Cancle",
                        style: TextStyle(color: Colors.blue),
                      )),
                  FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          femaleItemData = FemaleItem(
                            name: itemController.text,
                          );
                          print(femaleItemData.name);
                        }
                        femaleItem.add(femaleItemData);
                        Navigator.pop(context);
                        itemController.clear();
                      },
                      child: Text("OK", style: TextStyle(color: Colors.blue)))
                ],
              );
            },
          );
        },
        label: Text('Create'),
      ),
    );
  }
}
