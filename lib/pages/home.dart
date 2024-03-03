//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _toDo = [];
  int _selected_index = -1;
  String _userToDO = '';

  @override
  void initState() {
    super.initState();
    _toDo.addAll([]);
  }

  Widget _createTask(BuildContext context, int index) {
    return Slidable(
        key: Key(_toDo[index]),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: (){
              setState(() {
                print("Selected index= $_selected_index, index = $index");
                  _selected_index = -1;
                _toDo.removeAt(index);

              });
              //print("Selected index= $_selected_index, index = $index");
              //print("\nOUT TO DO LIST: $_toDo\n");
            },
          ),
          children: [
            SlidableAction(
              onPressed:(BuildContext context){
               // print("\n\nOUT TO DO LIST: ${_toDo[index]}\n\n");
              },
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              label:'Delete',

            ),
          ],
        ),




        child: ListTile(
      title: Text(_toDo[index],style: TextStyle(
        fontSize: 30,
      )),
      leading: Icon(Icons.check_box_outline_blank),
      onTap: (){
        setState(() {
          print(index);
          _selected_index = index;
        });
      },
          onLongPress: (){
        setState(() {
          _selected_index = -1;
        });
          },
    )


    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           // Padding(padding: EdgeInsets.only(left:20)),
            Text('To do list',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Lost',
                )),
            Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 25,
                )),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            _selected_index == -1
                ? 'Nothing selected'
                 : 'Selected: ${_toDo[_selected_index]}',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Lost',
              color:
                  _selected_index == -1 ? Colors.black54 : Colors.teal.shade900,
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 2,
                );
              },
              itemCount: _toDo.length,
              itemBuilder: _createTask,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Add new task:",
                      style: TextStyle(fontFamily: 'Lost')),
                  content: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      //icon: Icon(Icons.chevron_right),
                    ),
                    onChanged: (text) {
                      _userToDO = text;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _toDo.add(_userToDO);
                        });
                        print(_toDo);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('add',
                              style: TextStyle(
                                fontFamily: 'Lost',
                                fontSize: 20,
                                color: Colors.black,
                              ))),
                    ),
                  ]);
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 45,
        ),
        backgroundColor: Colors.grey.shade50,
        tooltip: 'Добавить задачу',
      ),
    );
  }
}
